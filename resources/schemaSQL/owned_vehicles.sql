-- es_extended.owned_vehicles definition

CREATE TABLE `owned_vehicles` (
  `owner` varchar(50) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Etat de la voiture',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 1,
  `parking` varchar(60) DEFAULT NULL,
  `pound` varchar(60) DEFAULT NULL,
  `vehiclename` varchar(50) DEFAULT 'voiture',
  `properties` int(255) NOT NULL DEFAULT 0,
  `police` int(11) NOT NULL DEFAULT 0,
  `police_by` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `time` timestamp NULL DEFAULT current_timestamp(),
  `expire_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`owner`,`plate`),
  KEY `owner` (`owner`),
  KEY `owned_vehicles_plate_IDX` (`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;