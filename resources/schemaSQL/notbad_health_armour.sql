-- es_extended.notbad_health_armour definition

CREATE TABLE `notbad_health_armour` (
  `identifier` varchar(60) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;