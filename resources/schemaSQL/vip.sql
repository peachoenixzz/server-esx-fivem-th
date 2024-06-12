-- es_extended.vip definition

CREATE TABLE `vip` (
  `identifier` varchar(60) NOT NULL,
  `discord_id` varchar(60) NOT NULL,
  `steam_id` varchar(60) NOT NULL,
  `vip_point` int(11) NOT NULL DEFAULT 0,
  `expire_date` timestamp NULL DEFAULT current_timestamp(),
  `last_updated` timestamp NULL DEFAULT current_timestamp(),
  `created_date` timestamp NULL DEFAULT current_timestamp(),
  `priority` varchar(60) NOT NULL,
  `extra_point` int(11) NOT NULL DEFAULT 0,
  `permanant_point` int(11) NOT NULL DEFAULT 0,
  `total_point` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`discord_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;