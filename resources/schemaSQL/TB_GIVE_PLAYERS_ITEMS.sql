-- es_extended.TB_GIVE_PLAYERS_ITEMS definition

CREATE TABLE `TB_GIVE_PLAYERS_ITEMS` (
  `item_name` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `identifier` varchar(60) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  KEY `TB_GIVE_PLAYERS_ITEMS_identifier_IDX` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;