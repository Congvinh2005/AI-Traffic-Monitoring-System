"""
AI Traffic Monitoring System - Controller
Flask routes and application logic
MVC Architecture - Controller Layer
"""

from flask import Flask, render_template, Response, jsonify, request, send_file, make_response, session, redirect, url_for, flash
from flask_cors import CORS
from flask_bcrypt import Bcrypt
from flask_session import Session
from functools import wraps
import pymysql
import os
from datetime import datetime, timedelta
import cv2
import pygame
import threading
import time
import numpy as np

# Import from models
from models import (
    # AI Alert System
    ai_alerts_queue, ai_alerts_lock, current_monitoring_vehicle_id, add_ai_alert,
    
    # Sound & Warning
    latest_warning, lock, warnings, warning_states, previous_warnings, active_video_stream,
    chopmat_sound, ngap_sound, phone_baodong, seatbelt_baodong, dau_quay_sound,
    bienbao_sound, tay_lai_sound, lech_lan_sounds, va_cham_sound, di_cham_lai_sound,
    can_play_warning,
    
    # Video Recording
    video_writer, is_recording, recording_start_time, fps, frame_width, frame_height, video_codec,
    
    # AI Models
    detector, predictor, phone_mau, seatbelt_mau, bienbao_model, model_vehicle, model_lane, model_hole,
    
    # Face Landmark
    EAR_THRESHOLD, EAR_MIN_DURATION, YAWN_THRESHOLD, YAWN_CONSEC_FRAMES,
    left_eye_indexes, right_eye_indexes, mouth_indexes,
    
    # Helper Functions
    eye_aspect_ratio, detect_yawn, get_head_pose,
    
    # Hand Tracking
    hand_detector, HandAndArmTracking,
    
    # Traffic Sign
    PICTURES_DIR, latest_sign_image_path, latest_sign_label,
    
    # Collision Detection
    last_collision_warning, warning_interval, collision_alert_sent, lane_alert_sent,
    process_lane_warning,
    
    # Traffic Monitoring
    region_colors, vehicle_colors, MultipleObjectCounter, counter, video_capture,
    current_region_type, current_location_id, location_video_map,
    get_region_points, init_app,
    
    # Chatbot
    generate_bot_response, call_llm_api, process_ai_chat_message, call_groq_law_advisor, generate_law_response_fallback,
    
    # Lane detection helpers
    estimate_distance, is_in_center_lane, draw_lane_points, draw_lane_classic,
    detect_lane_deviation_combined, collision_monitor, traffic_monitor,
    driver_monitor, traffic_sign_monitor, reset_temporary_counts,
)

# ========================================
# FLASK APP CONFIG
# ========================================
app = Flask(__name__)
app.secret_key = os.urandom(24)
CORS(app)

# Session config
app.config['SESSION_TYPE'] = 'filesystem'
app.config['SESSION_PERMANENT'] = True
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(hours=24)

# MySQL config
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 3306
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'ai_traffic_monitoring'

# Extensions
bcrypt = Bcrypt(app)
Session(app)

# ========================================
# DECORATORS
# ========================================
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            if request.is_json:
                return jsonify({'success': False, 'message': 'Vui lòng đăng nhập'}), 401
            return redirect(url_for('login_page'))
        return f(*args, **kwargs)
    return decorated_function

def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('login_page'))
        if session.get('role') != 'admin':
            flash('Bạn không có quyền truy cập', 'error')
            return redirect(url_for('login_page'))
        return f(*args, **kwargs)
    return decorated_function

