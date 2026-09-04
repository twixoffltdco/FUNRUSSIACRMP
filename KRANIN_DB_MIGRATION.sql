-- KRANIN production migration (marketplace + inventory + tuning + rewards)
-- Run once on MySQL database used by the server.

CREATE TABLE IF NOT EXISTS `marketplace_items` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `seller_id` INT NOT NULL,
  `seller_name` VARCHAR(24) NOT NULL DEFAULT '',
  `item_id` INT NOT NULL,
  `item_count` INT NOT NULL DEFAULT 1,
  `item_name` VARCHAR(64) NOT NULL DEFAULT '',
  `price` INT NOT NULL,
  `is_hot` TINYINT(1) NOT NULL DEFAULT 0,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0=active 1=sold 2=cancelled',
  `buyer_id` INT NOT NULL DEFAULT 0,
  `buyer_name` VARCHAR(24) NOT NULL DEFAULT '',
  `created_at` INT NOT NULL DEFAULT 0,
  `expires_at` INT NOT NULL DEFAULT 0,
  `sold_at` INT NOT NULL DEFAULT 0,
  INDEX(`seller_id`),
  INDEX(`status`),
  INDEX(`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `marketplace_likes` (
  `player_id` INT NOT NULL,
  `listing_id` INT NOT NULL,
  `created_at` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`, `listing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `inventory` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `account_id` INT NOT NULL,
  `slot` INT NOT NULL,
  `item_id` INT NOT NULL DEFAULT 0,
  `model_id` INT NOT NULL DEFAULT 0,
  `amount` INT NOT NULL DEFAULT 1,
  `extra_1` INT NOT NULL DEFAULT 0,
  `old_skin` INT NOT NULL DEFAULT 0,
  UNIQUE KEY `acc_slot` (`account_id`,`slot`),
  INDEX(`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `vehicle_store_components` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `vehicleid` INT NOT NULL COMMENT 'ownable_cars.id',
  `componentid` INT NOT NULL,
  `state` INT NOT NULL DEFAULT 0,
  UNIQUE KEY `veh_comp` (`vehicleid`,`componentid`),
  INDEX(`vehicleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- rewards string for tablet GUI 74
ALTER TABLE `accounts` ADD COLUMN IF NOT EXISTS `case_rewards` TEXT NULL;
-- MySQL <8.0.12 may not support IF NOT EXISTS on column - ignore duplicate error:
-- ALTER TABLE `accounts` ADD COLUMN `case_rewards` TEXT NULL;

ALTER TABLE `ownable_cars` ADD COLUMN IF NOT EXISTS `wheel_size` INT NOT NULL DEFAULT 0;
ALTER TABLE `ownable_cars` ADD COLUMN IF NOT EXISTS `align_ft` INT NOT NULL DEFAULT 0;
ALTER TABLE `ownable_cars` ADD COLUMN IF NOT EXISTS `align_rr` INT NOT NULL DEFAULT 0;
