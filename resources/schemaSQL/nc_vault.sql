-- es_extended.nc_vault definition

CREATE TABLE `nc_vault` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) NOT NULL,
  `group` varchar(50) NOT NULL,
  `name` tinytext DEFAULT NULL,
  `name_tag` varchar(6) NOT NULL,
  `exp` float DEFAULT NULL,
  `shared` longtext DEFAULT NULL,
  PRIMARY KEY (`_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1747 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;