USE classicmodels;
-- Sử dụng toán tử AND để hiển thị sản phẩm có giá lớn hơn 56.76
-- và số lượng tồn kho > 10
SELECT `productCode`, `productName`, `buyPrice`, `quantityInStock`
	FROM `products` WHERE `buyPrice` > 56.76 AND `quantityInStock` > 10
		ORDER BY `quantityInStock`;

-- Sử dụng INNER JOIN để hiển thị sản phẩm từ 2 bảng có liên quan với nhau
SELECT `productcode`, `productName`, `buyPrice`, `textDescription`
	FROM `products` INNER JOIN `productlines`
		ON `products`.`productLine` = `productlines`.`productLine`
			WHERE `buyPrice` > 56.76 AND `buyPrice` < 95.59
				ORDER BY `buyPrice`;
-- Sử dụng toán tử OR để phân loại sản phẩm
SELECT `productCode`, `productName`, `buyPrice`, `quantityInStock`,
	`productVendor`, `productLine` FROM `products`
		WHERE `productLine` = 'Classic Cars' OR `productVendor` = 'Min Lin Diecast'
			ORDER BY `quantityInStock`;