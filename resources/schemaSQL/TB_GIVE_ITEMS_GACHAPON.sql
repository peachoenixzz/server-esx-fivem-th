-- es_extended.TB_GIVE_ITEMS_GACHAPON definition

CREATE TABLE `TB_GIVE_ITEMS_GACHAPON` (
  `discord_id` varchar(50) DEFAULT NULL,
  `item_name` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `gachapon_id` int(11) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gachapon_name` varchar(50) DEFAULT NULL,
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`transaction_id`),
  KEY `TB_GIVE_ITEMS_GACHAPON_FK` (`gachapon_id`),
  KEY `TB_GIVE_ITEMS_GACHAPON_discord_id_IDX` (`discord_id`,`gachapon_id`) USING BTREE,
  CONSTRAINT `TB_GIVE_ITEMS_GACHAPON_FK` FOREIGN KEY (`gachapon_id`) REFERENCES `TB_GACHAPON` (`gachapon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7259 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;