CREATE TABLE IF NOT EXISTS `nc_vehicle_inside_storage` (
	`plate` varchar(8) NOT NULL,
	`accounts` longtext DEFAULT NULL,
	`items` longtext DEFAULT NULL,
	`weapons` longtext DEFAULT NULL,
	PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE UTF8MB4_GENERAL_CI;

CREATE TABLE IF NOT EXISTS `nc_vehicle_trunk_storage` (
	`plate` varchar(8) NOT NULL,
	`accounts` longtext DEFAULT NULL,
	`items` longtext DEFAULT NULL,
	`weapons` longtext DEFAULT NULL,
	PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE UTF8MB4_GENERAL_CI;