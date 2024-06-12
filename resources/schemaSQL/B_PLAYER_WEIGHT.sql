-- es_extended.TB_PLAYER_WEIGHT definition

CREATE TABLE `TB_PLAYER_WEIGHT` (
  `discord_id` varchar(60) NOT NULL,
  `weight_level` int(11) NOT NULL DEFAULT 0,
  `craeted_date` timestamp NULL DEFAULT current_timestamp(),
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`discord_id`),
  KEY `TB_PLAYER_WEIGHT_FK` (`weight_level`),
  CONSTRAINT `TB_PLAYER_WEIGHT_FK` FOREIGN KEY (`weight_level`) REFERENCES `TB_LEVEL_WEIGHT` (`weight_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;