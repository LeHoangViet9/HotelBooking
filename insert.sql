INSERT INTO users (email,password,phone,role,fullName) VALUES
('admin@gmail.com','123','0900000000','ADMIN','Le Hoang Viet'),
('viet@gmail.com','123','0900000001','USER','Le Hoang Viet'),
('ha@gmail.com','123','0900000002','USER','Tran Trinh Ngoc Ha'),
('minh@gmail.com','123','0900000003','USER','Nguyen Van Minh'),
('lan@gmail.com','123','0900000004','USER','Tran Thi Lan'),
('tuan@gmail.com','123','0900000005','USER','Le Anh Tuan'),
('linh@gmail.com','123','0900000006','USER','Pham Thu Linh'),
('hung@gmail.com','123','0900000007','USER','Do Van Hung'),
('hoa@gmail.com','123','0900000008','USER','Nguyen Thi Hoa'),
('son@gmail.com','123','0900000009','USER','Pham Quang Son');

INSERT INTO cities (name) VALUES
('Ha Noi'),
('Da Nang'),
('Ho Chi Minh'),
('Hue'),
('Nha Trang'),
('Da Lat'),
('Hai Phong'),
('Can Tho'),
('Phu Quoc'),
('Quang Ninh');

INSERT INTO hotels (name,address,city_id,description) VALUES
('Sunshine Hotel','Hoan Kiem, Ha Noi',1,'Hotel in city center'),
('Ocean View Hotel','My Khe Beach, Da Nang',2,'Beautiful sea view'),
('Saigon Luxury Hotel','District 1',3,'Luxury hotel'),
('Hue Royal Hotel','Hue Center',4,'Royal style hotel'),
('Nha Trang Paradise','Beach Road',5,'Near beach'),
('Da Lat Garden Hotel','Da Lat Hills',6,'Cool weather'),
('Hai Phong Harbor Hotel','City Port',7,'Harbor view'),
('Can Tho Riverside Hotel','Mekong River',8,'River view'),
('Phu Quoc Resort','Island Center',9,'Resort near beach'),
('Ha Long Bay Hotel','Ha Long Bay',10,'Beautiful bay view');


INSERT INTO rooms (hotel_id,room_type,price,quantity,status) VALUES
(1,'Standard Room',50,10,'AVAILABLE'),
(1,'Deluxe Room',80,5,'AVAILABLE'),
(2,'Sea View Room',120,6,'AVAILABLE'),
(3,'VIP Room',200,3,'AVAILABLE'),
(4,'Family Room',100,4,'AVAILABLE'),
(5,'Luxury Suite',250,2,'AVAILABLE'),
(6,'Garden View Room',90,5,'AVAILABLE'),
(7,'City View Room',70,8,'AVAILABLE'),
(8,'River View Room',110,4,'AVAILABLE'),
(9,'Island Villa',300,2,'AVAILABLE');


INSERT INTO bookings (user_id,room_id,check_in,check_out,total_price,status) VALUES
(2,1,'2026-03-20','2026-03-22',100,'CONFIRMED'),
(3,2,'2026-03-21','2026-03-23',160,'CONFIRMED'),
(4,3,'2026-03-22','2026-03-24',240,'CONFIRMED'),
(5,4,'2026-03-23','2026-03-25',400,'CONFIRMED'),
(6,5,'2026-03-24','2026-03-26',200,'CONFIRMED'),
(7,6,'2026-03-25','2026-03-27',500,'CONFIRMED'),
(8,7,'2026-03-26','2026-03-28',180,'CONFIRMED'),
(9,8,'2026-03-27','2026-03-29',140,'CONFIRMED'),
(10,9,'2026-03-28','2026-03-30',220,'CONFIRMED'),
(2,10,'2026-03-29','2026-03-31',600,'CONFIRMED');


INSERT INTO questions (user_id,hotel_id,content,created_at) VALUES
(2,1,'Khach san co wifi khong?',GETDATE()),
(3,2,'Co bao gom bua sang khong?',GETDATE()),
(4,3,'Khach san co ho boi khong?',GETDATE()),
(5,4,'Phong co may lanh khong?',GETDATE()),
(6,5,'Co cho do xe khong?',GETDATE()),
(7,6,'Co dua don san bay khong?',GETDATE()),
(8,7,'Cho phep thu cung khong?',GETDATE()),
(9,8,'Co the checkout muon khong?',GETDATE()),
(10,9,'Khach san co phong gym khong?',GETDATE()),
(2,10,'Phong co ban cong khong?',GETDATE());


INSERT INTO answers (question_id,user_id,content,created_at) VALUES
(1,1,'Co wifi mien phi',GETDATE()),
(2,1,'Phong deluxe co bua sang',GETDATE()),
(3,1,'Khach san co ho boi ngoai troi',GETDATE()),
(4,1,'Tat ca phong deu co may lanh',GETDATE()),
(5,1,'Co cho do xe mien phi',GETDATE()),
(6,1,'Co dich vu dua don san bay',GETDATE()),
(7,1,'Mot so phong cho phep thu cung',GETDATE()),
(8,1,'Checkout muon tuy thuoc phong',GETDATE()),
(9,1,'Co phong gym',GETDATE()),
(10,1,'Mot so phong co ban cong',GETDATE());


