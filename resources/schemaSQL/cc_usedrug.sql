-- es_extended.cc_usedrug definition

CREATE TABLE `cc_usedrug` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `duration` bigint(20) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `level` decimal(10,1) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;