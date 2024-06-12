-- es_extended.cash_history definition

CREATE TABLE `cash_history` (
  `item_name` varchar(100) NOT NULL,
  `point` int(11) NOT NULL,
  `created_date` timestamp NULL DEFAULT sysdate(),
  `limit_type` varchar(100) DEFAULT NULL,
  `discord_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;