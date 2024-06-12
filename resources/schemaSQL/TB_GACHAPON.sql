-- es_extended.TB_GACHAPON definition

CREATE TABLE `TB_GACHAPON` (
  `gachapon_id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`gachapon_id`),
  KEY `TB_GACHAPON_FK` (`name`),
  CONSTRAINT `TB_GACHAPON_FK` FOREIGN KEY (`name`) REFERENCES `items` (`name`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;