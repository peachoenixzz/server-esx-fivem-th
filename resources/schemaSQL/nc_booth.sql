-- es_extended.nc_booth definition

CREATE TABLE `nc_booth` (
  `identifier` varchar(60) NOT NULL,
  `serviceId` varchar(4) NOT NULL,
  `items` longtext NOT NULL,
  `weapons` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;