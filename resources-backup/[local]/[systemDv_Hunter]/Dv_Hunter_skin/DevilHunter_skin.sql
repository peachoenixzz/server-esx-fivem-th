USE `essentialmode`;

CREATE TABLE `user_skin`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `skin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

ALTER TABLE `users`
	ADD `user_skin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'default'
;

UPDATE `users` SET `user_skin`='default';