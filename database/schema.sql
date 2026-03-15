CREATE DATABASE HotelBookingDB
GO

USE HotelBookingDB
GO

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(255),
    fullName VARCHAR(255)
);

CREATE TABLE cities (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE hotels (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    city_id INT,
    description NVARCHAR(MAX),
    rating FLOAT,

    FOREIGN KEY (city_id) REFERENCES cities(id)
);


CREATE TABLE rooms (
    id INT IDENTITY(1,1) PRIMARY KEY,
    hotel_id INT,
    room_type VARCHAR(255),
    price FLOAT,
    quantity INT,
    status VARCHAR(50),

    FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

CREATE TABLE bookings (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    total_price DECIMAL(12,2),
    status VARCHAR(255),

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE questions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    hotel_id INT,
    content NVARCHAR(MAX),
    created_at DATETIME,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

CREATE TABLE answers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    question_id INT,
    user_id INT,
    content NVARCHAR(MAX),
    created_at DATETIME,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
)