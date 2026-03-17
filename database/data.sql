USE HotelBookingDB
GO

-- ============================================================
-- MIGRATIONS (run safely if DB already exists)
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='hotels' AND COLUMN_NAME='image')
    ALTER TABLE hotels ADD image VARCHAR(255);
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='rooms' AND COLUMN_NAME='image')
    ALTER TABLE rooms ADD image VARCHAR(255);
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='reviews')
BEGIN
    CREATE TABLE reviews (
        id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        hotel_id INT NOT NULL,
        rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
        comment NVARCHAR(MAX),
        created_at DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (hotel_id) REFERENCES hotels(id)
    );
END
GO

-- ============================================================
-- CITIES
-- ============================================================
INSERT INTO cities(name) VALUES
('Ha Noi'), ('Ho Chi Minh'), ('Da Nang'),
('Nha Trang'), ('Da Lat'), ('Hue'), ('Phu Quoc');

-- ============================================================
-- USERS
-- ============================================================
INSERT INTO users(email, password, phone, role, fullName) VALUES
('admin@gmail.com',   '123', '0900000001', 'ADMIN', 'Admin'),
('an@gmail.com',      '123', '0901234001', 'USER',  'Nguyen Van An'),
('bich@gmail.com',    '123', '0901234002', 'USER',  'Tran Thi Bich'),
('dung@gmail.com',    '123', '0901234003', 'USER',  'Le Quoc Dung'),
('lan@gmail.com',     '123', '0901234004', 'USER',  'Pham Thi Lan'),
('minh@gmail.com',    '123', '0901234005', 'USER',  'Hoang Van Minh'),
('huong@gmail.com',   '123', '0901234006', 'USER',  'Nguyen Thi Huong'),
('tuan@gmail.com',    '123', '0901234007', 'USER',  'Do Anh Tuan'),
('mai@gmail.com',     '123', '0901234008', 'USER',  'Vu Thi Mai'),
('long@gmail.com',    '123', '0901234009', 'USER',  'Dinh Cong Long'),
('hoa@gmail.com',     '123', '0901234010', 'USER',  'Le Thi Hoa'),
('thanh@gmail.com',   '123', '0901234011', 'USER',  'Phan Van Thanh');


-- ============================================================
-- HOTELS
-- ============================================================
INSERT INTO hotels(name, address, city_id, description, rating, image) VALUES
('Sunrise Hotel',          'Hoan Kiem',       1, 'Khach san 4 sao gan ho Hoan Kiem',         4.5, 'Sunrise.webp'),
('Golden Lake Hotel',      'Ba Dinh',         1, 'Khach san cao cap view ho Tay',             4.7, 'Golden_Lake.webp'),
('Metropole Ha Noi',       'Hoan Kiem',       1, 'Khach san 5 sao lich su trung tam thu do',  4.9, 'Sunrise.webp'),
('Saigon Center Hotel',    'Quan 1',          2, 'Khach san hien dai trung tam TP HCM',       4.3, 'Sai_Gon_Center.jpg'),
('Riverside Hotel',        'Quan 1',          2, 'View dep song Sai Gon',                     4.4, 'Riverside.jpg'),
('Liberty Central Saigon', 'Quan 3',          2, 'Boutique hotel sang trong khu trung tam',   4.6, 'Sai_Gon_Center.jpg'),
('Dragon Bridge Hotel',    'Hai Chau',        3, 'Gan cau Rong - vi tri thuan tien',          4.2, 'Dragon_Bridge.png'),
('Danang Marriott Resort', 'My Khe Beach',    3, 'Resort 5 sao tren bai bien My Khe',        4.8, 'Dragon_Bridge.png'),
('Beach Paradise',         'Tran Phu',        4, 'Ngay sat bien Nha Trang',                   4.6, 'Beach_Paradise_.webp'),
('Vinpearl Nha Trang',     'Nha Trang Bay',  4, 'Khu nghi duong dang cap quoc te',           4.9, 'Beach_Paradise_.webp'),
('Pine Hill Hotel',        'Da Lat Center',   5, 'Khach san xi lanh huong thong view nui',    4.5, 'Pine_Hill.webp'),
('Dalat Palace Heritage',  'Tran Phu',        5, 'Khach san di san phong cach Phap',          4.7, 'Pine_Hill.webp'),
('Imperial Hotel Hue',     'Pham Ngu Lao',    6, 'Khach san sang trong gan Hoang Thanh',      4.4, 'Sunrise.webp'),
('Pearl Island Resort',    'Phu Quoc Beach',  7, 'Resort sang trong nhat dao Phu Quoc',       4.8, 'Pearl_Island.webp'),
('JW Marriott Phu Quoc',   'Bai Truong',      7, 'Resort 5 sao tren bai bien dai nhat',       5.0, 'Pearl_Island.webp');

