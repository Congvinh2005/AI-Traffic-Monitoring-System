import shutil
import os

src = r"d:\AI\AI-Traffic-Monitoring-System\py\Web\static\car1.jpg"
dst_dir = r"d:\AI\AI-Traffic-Monitoring-System\py\Web\static\images"
dst = os.path.join(dst_dir, "car1.jpg")

if not os.path.exists(dst_dir):
    os.makedirs(dst_dir)

if os.path.exists(src):
    shutil.move(src, dst)
    print(f"Moved {src} to {dst}")
else:
    print(f"Source {src} not found")
