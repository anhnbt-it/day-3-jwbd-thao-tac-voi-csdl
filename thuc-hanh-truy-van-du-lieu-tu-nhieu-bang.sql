-- Kết nối tới CSDL
USE classicmodels;
-- Sử dụng INNER JOIN để lấy dữ liệu từ hai bảng.
-- Cột chung của 2 bảng là `customerNumber`
SELECT `customers`.`customerNumber`, `customerName`, `phone`, `paymentDate`, `amount`
	FROM `customers` INNER JOIN `payments`
		ON `customers`.`customerNumber` = `payments`.`customerNumber`
			WHERE `city` = 'Las Vegas';

-- Sử dụng LEFT JOIN để lấy dữ liệu từ hai bảng.
-- Cột chung của 2 bảng là `customerNumber`
SELECT `customers`.`customerNumber`, `customers`.`customerName`,
	`orders`.`orderNumber`, `orders`.`status`
		FROM `customers`
			LEFT JOIN `orders`
				ON `customers`.`customerNumber` = `orders`.`customerNumber`
					ORDER BY `customerNumber`;

-- Tìm tất cả khách hàng chưa đặt hàng bất kỳ sản phẩm nào
SELECT `customers`.`customerNumber`, `customers`.`customerName`, `orders`.`orderNumber`,
	`orders`.`status`
		FROM `customers`
			LEFT JOIN `orders`
				ON `customers`.`customerNumber` = `orders`.`customerNumber`
					WHERE `orders`.`orderNumber` IS NULL;