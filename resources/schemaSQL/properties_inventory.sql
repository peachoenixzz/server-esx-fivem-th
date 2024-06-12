-- es_extended.properties_inventory definition

CREATE TABLE `properties_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `propertie_id` int(11) DEFAULT NULL,
  `item` varchar(255) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `isweapon` int(255) NOT NULL DEFAULT 0,
  `owner` varchar(255) DEFAULT NULL,
  `label_weapon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;