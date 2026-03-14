-- Migration script to add start and end coordinates to tuyen_duong table
-- Run this script to update your existing database
-- Usage: mysql -u root -p giam_sat < migrate_routes_add_coordinates.sql

USE giam_sat;

-- Step 1: Add new columns for start and end coordinates if they don't exist
ALTER TABLE tuyen_duong 
ADD COLUMN IF NOT EXISTS start_lat DECIMAL(10,8) DEFAULT NULL AFTER mo_ta,
ADD COLUMN IF NOT EXISTS start_lng DECIMAL(11,8) DEFAULT NULL AFTER start_lat,
ADD COLUMN IF NOT EXISTS end_lat DECIMAL(10,8) DEFAULT NULL AFTER start_lng,
ADD COLUMN IF NOT EXISTS end_lng DECIMAL(11,8) DEFAULT NULL AFTER end_lat;

-- Step 2: Update existing routes with sample start and end coordinates
-- You can modify these coordinates to match your actual route locations

-- Route: hanoi - Tuyến Võ Chí Công - Hà Nội
UPDATE tuyen_duong 
SET 
  start_lat = 21.0450, start_lng = 105.7950,  -- Điểm đầu: Khu vực Hồ Tây
  end_lat = 21.0562, end_lng = 105.8148      -- Điểm cuối: Khu vực Cầu Giấy
WHERE id = 'hanoi';

-- Route: hadong - Khu vực Hà Đông
UPDATE tuyen_duong 
SET 
  start_lat = 20.9650, start_lng = 105.7650,  -- Điểm đầu: Bến xe Yên Nghĩa
  end_lat = 20.9788, end_lng = 105.7882      -- Điểm cuối: Trung tâm Hà Đông
WHERE id = 'hadong';

-- Route: thanhxuan - Đường Nguyễn Trãi - Thanh Xuân
UPDATE tuyen_duong 
SET 
  start_lat = 20.9850, start_lng = 105.7950,  -- Điểm đầu: Ngã Tư Sở
  end_lat = 21.0018, end_lng = 105.8206      -- Điểm cuối: Khu vực Thanh Xuân Trung tâm
WHERE id = 'thanhxuan';

-- Route: ngatuso - Vòng xuyến Ngã Tư Sở
UPDATE tuyen_duong 
SET 
  start_lat = 21.0000, start_lng = 105.8100,  -- Điểm đầu: Khu vực Trường Chinh
  end_lat = 21.0078, end_lng = 105.8286      -- Điểm cuối: Khu vực Nguyễn Trãi
WHERE id = 'ngatuso';

-- Step 3: Verify the updates
SELECT 
  id,
  ten_tuyen,
  start_lat,
  start_lng,
  end_lat,
  end_lng,
  trang_thai
FROM tuyen_duong
ORDER BY id;

-- Migration complete!
-- The routes now have start and end coordinates for map display