-- ============================================================
-- ROOMS (with image)
-- ============================================================
INSERT INTO rooms(hotel_id, room_type, price, quantity, status, image) VALUES
(1,'Standard', 500000, 10,'AVAILABLE','room_standard.jpg'),
(1,'Deluxe',   800000,  5,'AVAILABLE','room_deluxe.jpg'),
(1,'Suite',   1500000,  2,'AVAILABLE','room_suite.jpg'),
(2,'Standard', 600000,  7,'AVAILABLE','room_standard.jpg'),
(2,'Deluxe',  1000000,  4,'AVAILABLE','room_deluxe.jpg'),
(2,'Suite',   1800000,  2,'AVAILABLE','room_suite.jpg'),
(3,'Deluxe',  1500000,  6,'AVAILABLE','room_deluxe.jpg'),
(3,'Suite',   3000000,  2,'AVAILABLE','room_suite.jpg'),
(3,'Villa',   5000000,  1,'AVAILABLE','room_villa.jpg'),
(4,'Standard', 450000,  8,'AVAILABLE','room_standard.jpg'),
(4,'Deluxe',   750000,  4,'AVAILABLE','room_deluxe.jpg'),
(5,'Standard', 500000,  6,'AVAILABLE','room_standard.jpg'),
(5,'Deluxe',   900000,  3,'AVAILABLE','room_deluxe.jpg'),
(6,'Standard', 550000,  5,'AVAILABLE','room_standard.jpg'),
(6,'Deluxe',   950000,  3,'AVAILABLE','room_deluxe.jpg'),
(6,'Suite',   1600000,  1,'AVAILABLE','room_suite.jpg'),
(7,'Standard', 400000, 10,'AVAILABLE','room_standard.jpg'),
(7,'Deluxe',   650000,  4,'AVAILABLE','room_deluxe.jpg'),
(8,'Deluxe',  1200000,  5,'AVAILABLE','room_deluxe.jpg'),
(8,'Suite',   2500000,  2,'AVAILABLE','room_suite.jpg'),
(8,'Villa',   4500000,  1,'AVAILABLE','room_villa.jpg'),
(9,'Standard', 700000,  8,'AVAILABLE','room_standard.jpg'),
(9,'Deluxe',  1100000,  3,'AVAILABLE','room_deluxe.jpg'),
(10,'Deluxe', 1800000,  4,'AVAILABLE','room_deluxe.jpg'),
(10,'Suite',  3500000,  2,'AVAILABLE','room_suite.jpg'),
(10,'Villa',  6000000,  1,'AVAILABLE','room_villa.jpg'),
(11,'Standard',550000,  5,'AVAILABLE','room_standard.jpg'),
(11,'Deluxe',  900000,  3,'AVAILABLE','room_deluxe.jpg'),
(12,'Deluxe', 1200000,  4,'AVAILABLE','room_deluxe.jpg'),
(12,'Suite',  2200000,  2,'AVAILABLE','room_suite.jpg'),
(13,'Standard',480000,  6,'AVAILABLE','room_standard.jpg'),
(13,'Deluxe',  780000,  3,'AVAILABLE','room_deluxe.jpg'),
(13,'Suite',  1400000,  1,'AVAILABLE','room_suite.jpg'),
(14,'Deluxe', 1500000,  4,'AVAILABLE','room_deluxe.jpg'),
(14,'Suite',  3000000,  2,'AVAILABLE','room_suite.jpg'),
(14,'Villa',  5500000,  1,'AVAILABLE','room_villa.jpg'),
(15,'Suite',  4000000,  3,'AVAILABLE','room_suite.jpg'),
(15,'Villa',  8000000,  2,'AVAILABLE','room_villa.jpg');

