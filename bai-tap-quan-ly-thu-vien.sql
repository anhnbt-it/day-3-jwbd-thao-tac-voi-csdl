-- Library Management System

CREATE DATABASE `libproject_db`;
DROP DATABASE `libproject_db`;
USE `libproject_db`;

-- Tables
-- Tạo bảng `category` chứa các phân loại sách khác nhau
CREATE TABLE `tbl_category` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  `image` VARCHAR(200) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- Tạo bảng `books` chứa thông tin liên quan đến sách
CREATE TABLE `tbl_books` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT, -- Mã sách
  `category_id` INT UNSIGNED NOT NULL, -- Thể loại
  `title` VARCHAR(50) NOT NULL, -- Tên sách
  `publisher` VARCHAR(50) NULL DEFAULT NULL, -- Nhà xuất bản
  `author` VARCHAR(50) NULL DEFAULT NULL, -- Tác giả
  `publication_year` DATE NULL DEFAULT NULL, -- Năm xuất bản
  `price` DECIMAL(10,2) NULL DEFAULT NULL, -- Giá
  `image` VARCHAR(200) NULL DEFAULT NULL, -- Ảnh
  `qty` INT NULL DEFAULT NULL, -- Số lượng
  `status` ENUM('borrowing', 'available') NULL DEFAULT NULL, -- Trạng thái của sách
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `books_category_id_fk` (`category_id`),
  CONSTRAINT `books_category_id_fk`
    FOREIGN KEY (`category_id`)
		REFERENCES `tbl_category` (`id`)
);

-- Tạo bảng `students` chứa thông tin sinh viên
CREATE TABLE `tbl_students` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT, -- Mã sinh viên
  `name` VARCHAR(50) NOT NULL, -- Họ tên
  `address` VARCHAR(500) NULL DEFAULT NULL, -- Địa chỉ
  `email` VARCHAR(50) NULL DEFAULT NULL, -- Email
  `phone` VARCHAR(13) NULL DEFAULT NULL, -- Số điện thoại
  `image` VARCHAR(200) NULL DEFAULT NULL, -- Ảnh minh họa
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, -- Ngày tham gia
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- Tạo bảng `borroworders` chứa thông tin về phiếu mượn
CREATE TABLE `tbl_orders` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT, -- Mã hóa đơn
	`student_id` INT UNSIGNED NOT NULL, -- Sinh viên
	`borrowed_from_date` datetime, -- Ngày mượn
	`borrowed_to_date` datetime, -- Ngày trả
	`actual_return_date` datetime, -- Ngày trả thực tế
	`status` ENUM('datra', 'dangmuon') NULL DEFAULT NULL, -- Trạng thái trả sách
	`created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	KEY `orders_student_id_fk` (`student_id`),
	CONSTRAINT `orders_student_id_fk`
		FOREIGN KEY (`student_id`)
			REFERENCES `tbl_students` (`id`)
);

-- Tạo bảng `tbl_orderdetails` lưu chi tiết mỗi hóa đơn
CREATE TABLE `tbl_orderdetails` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` INT UNSIGNED NOT NULL, -- Mã hóa đơn
	`book_id` INT UNSIGNED NOT NULL, -- Sách mượn
	`qty_ordered` INT UNSIGNED NOT NULL, -- Số lượng
    PRIMARY KEY (`id`),
	KEY `orderdetails_order_id_fk` (`order_id`),
	KEY `orderdetails_book_id_fk` (`book_id`),
    CONSTRAINT `orderdetails_order_id_fk`
		FOREIGN KEY (`order_id`)
			REFERENCES `tbl_orders` (`id`),
	CONSTRAINT `orderdetails_book_id_fk`
		FOREIGN KEY (`book_id`)
			REFERENCES `tbl_books` (`id`)
);

-- Chèn dữ liệu
INSERT INTO `tbl_category` (`name`, `description`, `image`) VALUES
	('Kinh tế', 'Giới thiệu sách Kinh tế', 'sach-kinh-te.jpg'),
	('Quản Trị - Lãnh Đạo', 'Giới thiệu sách Quản trị', 'sach-quan-tri.jpg'),
	('Marketing - Bán Hàng', 'Giới thiệu sách Marketing', 'sach-marketing.jpg'),
	('Ngôn Tình', 'Giới thiệu truyện Ngôn Tình', 'sach-ngon-tinh.jpg'),
	('Tiếng Anh', 'Giới thiệu sách Tiếng Anh', 'sach-tieng-anh.jpg');
SELECT `name`, `description`, `image` FROM `tbl_category`;