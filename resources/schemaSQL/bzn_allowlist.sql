-- es_extended.bzn_allowlist definition

CREATE TABLE `bzn_allowlist` (
  `identifier` varchar(75) DEFAULT NULL,
  `priority` int(11) DEFAULT 0,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;