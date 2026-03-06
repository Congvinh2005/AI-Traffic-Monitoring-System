import cv2
import os
from ultralytics import YOLO

# Get the directory of this script
script_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(script_dir)

# Paths to model and video
model_path = os.path.join(project_root, "weights", "best_hole.pt")
video_path = os.path.join(project_root, "video_input", "hole.mp4")

model = YOLO(model_path)

cap = cv2.VideoCapture(video_path)


if not cap.isOpened():
    print("Không thể mở video!")
    exit()


fps = int(cap.get(cv2.CAP_PROP_FPS))
width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))


fourcc = cv2.VideoWriter_fourcc(*'mp4v')
out = cv2.VideoWriter("output_seg.mp4", fourcc, fps, (width, height))

print("Đang xử lý video... Nhấn 'q' để thoát sớm")

while True:
    ret, frame = cap.read()
    if not ret:
        break


    results = model(frame, verbose=False)


    for result in results:
        if result.masks is not None:
            # Vẽ mask không hiển thị label, confidence, box dày 1 pixel
            frame = result.plot(labels=False, conf=False, line_width=1)


    cv2.imshow("Phat hien o ga", frame)

    out.write(frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
out.release()
cv2.destroyAllWindows()

print("Hoan thanh! Video output: output_seg.mp4")
