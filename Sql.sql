-- Создание базы данных
DROP DATABASE IF EXISTS `game_store`;
CREATE DATABASE `game_store` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `game_store`;

-- Таблица users (пользователи)
CREATE TABLE `users` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица games (игры)
CREATE TABLE `games` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    `image` VARCHAR(255) NOT NULL,
    `stock` INT(11) NOT NULL DEFAULT 0,
    `discount` DECIMAL(5, 2) DEFAULT 0, -- Процент скидки (0-100)
    `discount_end` DATETIME DEFAULT NULL, -- Время окончания скидки
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица cart (корзина)
CREATE TABLE `cart` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INT(11) UNSIGNED NOT NULL,
    `game_id` INT(11) UNSIGNED NOT NULL,
    `quantity` INT(11) NOT NULL DEFAULT 1,
    `added_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица orders (заказы)
CREATE TABLE `orders` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INT(11) UNSIGNED NOT NULL,
    `total` DECIMAL(10, 2) NOT NULL,
    `status` ENUM('pending', 'completed', 'failed') NOT NULL DEFAULT 'pending',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица order_items (элементы заказов)
CREATE TABLE `order_items` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` INT(11) UNSIGNED NOT NULL,
    `game_id` INT(11) UNSIGNED NOT NULL,
    `quantity` INT(11) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Пример данных для users
INSERT INTO `users` (`username`, `password`, `email`) VALUES
('user1', '$2y$10$YOUR_HASH_HERE', 'user1@example.com'), -- Замените на хеш пароля, например, от '123456'
('user2', '$2y$10$YOUR_HASH_HERE', 'user2@example.com');

-- Пример данных для games
INSERT INTO `games` (`title`, `description`, `price`, `image`, `stock`, `discount`, `discount_end`) VALUES
('Far Cry 5: Inquisition', 'компьютерная игра в жанре шутера от первого лица.', 17.99, '/images/games/dragon_age111.png', 50, 20, '2025-03-20 23:59:00'),
('Battlefield 4', 'Динамичный шутер с поддержкой 64 игроков.', 25.99, '/images/games/battlefield111.png', 30, 15, '2025-03-18 12:00:00'),
('Grand Theft Auto V', 'Открытый мир с криминальными приключениями.', 15.99, '/images/games/gta_v.png', 20, 0, NULL),
('Marvel’s Spider-Man 2', 'Перемещайтесь на паутине между небоскрёбов.', 45.99, '/images/games/Marvel’s Spider-Man 2.png', 20, 10, '2025-03-19 18:00:00'),
('Fortnite', 'Исследуйте большой разрушаемый мир.', 5.99, '/images/games/Fortnite.png', 20, 0, NULL),
('Forza Horizon 5', 'Гоночная игра с открытым миром.', 25.99, '/images/games/Forza Horizon 5.png', 20, 25, '2025-03-21 09:00:00'),
('Farming Simulator 25', 'Окунитесь в увлекательную фермерскую жизнь.', 15.99, '/images/games/Farming Simulator 25.png', 20, 0, NULL),
('BeamNG.drive', 'Физический симулятор вождения.', 10.99, '/images/games/BeamNG.drive.png', 20, 0, NULL),
('SnowRunner', 'Встречайте новое поколение гонок по бездорожью!', 20.99, '/images/games/SnowRunner.png', 20, 30, '2025-03-17 23:59:00');