-- es_extended.wanted definition

CREATE TABLE `wanted` (
  `identifier` varchar(60) NOT NULL,
  `reason` varchar(150) NOT NULL,
  `timer` int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY `main` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;