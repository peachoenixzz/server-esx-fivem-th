-- es_extended.cash_point definition

CREATE TABLE `cash_point` (
  `point` int(11) DEFAULT NULL,
  `discord_id` varchar(50) NOT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp(),
  `last_updated` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`discord_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;