-- KRANIN production migration
-- Marketplace + inventory + vehicle tuning + rewards + park coords

CREATE TABLE IF NOT EXISTS `marketplace_items` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `seller_id` INT NOT NULL,
  `seller_name` VARCHAR(24) NOT NULL DEFAULT '',
  `item_id` INT NOT NULL,
  `item_count` INT NOT NULL DEFAULT 1,
  `item_name` VARCHAR(64) NOT NULL DEFAULT '',
  `price` INT NOT NULL,
  `is_hot` TINYINT(1) NOT NULL DEFAULT 0,
  `status` TINYINT(1) NOT NULL DEFAULT 0,
  `buyer_id` INT NOT NULL DEFAULT 0,
  `buyer_name` VARCHAR(24) NOT NULL DEFAULT '',
  `created_at` INT NOT NULL DEFAULT 0,
  `expires_at` INT NOT NULL DEFAULT 0,
  `sold_at` INT NOT NULL DEFAULT 0,
  INDEX(`seller_id`),
  INDEX(`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `marketplace_likes` (
  `player_id` INT NOT NULL,
  `listing_id` INT NOT NULL,
  `created_at` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`, `listing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `vehicle_store_components` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `vehicleid` INT NOT NULL,
  `componentid` INT NOT NULL,
  `state` INT NOT NULL DEFAULT 0,
  UNIQUE KEY `veh_comp` (`vehicleid`,`componentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- family/ownable park (ignore error if column exists)
ALTER TABLE `ownable_cars` ADD COLUMN `pos_x` FLOAT NOT NULL DEFAULT 0;
ALTER TABLE `ownable_cars` ADD COLUMN `pos_y` FLOAT NOT NULL DEFAULT 0;
ALTER TABLE `ownable_cars` ADD COLUMN `pos_z` FLOAT NOT NULL DEFAULT 0;
ALTER TABLE `ownable_cars` ADD COLUMN `angle` FLOAT NOT NULL DEFAULT 0;

ALTER TABLE `accounts` ADD COLUMN `case_rewards` TEXT NULL;