-- ============================================================
-- BOOKINGS – spread across 12 months for monthly stats chart
-- ============================================================
INSERT INTO bookings(user_id,room_id,check_in,check_out,total_price,status) VALUES
-- Thang 1/2025
(2,  1, '2025-01-03','2025-01-05', 1000000, 'COMPLETED'),
(3,  5, '2025-01-10','2025-01-12', 2000000, 'COMPLETED'),
(4, 10, '2025-01-15','2025-01-17',  900000, 'COMPLETED'),
(5, 17, '2025-01-20','2025-01-22',  800000, 'COMPLETED'),
-- Thang 2/2025
(6, 22, '2025-02-02','2025-02-04', 2200000, 'COMPLETED'),
(7,  2, '2025-02-08','2025-02-10', 1600000, 'COMPLETED'),
(8, 14, '2025-02-14','2025-02-15',  550000, 'COMPLETED'),
(9, 24, '2025-02-20','2025-02-23', 5400000, 'COMPLETED'),
-- Thang 3/2025
(2, 19, '2025-03-01','2025-03-03', 2400000, 'COMPLETED'),
(3,  7, '2025-03-10','2025-03-12',  800000, 'COMPLETED'),
(4, 11, '2025-03-15','2025-03-17', 1500000, 'COMPLETED'),
(5, 28, '2025-03-20','2025-03-22', 1800000, 'COMPLETED'),
-- Thang 4/2025
(10, 9, '2025-04-02','2025-04-04', 3000000, 'COMPLETED'),
(11, 4, '2025-04-08','2025-04-10', 1200000, 'COMPLETED'),
(12,20, '2025-04-15','2025-04-17', 2400000, 'COMPLETED'),
(2, 33, '2025-04-22','2025-04-24', 2160000, 'COMPLETED'),
-- Thang 5/2025
(3,  6, '2025-05-03','2025-05-05', 2000000, 'COMPLETED'),
(4, 15, '2025-05-10','2025-05-12', 1900000, 'COMPLETED'),
(5, 25, '2025-05-18','2025-05-21',10500000, 'COMPLETED'),
(6, 31, '2025-05-25','2025-05-27',  960000, 'COMPLETED'),
-- Thang 6/2025
(7,  3, '2025-06-01','2025-06-03', 3000000, 'COMPLETED'),
(8, 23, '2025-06-10','2025-06-12', 2200000, 'COMPLETED'),
(9, 35, '2025-06-15','2025-06-17', 3000000, 'COMPLETED'),
(10,12, '2025-06-22','2025-06-24', 1000000, 'COMPLETED'),
-- Thang 7/2025
(11,21, '2025-07-04','2025-07-07', 7500000, 'COMPLETED'),
(12, 8, '2025-07-10','2025-07-12', 6000000, 'COMPLETED'),
(2, 26, '2025-07-18','2025-07-20', 1800000, 'COMPLETED'),
(3, 16, '2025-07-25','2025-07-27', 1900000, 'COMPLETED'),
-- Thang 8/2025
(4, 36, '2025-08-02','2025-08-05', 9000000, 'COMPLETED'),
(5,  1, '2025-08-10','2025-08-12', 1000000, 'COMPLETED'),
(6, 34, '2025-08-20','2025-08-22', 3000000, 'COMPLETED'),
(7, 29, '2025-08-25','2025-08-27', 2400000, 'COMPLETED'),
-- Thang 9/2025
(8, 30, '2025-09-03','2025-09-06',10500000, 'COMPLETED'),
(9, 13, '2025-09-10','2025-09-12', 1800000, 'COMPLETED'),
(10, 4, '2025-09-15','2025-09-17', 1200000, 'COMPLETED'),
(11,18, '2025-09-22','2025-09-24', 2400000, 'COMPLETED'),
-- Thang 10/2025
(12, 9, '2025-10-01','2025-10-04', 4500000, 'COMPLETED'),
(2, 22, '2025-10-08','2025-10-10', 2200000, 'COMPLETED'),
(3, 32, '2025-10-15','2025-10-17', 1560000, 'COMPLETED'),
(4,  2, '2025-10-22','2025-10-24', 1600000, 'COMPLETED'),
-- Thang 11/2025
(5, 37, '2025-11-03','2025-11-05', 8000000, 'COMPLETED'),
(6,  6, '2025-11-10','2025-11-12', 2000000, 'COMPLETED'),
(7, 24, '2025-11-18','2025-11-20', 3600000, 'COMPLETED'),
(8, 11, '2025-11-25','2025-11-27', 1500000, 'COMPLETED'),
-- Thang 12/2025
(9, 21, '2025-12-01','2025-12-04',12000000, 'COMPLETED'),
(10,35, '2025-12-10','2025-12-12', 6000000, 'COMPLETED'),
(11, 8, '2025-12-20','2025-12-23', 9000000, 'COMPLETED'),
(12,14, '2025-12-27','2025-12-29', 1100000, 'COMPLETED'),
-- Thang 1/2026
(2,  1, '2026-01-05','2026-01-07', 1000000, 'CONFIRMED'),
(3, 19, '2026-01-10','2026-01-12', 2400000, 'CONFIRMED'),
(4,  9, '2026-01-15','2026-01-17', 3000000, 'CONFIRMED'),
-- Thang 2/2026
(5, 22, '2026-02-03','2026-02-05', 2200000, 'CONFIRMED'),
(6,  5, '2026-02-10','2026-02-12', 2000000, 'CONFIRMED'),
(7, 34, '2026-02-20','2026-02-22', 3000000, 'CONFIRMED'),
-- Thang 3/2026 (hien tai)
(8,  2, '2026-03-01','2026-03-03', 1600000, 'CONFIRMED'),
(9, 10, '2026-03-05','2026-03-07',  900000, 'CONFIRMED'),
(10, 6, '2026-03-10','2026-03-12', 1900000, 'CONFIRMED'),
(11,24, '2026-03-15','2026-03-17', 3600000, 'CONFIRMED'),
-- Pending thang 4/2026
(2, 15, '2026-04-01','2026-04-03', 1900000, 'PENDING'),
(3,  4, '2026-04-05','2026-04-07', 1200000, 'PENDING'),
(4, 20, '2026-04-10','2026-04-12', 2400000, 'PENDING'),
(5, 37, '2026-04-15','2026-04-17', 8000000, 'PENDING'),
(12,28, '2026-04-20','2026-04-22', 1800000, 'PENDING'),
-- Cancelled
(6,  3, '2026-02-10','2026-02-12', 3000000, 'CANCELLED'),
(7, 17, '2026-02-15','2026-02-16',  400000, 'CANCELLED'),
(8, 31, '2026-03-05','2026-03-06',  480000, 'CANCELLED');

