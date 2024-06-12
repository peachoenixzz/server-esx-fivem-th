-- es_extended.TB_PLAYER_QUEST definition

CREATE TABLE `TB_PLAYER_QUEST` (
  `discord_id` varchar(60) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'in_progress',
  PRIMARY KEY (`id`),
  UNIQUE KEY `TB_PLAYER_QUEST_UN` (`discord_id`,`created_date`,`id`),
  KEY `TB_PLAYER_QUEST_FK` (`name`),
  CONSTRAINT `TB_PLAYER_QUEST_FK` FOREIGN KEY (`name`) REFERENCES `items` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3868 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;