CREATE TABLE IF NOT EXISTS `nc_booth` (
  `identifier` varchar(60) NOT NULL,
  `serviceId` varchar(4) NOT NULL,
  `items` longtext NOT NULL,
  `weapons` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;