-- es_extended.core_effect definition

CREATE TABLE `core_effect` (
  `identifier` varchar(50) NOT NULL,
  `time_current` int(11) DEFAULT NULL,
  `time_started` int(11) DEFAULT NULL,
  `effect_type` varchar(60) NOT NULL,
  `effect_name` varchar(60) NOT NULL,
  `effect_in_game` int(11) DEFAULT NULL,
  `calculate_type` varchar(60) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `effect_show` varchar(30) DEFAULT 'show',
  PRIMARY KEY (`identifier`,`effect_type`,`effect_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;