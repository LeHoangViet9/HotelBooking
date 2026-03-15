USE HotelBookingDB
GO

INSERT INTO cities(name) VALUES
('Ha Noi'),
('Ho Chi Minh'),
('Da Nang'),
('Nha Trang'),
('Da Lat'),
('Hue'),
('Phu Quoc');
select * from cities

INSERT INTO users(email,password,phone,role,fullName) VALUES
('admin@gmail.com','123','0900000001','ADMIN','Admin'),
('john@gmail.com','123','0900000002','USER','John Doe'),
('anna@gmail.com','123','0900000003','USER','Anna Smith'),
('david@gmail.com','123','0900000004','USER','David Lee'),
('lisa@gmail.com','123','0900000005','USER','Lisa Tran');

select * from users

INSERT INTO hotels(name,address,city_id,description,rating) VALUES
('Sunrise Hotel','Hoan Kiem',1,'Hotel near Hoan Kiem lake',4.5),
('Golden Lake Hotel','Ba Dinh',1,'Luxury hotel with lake view',4.7),

('Saigon Center Hotel','District 1',2,'Hotel in city center',4.3),
('Riverside Hotel','District 1',2,'Beautiful river view',4.4),

('Dragon Bridge Hotel','Hai Chau',3,'Near Dragon Bridge',4.2),

('Beach Paradise','Tran Phu',4,'Beach front hotel',4.6),

('Pine Hill Hotel','Da Lat Center',5,'Cool mountain view',4.5),

('Pearl Island Resort','Phu Quoc Beach',7,'Luxury island resort',4.8);


INSERT INTO rooms(hotel_id,room_type,price,quantity,status) VALUES
(1,'Standard',500000,10,'available'),
(1,'Deluxe',800000,5,'available'),

(2,'Standard',600000,7,'available'),
(2,'Suite',1200000,3,'available'),

(3,'Standard',450000,8,'available'),
(3,'Deluxe',750000,4,'available'),

(4,'Standard',500000,6,'available'),

(5,'Standard',400000,10,'available'),
(5,'Deluxe',650000,4,'available'),

(6,'Standard',700000,8,'available'),
(6,'Deluxe',1100000,3,'available'),

(7,'Standard',550000,5,'available'),

(8,'Villa',2000000,2,'available');


INSERT INTO bookings(user_id,room_id,check_in,check_out,total_price,status) VALUES
(2,1,'2026-04-01','2026-04-03',1000000,'confirmed'),
(3,2,'2026-04-05','2026-04-06',800000,'confirmed'),
(4,3,'2026-04-10','2026-04-12',1200000,'pending'),
(5,5,'2026-04-15','2026-04-17',900000,'confirmed'),
(2,6,'2026-04-20','2026-04-22',1500000,'pending')

INSERT INTO questions(user_id,hotel_id,content,created_at) VALUES
(2,1,'Does the hotel have free wifi?',GETDATE()),
(3,3,'Is breakfast included?',GETDATE()),
(4,6,'How far is the beach?',GETDATE());

INSERT INTO answers(question_id,user_id,content,created_at) VALUES
(1,1,'Yes, free wifi is available.',GETDATE()),
(2,1,'Breakfast is included in the price.',GETDATE()),
(3,1,'The beach is about 100 meters away.',GETDATE())
