-- es_extended.TB_ITEM_QUEST definition

CREATE TABLE `TB_ITEM_QUEST` (
  `rare` varchar(100) NOT NULL DEFAULT 'normal',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  KEY `TB_ITEM_QUEST_FK` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;