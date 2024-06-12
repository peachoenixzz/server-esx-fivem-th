-- es_extended.nitrocars definition

CREATE TABLE `nitrocars` (
  `plate` varchar(50) NOT NULL,
  `nitro` tinyint(1) NOT NULL DEFAULT 0,
  `nitrolevel` int(100) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;