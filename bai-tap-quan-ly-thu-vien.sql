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
  `title` VARCHAR(200) NOT NULL, -- Tên sách
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
	`borrowed_from_date` datetime NULL DEFAULT NULL, -- Ngày mượn
	`borrowed_to_date` datetime NULL DEFAULT NULL, -- Ngày trả
	`actual_return_date` datetime NULL DEFAULT NULL, -- Ngày trả thực tế
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

-- Chèn dữ liệu vào bảng `tbl_category`
INSERT INTO `tbl_category` (`name`, `description`, `image`) VALUES
	('Kinh tế', 'Giới thiệu sách Kinh tế', 'sach-kinh-te.jpg'),
	('Quản Trị - Lãnh Đạo', 'Giới thiệu sách Quản trị', 'sach-quan-tri.jpg'),
	('Marketing - Bán Hàng', 'Giới thiệu sách Marketing', 'sach-marketing.jpg'),
	('Ngôn Tình', 'Giới thiệu truyện Ngôn Tình', 'sach-ngon-tinh.jpg'),
	('Tiếng Anh', 'Giới thiệu sách Tiếng Anh', 'sach-tieng-anh.jpg');
SELECT `id`, `name`, `description`, `image` FROM `tbl_category`;

-- Chèn dữ liệu vào bảng `tbl_books`
INSERT INTO `tbl_books` (`category_id`, `title`, `publisher`, `author`, `publication_year`, `price`, `image`,
`qty`, `status`) VALUES
(1, 'Kinh Tế Học Vi Mô (2020)', 'Cengage', 'NGregory Mankiw', '2020-11-16', '275500', 'kinh-te-vi-mo.jpg', 10, 'available'),
(2, 'OKR - Phương Pháp Thiết Lập Mục Tiêu Và Quản Lý Công Việc', 'NXB Công Thương', 'Kazuhiro Okuda', '2020-11-16', '88000', 'okr.jpg', 10, 'available'),
(3, 'Hiệu Ứng Chim Mồi (Tập 1)', 'NXB Kinh tế TP.Hồ Chí Minh', 'Hạo Nhiên, Quốc Khánh', '2020-11-16', '60000', 'hieu-ung-chim-moi.jpg', 10, 'available'),
(4, 'Góc Phố', 'NXB Hà Nội', 'Vệ Ly', '2020-11-16', '51300', 'goc-pho.jpg', 10, 'available'),
(5, 'Bộ Sách Truyện Tranh Song Ngữ Việt - Anh', 'NXB Phu Nữ', 'Sirilak Rattanasuwaj, Kannawan Pannawan', '2020-11-16', '144000', 'truyen-tranh-song-ngu.jpg', 10, 'available');
SELECT * FROM `tbl_books`;

-- Chèn dữ liệu vào bảng `tbl_students`
INSERT INTO `tbl_students` (`name`, `address`, `email`, `phone`, `image`) VALUES 
	('Nguyễn Bá Tuấn Anh', 'Bắc Giang', 'anhnbt.it@gmail.com', '0346868928', 'anhnbt.jpg'),
    ('Nguyễn Bá Tùng Lâm', 'Hà Nội', 'tunglam1506@icloud.com', '0975737642', 'lamnbt.jpg'),
    ('Nguyễn Thị Hồng', 'Thái Nguyên', 'honganh141018@gmail.com', '0963963028', 'hongnt.jpg'),
    ('Nguyễn Bá Sơn', 'Bắc Giang', 'nguyenbason1963@gmail.com', '0974367785', 'sonnb.jpg'),
    ('Nông Thị Chiến', 'Cao Bằng', 'nongthichien1965@gmail.com', '03455286960', 'chiennt.jpg');
SELECT * FROM `tbl_students`;

-- Chèn dữ liệu vào bảng `tbl_orders`
INSERT INTO `tbl_orders` (`student_id`, `borrowed_from_date`, `borrowed_to_date`, `status`) VALUES
	(1, '2020-11-16 06:05:00', '2020-11-26 06:05:00', 'dangmuon'),
    (2, '2020-11-17 06:05:00', '2020-11-27 06:10:00', 'dangmuon'),
    (3, '2020-11-18 06:05:00', '2020-11-28 06:15:00', 'dangmuon'),
    (4, '2020-11-19 06:05:00', '2020-11-29 06:20:00', 'dangmuon'),
    (5, '2020-11-20 06:05:00', '2020-11-30 06:25:00', 'dangmuon');
SELECT * FROM `tbl_orders`;

-- Chèn dữ liệu vào bảng `tbl_orderdetails`
INSERT INTO `tbl_orderdetails` (`order_id`, `book_id`, `qty_ordered`) VALUES
	(1, 6, 1),
    (2, 7, 2),
    (3, 8, 3),
    (4, 9, 4),
    (5, 10, 5);
SELECT * FROM `tbl_orderdetails`;

-- Lấy danh sách hóa đơn
SELECT `tbl_students`.`name`, `tbl_books`.`title`, `tbl_books`.`price`, `tbl_orderdetails`.`qty_ordered`, SUM(`tbl_books`.`price` * `tbl_orderdetails`.`qty_ordered`) AS `total_price`, `tbl_orders`.`borrowed_from_date`
	FROM `tbl_orders`
		INNER JOIN `tbl_orderdetails`
			ON `tbl_orders`.`id` = `tbl_orderdetails`.`order_id`
				INNER JOIN `tbl_books`
					ON `tbl_books`.`id` = `tbl_orderdetails`.`book_id`
						INNER JOIN `tbl_students` 
							ON `tbl_orders`.`student_id` = `tbl_students`.`id`
								GROUP BY `tbl_orders`.`id`;