-- es_extended.user_skin definition

CREATE TABLE `user_skin` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) DEFAULT NULL,
  `skin` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;