-- ============================================================
-- QUESTIONS
-- ============================================================
INSERT INTO questions(user_id, hotel_id, content, created_at) VALUES
(2, 1,  N'Khach san co wifi mien phi khong?',               '2025-03-10 09:00:00'),
(3, 4,  N'Bua sang co duoc bao gom trong gia phong khong?', '2025-04-05 10:00:00'),
(4, 9,  N'Tu khach san den bien mat bao xa?',               '2025-05-18 11:00:00'),
(5, 14, N'Phong co view ra bien khong?',                    '2025-07-20 14:00:00'),
(6, 11, N'Thoi tiet Da Lat thang 4 nhu the nao?',           '2025-08-12 16:00:00');

INSERT INTO answers(question_id, user_id, content, created_at) VALUES
(1, 1, N'Co, wifi mien phi toan bo khach san.',             '2025-03-10 10:00:00'),
(2, 1, N'Co, bua sang da duoc tinh trong gia phong.',       '2025-04-05 11:00:00'),
(3, 1, N'Chi khoang 100 met tu san khach san.',             '2025-05-18 12:00:00'),
(4, 1, N'Tat ca phong Deluxe va Suite deu co view bien.',   '2025-07-20 15:00:00'),
(5, 1, N'Thang 4 mat me, khoang 18-22 do C, rat thich hop.','2025-08-12 17:00:00');

-- ============================================================
-- REVIEWS (users rate hotels after completed stays)
-- ============================================================
INSERT INTO reviews(user_id, hotel_id, rating, comment, created_at) VALUES
(2,  1, 5, N'Khach san rat sach se, nhan vien than thien. Se quay lai!',         '2025-01-06 08:00:00'),
(3,  1, 4, N'Vi tri dep, gan trung tam. Bua sang ngon.',                          '2025-02-10 09:00:00'),
(4,  4, 4, N'Phong rong, thoang mat. Gia hop ly cho TP HCM.',                    '2025-03-18 10:00:00'),
(5,  9, 5, N'Tuyet voi! Bai bien dep, nhan vien nhiet tinh.',                    '2025-05-22 11:00:00'),
(6,  7, 4, N'Gan cau Rong, tien di chuyen. Phong sach.',                         '2025-06-25 12:00:00'),
(7,  3, 5, N'Dich vu 5 sao dung nghia. Sang trong, thoai mai.',                  '2025-07-13 13:00:00'),
(8, 14, 5, N'Resort dep nhat toi tung o. Ho boi rong, view bien tuyet!',         '2025-08-28 14:00:00'),
(9, 10, 5, N'Vinpearl xung dang 5 sao. Moi thu deu hoan hao.',                  '2025-09-16 15:00:00'),
(10, 4, 3, N'Phong oke, nhung dich vu can cai thien them.',                      '2025-10-10 16:00:00'),
(11,11, 4, N'Da Lat rat lang man, khach san o tren nui rat dep.',                '2025-11-27 17:00:00'),
(2,  1, 4, N'Lan nay o phong Deluxe, dep hon lan truoc.',                        '2026-01-08 09:00:00'),
(3,  9, 5, N'Beach Paradise that su la thien duong bien ca.',                    '2026-01-12 10:00:00');
