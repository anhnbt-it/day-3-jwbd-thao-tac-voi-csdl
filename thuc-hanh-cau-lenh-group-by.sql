-- Thực hành câu lệnh GROUP BY
-- Cách truy vấn dữ liệu với mệnh đề group by
-- Sử dụng các hàm tập hợp
-- Sử dụng mệnh đề having
-- So sánh giữa having và where

-- Kiểm tra xem có bao nhiêu trạng thái trong bảng `orders`
-- Câu lệnh này sẽ trả về tất cả trạng thái
SELECT `status`
	FROM `orders`;

-- Bước 1: Sử dụng GROUP BY để trả về chỉ một trạng thái duy nhất 
SELECT `status`
	FROM `orders`
		GROUP BY `status`;

-- Bước 2: Sử dụng các hàm tập hợp với mệnh đồ GROUP BY
-- Các hàm tập hợp (SUM, MAX, MIN, COUNT, AVG) 
-- Câu lệnh này sẽ trả về số đơn hàng của mỗi trạng thái
SELECT `status`, COUNT(`status`)
	AS `total`
		FROM `orders`
			GROUP BY `status`;

-- Bước 3: Sử dụng group by với hàm tập hợp truy vấn trên hai bảng.
SELECT `status`, SUM(`orderdetails`.`quantityOrdered` * `orderdetails`.`priceEach`)
	AS `amound`
		FROM `orders`
			INNER JOIN `orderdetails`
				ON `orders`.`orderNumber` = `orderdetails`.`orderNumber`
					GROUP BY `orders`.`status`;
-- Bước 4: Tính tổng tiền trên mỗi đơn hàng
SELECT `orders`.`orderNumber`, SUM(`orderdetails`.`quantityOrdered` * `orderdetails`.`priceEach`)
	AS `total`
		FROM `orders`
			INNER JOIN `orderdetails`
				ON `orders`.`orderNumber` = `orderdetails`.`orderNumber`
					GROUP BY `orders`.`orderNumber`;
-- Bước 5: Trả về tổng doanh thu của những năm lớn hơn 2003
SELECT YEAR(`orders`.`orderDate`) AS `year`,
	SUM(`orderdetails`.`quantityOrdered` * `orderdetails`.`priceEach`)
		AS `total`
			FROM `orders`
				LEFT JOIN `orderdetails`
					ON `orders`.`orderNumber` = `orderdetails`.`orderNumber`
						WHERE `orders`.`status` = 'shipped'
							GROUP BY `year`
								HAVING `year` > 2003;