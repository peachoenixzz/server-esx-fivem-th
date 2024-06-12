-- es_extended.TB_LEVEL_WEIGHT definition

CREATE TABLE `TB_LEVEL_WEIGHT` (
  `weight` int(11) NOT NULL,
  `weight_level` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`weight_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;