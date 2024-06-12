-- es_extended.nc_vault_storage definition

CREATE TABLE `nc_vault_storage` (
  `vault_id` int(11) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `items` longtext DEFAULT NULL,
  `weapons` longtext DEFAULT NULL,
  UNIQUE KEY `vault_id` (`vault_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;