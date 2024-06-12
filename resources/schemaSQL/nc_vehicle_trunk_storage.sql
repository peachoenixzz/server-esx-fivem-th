-- es_extended.nc_vehicle_trunk_storage definition

CREATE TABLE `nc_vehicle_trunk_storage` (
  `plate` varchar(8) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `items` longtext DEFAULT NULL,
  `weapons` longtext DEFAULT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;