import sys
import traceback
sys.path.append(r'd:\AI\AI-Traffic-Monitoring-System\py\Web')
from drive_auth import app

app.testing = True
client = app.test_client()
with client.session_transaction() as sess:
    sess['user_id'] = 1
    sess['role'] = 'admin'

try:
    res = client.get('/dashboard?page=1')
    print('Status:', res.status_code)
    if res.status_code != 200:
        print(res.data.decode('utf-8'))
except Exception as e:
    traceback.print_exc()
