CREATE TABLE IF NOT EXISTS `nc_vault` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) NOT NULL,
  `group` varchar(50) NOT NULL,
  `name` tinytext DEFAULT NULL,
  `name_tag` varchar(6) NOT NULL,
  `exp` int(11) DEFAULT NULL,
  `shared` longtext DEFAULT NULL,
  PRIMARY KEY (`_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `nc_vault_storage` (
  `vault_id` int(11) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `items` longtext DEFAULT NULL,
  `weapons` longtext DEFAULT NULL,
  UNIQUE KEY `vault_id` (`vault_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;