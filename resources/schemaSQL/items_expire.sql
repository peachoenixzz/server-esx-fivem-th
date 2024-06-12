-- es_extended.items_expire definition

CREATE TABLE `items_expire` (
  `item_name` varchar(50) NOT NULL,
  `player_id` varchar(70) NOT NULL,
  `expire_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;