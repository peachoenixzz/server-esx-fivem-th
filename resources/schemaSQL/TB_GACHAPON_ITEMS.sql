-- es_extended.TB_GACHAPON_ITEMS definition

CREATE TABLE `TB_GACHAPON_ITEMS` (
  `gachapon_item_id` int(11) NOT NULL,
  `gachapon_id` int(11) DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `pull_rate` float NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`gachapon_item_id`),
  KEY `TB_GACHAPON_ITEMS_FK` (`gachapon_id`),
  KEY `TB_GACHAPON_ITEMS_FK_1` (`name`),
  CONSTRAINT `TB_GACHAPON_ITEMS_FK` FOREIGN KEY (`gachapon_id`) REFERENCES `TB_GACHAPON` (`gachapon_id`),
  CONSTRAINT `TB_GACHAPON_ITEMS_FK_1` FOREIGN KEY (`name`) REFERENCES `items` (`name`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;