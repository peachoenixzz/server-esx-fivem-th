-- es_extended.user_car_keys definition

CREATE TABLE `user_car_keys` (
  `identifier` varchar(50) NOT NULL,
  `plate` varchar(12) NOT NULL,
  PRIMARY KEY (`identifier`,`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;