# ========================================
# DATABASE CONNECTION
# ========================================
def get_db_connection():
    try:
        return pymysql.connect(
            host=app.config['MYSQL_HOST'],
            port=app.config['MYSQL_PORT'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            database=app.config['MYSQL_DB'],
            cursorclass=pymysql.cursors.DictCursor,
            charset='utf8mb4'
        )
    except Exception as e:
        print(f"DB Error: {e}")
        return None

# ========================================
# AUTHENTICATION ROUTES
# ========================================
@app.route('/login')
def login_page():
    if 'user_id' in session:
        return redirect(url_for('index_page'))
    return render_template('login.html')

@app.route('/api/login', methods=['POST'])
def api_login():
    try:
        data = request.get_json()
        username = data.get('username', '').strip()
        password = data.get('password', '')

        if not username or not password:
            return jsonify({'success': False, 'message': 'Vui lòng nhập đầy đủ'}), 400

        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'message': 'Database error'}), 500

        cur = conn.cursor()
        cur.execute('SELECT id, username, password, role, full_name, is_active FROM users WHERE username = %s', (username,))
        user = cur.fetchone()
        cur.close()
        conn.close()

        if not user:
            return jsonify({'success': False, 'message': 'Tên đăng nhập không tồn tại'}), 401

        if not user['is_active']:
            return jsonify({'success': False, 'message': 'Tài khoản đã bị khóa'}), 403

        if not bcrypt.check_password_hash(user['password'], password):
            return jsonify({'success': False, 'message': 'Mật khẩu không đúng'}), 401

        session.permanent = True
        session['user_id'] = user['id']
        session['username'] = user['username']
        session['role'] = user['role']
        session['full_name'] = user['full_name']

        redirect_url = '/dashboard' if user['role'] == 'admin' else '/trang_chu'

        return jsonify({
            'success': True,
            'message': 'Đăng nhập thành công',
            'redirect': redirect_url,
            'user': {
                'id': user['id'],
                'username': user['username'],
                'full_name': user['full_name'],
                'role': user['role']
            }
        }), 200

    except Exception as e:
        return jsonify({'success': False, 'message': f'Lỗi: {str(e)}'}), 500

@app.route('/api/logout', methods=['POST'])
@login_required
def api_logout():
    session.clear()
    return jsonify({'success': True, 'message': 'Đăng xuất thành công', 'redirect': '/login'}), 200

@app.route('/api/check-auth')
def check_auth():
    if 'user_id' in session:
        return jsonify({
            'authenticated': True,
            'user': {
                'id': session.get('user_id'),
                'username': session.get('username'),
                'role': session.get('role')
            },
            'redirect': '/dashboard' if session.get('role') == 'admin' else '/trang_chu'
        }), 200
    return jsonify({'authenticated': False, 'user': None, 'redirect': None}), 200

@app.route('/')
def index_page():
    """Trang chủ - luôn redirect về login nếu chưa đăng nhập"""
    if 'user_id' in session:
        if session.get('role') == 'admin':
            return redirect(url_for('dashboard_page'))
        else:
            return redirect(url_for('trang_chu_page'))
    else:
        return redirect(url_for('login_page'))

@app.route('/dashboard')
@login_required
@admin_required
def dashboard_page():
    return render_template('Dashboard.html', user=session.get('user'))

@app.route('/trang_chu')
@login_required
def trang_chu_page():
    return render_template('trang_chu.html', user=session.get('user'))

@app.route('/tu_van')
@login_required
def tu_van_page():
    return render_template('tu_van.html', user=session.get('user'))

@app.route('/lai_xe')
@login_required
def lai_xe_page():
    return render_template('lai_xe.html', user=session.get('user'))

@app.route('/lich_su')
@login_required
def lich_su_page():
    return render_template('lich_su.html', user=session.get('user'))

