CREATE TABLE `xzero_trunk` (
	`plate` VARCHAR(20) NOT NULL,
	`is_owner` TINYINT(4) NULL DEFAULT 0,
	`accounts` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`items` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`weapons` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`time_last_update` TIMESTAMP NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`plate`)
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;