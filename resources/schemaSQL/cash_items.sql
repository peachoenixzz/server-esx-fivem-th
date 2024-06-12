-- es_extended.cash_items definition

CREATE TABLE `cash_items` (
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `point` int(11) NOT NULL,
  `limit` int(11) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `expire_days` int(11) DEFAULT -1,
  `available` tinyint(1) DEFAULT 1,
  `limit_type` varchar(100) DEFAULT 'normal',
  `promotion_flag` varchar(10) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `original_point` int(11) NOT NULL,
  KEY `cash_items_FK` (`name`),
  CONSTRAINT `cash_items_FK` FOREIGN KEY (`name`) REFERENCES `items` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;