# ========================================
# API ENDPOINTS FOR HISTORY PAGE
# ========================================
@app.route('/api/alerts')
@login_required
def get_alerts():
    """Lấy danh sách cảnh báo AI (vi phạm)"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'message': 'Database error'}), 500

        cur = conn.cursor()
        cur.execute('''
            SELECT a.*, v.plate_number as vehicle_plate, d.full_name as driver_name
            FROM alerts a
            LEFT JOIN vehicles v ON a.vehicle_id = v.id
            LEFT JOIN drivers d ON a.driver_id = d.id
            ORDER BY a.timestamp DESC
            LIMIT 100
        ''')
        alerts = cur.fetchall()
        cur.close()
        conn.close()

        formatted_alerts = []
        for alert in alerts:
            formatted_alerts.append({
                'id': alert['id'],
                'type': alert['type'],
                'message': alert['message'],
                'level': alert['level'],
                'timestamp': alert['timestamp'].isoformat() if alert['timestamp'] else None,
                'vehicle_plate': alert['vehicle_plate'],
                'driver_name': alert['driver_name'],
                'is_read': bool(alert['is_read']),
                'video_path': alert['video_path']
            })

        return jsonify({'success': True, 'alerts': formatted_alerts})
    except Exception as e:
        return jsonify({'success': False, 'message': f'Lỗi: {str(e)}'}), 500

@app.route('/api/alerts/<int:alert_id>/read', methods=['POST'])
@login_required
def mark_alert_as_read(alert_id):
    """Đánh dấu cảnh báo đã đọc"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'message': 'Database error'}), 500

        cur = conn.cursor()
        cur.execute('UPDATE alerts SET is_read = 1 WHERE id = %s', (alert_id,))
        conn.commit()
        cur.close()
        conn.close()

        return jsonify({'success': True, 'message': 'Đã đánh dấu đã đọc'})
    except Exception as e:
        return jsonify({'success': False, 'message': f'Lỗi: {str(e)}'}), 500

@app.route('/api/videos')
@login_required
def get_videos():
    """Lấy danh sách video vi phạm"""
    try:
        video_dir = 'recordings'
        videos = []

        if os.path.exists(video_dir):
            for filename in os.listdir(video_dir):
                if filename.endswith('.mp4'):
                    filepath = os.path.join(video_dir, filename)
                    stat = os.stat(filepath)
                    videos.append({
                        'id': filename,
                        'title': filename.replace('.mp4', '').replace('_', ' ').title(),
                        'path': f'/{filepath}',
                        'thumbnail': f'/static/video-thumbnail.png',
                        'timestamp': datetime.fromtimestamp(stat.st_mtime).isoformat(),
                        'duration': 'N/A',
                        'size': stat.st_size
                    })

        videos.sort(key=lambda x: x['timestamp'], reverse=True)

        return jsonify({'success': True, 'videos': videos[:50]})
    except Exception as e:
        return jsonify({'success': False, 'message': f'Lỗi: {str(e)}'}), 500

@app.route('/api/admin-warnings')
@login_required
def get_admin_warnings():
    """Lấy danh sách cảnh báo từ admin"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'message': 'Database error'}), 500

        cur = conn.cursor()
        cur.execute('''
            SELECT w.*, u.full_name as admin_name
            FROM warnings w
            LEFT JOIN users u ON w.admin_id = u.id
            ORDER BY w.created_at DESC
            LIMIT 100
        ''')
        warnings = cur.fetchall()
        cur.close()
        conn.close()

        formatted_warnings = []
        for warning in warnings:
            formatted_warnings.append({
                'id': warning['id'],
                'vehicle_plate': warning['vehicle_plate'],
                'message': warning['message'],
                'priority': warning['priority'],
                'is_read': bool(warning['is_read']),
                'created_at': warning['created_at'].isoformat() if warning['created_at'] else None,
                'admin_name': warning['admin_name']
            })

        return jsonify({'success': True, 'warnings': formatted_warnings})
    except Exception as e:
        return jsonify({'success': False, 'message': f'Lỗi: {str(e)}'}), 500

@app.route('/api/admin-warnings/<int:warning_id>/read', methods=['POST'])
@login_required
def mark_warning_as_read(warning_id):
    """Đánh dấu cảnh báo admin đã đọc"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'message': 'Database error'}), 500

        cur = conn.cursor()
        cur.execute('UPDATE warnings SET is_read = 1, read_at = NOW() WHERE id = %s', (warning_id,))
        conn.commit()
        cur.close()
        conn.close()

        return jsonify({'success': True, 'message': 'Đã đánh dấu đã đọc'})
    except Exception as e:
        return jsonify({'success': False, 'message': f'Lỗi: {str(e)}'}), 500

# ========================================
# VIDEO STREAMING ROUTES
# ========================================
@app.route('/video_driver')
def video_driver():
    return Response(driver_monitor(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/video_traffic')
def video_traffic():
    return Response(traffic_sign_monitor(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/video_sign')
def video_sign():
    global current_location_id
    location_id = request.args.get('location', None)

    if location_id and location_id in location_video_map:
        current_location_id = location_id
        region_type = location_video_map[location_id]

        global current_region_type, video_capture, active_video_stream
        if region_type != current_region_type:
            active_video_stream = None
            time.sleep(0.5)

            if video_capture is not None:
                video_capture.release()

            current_region_type = region_type
            region_data = get_region_points(region_type)
            video_source = region_data['video_source']

            video_capture = cv2.VideoCapture(video_source)
            if not video_capture.isOpened():
                print(f"Failed to open video for location {location_id}")

            object_classes = [2, 3, 5, 7]
            counter = MultipleObjectCounter(model_path="py/weights/yolov8n.pt",
                                           regions=region_data['regions'],
                                           classes=object_classes)

            active_video_stream = 'traffic'
            print(f"Switched to location: {location_id} ({region_type})")

    return Response(traffic_monitor(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/video_vacham')
def video_vacham():
    return Response(collision_monitor(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/py/video_input/<path:filename>')
def serve_video(filename):
    """Serve video files cho cam hành trình"""
    video_path = os.path.join(os.path.dirname(__file__), '..', 'video_input', filename)
    if os.path.exists(video_path):
        return send_file(video_path)
    return "Video not found", 404

# ========================================
# CONTROL API ROUTES
# ========================================
@app.route('/change_region_points', methods=['POST'])
@login_required
def change_region_points():
    global counter, current_region_type, video_capture, active_video_stream, current_location_id
    try:
        data = request.get_json()
        region_type = data.get('type')
        location_id = data.get('location')

        if location_id and location_id in location_video_map:
            region_type = location_video_map[location_id]
            current_location_id = location_id
        elif region_type in ['single', 'multiple', 'thanhxuan', 'ngatuso']:
            current_location_id = [k for k, v in location_video_map.items() if v == region_type][0]

        if region_type in ['single', 'multiple', 'thanhxuan', 'ngatuso']:
            print(f"Changing to region type: {region_type} (location: {current_location_id})")

            active_video_stream = None
            time.sleep(1)

            if video_capture is not None:
                video_capture.release()
                video_capture = None

            current_region_type = region_type
            region_data = get_region_points(region_type)
            region_points = region_data['regions']
            video_source = region_data['video_source']

            print(f"Using video source: {video_source}")

            if not os.path.exists(video_source):
                print(f"Video file not found: {video_source}")
                return jsonify({"status": "error", "message": f"Không tìm thấy file video: {video_source}"})

            video_capture = cv2.VideoCapture(video_source)
            if not video_capture.isOpened():
                print(f"Failed to open video: {video_source}")
                return jsonify({"status": "error", "message": f"Không thể mở video: {video_source}"})

            video_capture.set(cv2.CAP_PROP_FRAME_WIDTH, 720)
            video_capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 560)
            video_capture.set(cv2.CAP_PROP_FPS, 20)

            print(f"Video capture initialized with properties: {video_capture.get(cv2.CAP_PROP_FRAME_WIDTH)}x{video_capture.get(cv2.CAP_PROP_FRAME_HEIGHT)}")

            object_classes = [2, 3, 5, 7]
            counter = MultipleObjectCounter(model_path="py/weights/yolov8n.pt", regions=region_points, classes=object_classes)

            active_video_stream = 'traffic'

            print("Region change completed successfully")
            return jsonify({"status": "success"})

        return jsonify({"status": "error", "message": "Invalid region type"})
    except Exception as e:
        print(f"Error in change_region_points: {str(e)}")
        return jsonify({"status": "error", "message": str(e)})

@app.route('/toggle_warning', methods=['POST'])
@login_required
def toggle_warning():
    global warning_states
    try:
        data = request.get_json()
        warning_type = data.get('warning_type')
        enabled = data.get('enabled', True)

        if warning_type in warning_states:
            warning_states[warning_type] = enabled
            return jsonify({"status": "success", "enabled": enabled})
        else:
            return jsonify({"status": "error", "message": "Invalid warning type"})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)})

@app.route('/traffic_bus')
def traffic_bus():
    """Serve Dashboard.html với đầy đủ dữ liệu từ drive.py"""
    return render_template('Dashboard.html')

@app.route('/tu_van.html')
@login_required
def tu_van_html():
    """Serve tu_van.html - Trang tư vấn luật giao thông"""
    return render_template('tu_van.html', user=session.get('user'))

@app.route('/lai_xe_v2')
@login_required
def lai_xe_v2_page():
    response = make_response(render_template('lai_xe.html', user=session.get('user')))
    response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    return response

@app.route('/get_warnings')
@login_required
def get_warnings():
    warnings_with_image = warnings.copy()
    warnings_with_image['sign_image'] = latest_sign_image_path
    warnings_with_image['sign_label'] = latest_sign_label
    return jsonify(warnings_with_image)

@app.route('/get_latest_sign_image')
@login_required
def get_latest_sign_image():
    """Trả về hình ảnh biển báo mới nhất"""
    global latest_sign_image_path
    if latest_sign_image_path and os.path.exists(latest_sign_image_path):
        return send_file(latest_sign_image_path, mimetype='image/jpeg')
    return "", 404

@app.route('/get_stats')
@login_required
def get_stats():
    global counter
    return jsonify(counter.get_stats())

@app.route('/set_mode', methods=['POST'])
@login_required
def set_mode():
    global current_mode, active_video_stream
    try:
        data = request.get_json()
        new_mode = data.get('mode', 'driver')

        active_video_stream = None
        time.sleep(0.5)

        current_mode = new_mode
        return jsonify({"status": "success"})
    except Exception as e:
        print(f"Error in set_mode: {str(e)}")
        return jsonify({"status": "error", "message": str(e)})

@app.route('/start_recording')
@login_required
def start_recording():
    global video_writer, is_recording, recording_start_time

    if not is_recording:
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        filename = f'recordings/output_{timestamp}.mp4'

        video_writer = cv2.VideoWriter(
            filename,
            video_codec,
            fps,
            (frame_width, frame_height)
        )

        is_recording = True
        recording_start_time = time.time()
        return "Recording started"
    return "Already recording"

@app.route('/stop_recording')
@login_required
def stop_recording():
    global is_recording, video_writer

    if is_recording and video_writer is not None:
        video_writer.release()
        video_writer = None
        is_recording = False
        return "Recording stopped"
    return "Not recording"

@app.route('/get_video_source/<region_type>')
@login_required
def get_video_source(region_type):
    try:
        region_data = get_region_points(region_type)
        return jsonify({"video_source": region_data['video_source']})
    except Exception as e:
        return jsonify({"error": str(e)}), 400

# ========================================
# CHATBOT & VOICE COMMAND APIs
# ========================================
@app.route('/api/get_ai_warnings')
def api_get_ai_warnings():
    """API để frontend lấy cảnh báo AI hiện tại"""
    return jsonify(warnings)

@app.route('/api/get_ai_alerts_history')
def api_get_ai_alerts_history():
    """API lấy lịch sử cảnh báo AI"""
    with ai_alerts_lock:
        return jsonify({
            'status': 'success',
            'alerts': ai_alerts_queue[-20:]
        })

@app.route('/api/set_monitoring_vehicle', methods=['POST'])
def api_set_monitoring_vehicle():
    """API để thiết lập vehicle_id đang được giám sát"""
    global current_monitoring_vehicle_id
    try:
        data = request.get_json()
        vehicle_id = data.get('vehicle_id')
        current_monitoring_vehicle_id = vehicle_id
        return jsonify({
            'status': 'success',
            'vehicle_id': vehicle_id,
            'message': f'Đang giám sát xe {vehicle_id}'
        })
    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 400

@app.route('/api/process_voice_command', methods=['POST'])
def api_process_voice_command():
    """API xử lý lệnh giọng nói từ frontend"""
    try:
        data = request.get_json()
        command = data.get('command', '').lower()

        response = {
            'status': 'success',
            'action': 'unknown',
            'message': ''
        }

        if 'hiển thị xe' in command or 'tìm xe' in command:
            import re
            plate_match = re.search(r'(\d{1,2}[a-z]-\d{3}\.\d{2})', command, re.IGNORECASE)
            if plate_match:
                response['action'] = 'focus_vehicle'
                response['plate'] = plate_match.group(0).upper()
                response['message'] = f'Tìm xe biển số {plate_match.group(0).upper()}'
            elif 'gần nhất' in command:
                response['action'] = 'find_nearest'
                response['message'] = 'Tìm xe gần nhất'
            else:
                response['action'] = 'help'
                response['message'] = 'Vui lòng nói biển số xe'

        elif 'camera' in command or 'video' in command:
            response['action'] = 'open_camera'
            response['message'] = 'Mở camera tài xế'

        elif 'hỗ trợ' in command or 'chat' in command or 'nhắn tin' in command:
            response['action'] = 'open_chat'
            response['message'] = 'Mở chat hỗ trợ'

        elif 'cảnh báo' in command:
            response['action'] = 'show_alerts'
            response['message'] = 'Hiển thị cảnh báo'

        else:
            response['action'] = 'unknown'
            response['message'] = 'Không hiểu lệnh. Thử: hiển thị xe, mở camera, gọi hỗ trợ'

        return jsonify(response)

    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 400

@app.route('/api/send_chat_message', methods=['POST'])
def api_send_chat_message():
    """API gửi tin nhắn vào chatbot với AI xử lý"""
    try:
        data = request.get_json()
        message = data.get('message', '')
        vehicle_id = data.get('vehicle_id')
        user_id = data.get('user_id', 'anonymous')

        print(f"[CHAT] User {user_id} (xe {vehicle_id}): {message}")

        bot_response = process_ai_chat_message(message, vehicle_id)

        return jsonify({
            'status': 'success',
            'bot_response': bot_response
        })

    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 400

@app.route('/api/groq_law_chat', methods=['POST'])
def api_groq_law_chat():
    """API tư vấn luật giao thông bằng Groq AI"""
    try:
        data = request.get_json()
        message = data.get('message', '')

        print(f"[LAW CHAT] User hỏi: {message}")

        response = call_groq_law_advisor(message)

        return jsonify({
            'status': 'success',
            'response': response
        })

    except Exception as e:
        print(f"Lỗi api_groq_law_chat: {e}")
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 400

# ========================================
# MAIN APPLICATION
# ========================================
if __name__ == '__main__':
    try:
        import webbrowser
        from threading import Timer
        import pygame

        PORT = 5001

        browser_opened = False

        def open_browser():
            global browser_opened
            if not browser_opened:
                url = f'http://localhost:{PORT}/login'
                print(f"\n🌐 Mở browser: {url}")
                webbrowser.open(url)
                browser_opened = True

        init_app()
        threading.Thread(target=reset_temporary_counts, daemon=True).start()

        Timer(2, open_browser).start()

        print("=" * 70)
        print("AI TRAFFIC MONITORING SYSTEM - WITH AUTHENTICATION")
        print("=" * 70)
        print("📋 TÀI KHOẢN:")
        print("  👮 Admin: username=admin, password=admin123")
        print("  👤 User:  username=user, password=user123")
        print("=" * 70)
        print(f"🌐 URL: http://localhost:{PORT}/login")
        print("=" * 70)
        print("💡 Nhấn Ctrl+C để dừng server")
        print("=" * 70)

        app.run(debug=False, host='0.0.0.0', port=PORT, use_reloader=False)
    except Exception as e:
        print(f"Error in main: {str(e)}")
