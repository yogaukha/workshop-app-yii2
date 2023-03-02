-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2023 at 10:29 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rd25`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` varchar(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `remark` text DEFAULT NULL,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `remark`, `createdtime`, `createdby`, `updatedtime`, `updatedby`, `is_deleted`) VALUES
('442ef071-ad27-11ed-8716-0492260c7ca0', 'A', 'Ayla, Agya, Pickup, Brio dan sejenisnya', '2023-02-15 18:52:47', 'lutfi_sa', '2023-02-18 14:48:12', 'maslutfi', 0),
('8e6d536d-ad44-11ed-8716-0492260c7ca0', 'B', 'Avanza, Xenia, Sigra, Calya, Mobilio, Xpander dan sejenisnya', '2023-02-15 22:22:27', 'lutfi_sa', '2023-02-18 14:48:18', 'maslutfi', 0),
('d6e9dd25-ad44-11ed-8716-0492260c7ca0', 'C', 'Innova, Fortuner, Pajero, BMW, Mercy, Alphard dan sejenisnya', '2023-02-15 22:24:29', 'lutfi_sa', '2023-02-18 14:48:25', 'maslutfi', 0);

--
-- Triggers `categories`
--
DELIMITER $$
CREATE TRIGGER `before_insert_vehicle_types` BEFORE INSERT ON `categories` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` varchar(36) NOT NULL DEFAULT 'uuid()',
  `license_plate` varchar(11) NOT NULL,
  `category_id` varchar(36) NOT NULL,
  `name` varchar(300) NOT NULL,
  `address` text NOT NULL,
  `phone_number` varchar(14) NOT NULL,
  `email` varchar(100) NOT NULL,
  `brand` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL,
  `year` varchar(4) NOT NULL,
  `kilometre` int(11) NOT NULL,
  `engine_number` varchar(100) DEFAULT NULL,
  `vehicle_identification_number` varchar(100) DEFAULT NULL,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `before_insert_customers` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `generals`
--

CREATE TABLE `generals` (
  `id` varchar(36) NOT NULL,
  `type` enum('Teks','Gambar') NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(300) NOT NULL,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `generals`
--

INSERT INTO `generals` (`id`, `type`, `name`, `value`, `createdtime`, `createdby`, `updatedtime`, `updatedby`, `is_deleted`) VALUES
('d49f7dd2-b2c5-11ed-9111-0492260c7ca0', 'Gambar', 'LOGO_PERUSAHAAN', 'uploads/logo-rd25-white.png', '2023-02-22 22:30:26', 'maslutfi', '2023-02-22 22:56:30', 'maslutfi', 0),
('d6ef6fc2-b2b2-11ed-9111-0492260c7ca0', 'Teks', 'NAMA_PERUSAHAAN', 'RD25 Body Repair', '2023-02-22 20:14:29', 'maslutfi', '2023-02-22 22:56:37', 'maslutfi', 0);

--
-- Triggers `generals`
--
DELIMITER $$
CREATE TRIGGER `before_insert_generals` BEFORE INSERT ON `generals` FOR EACH ROW BEGIN
	SET NEW.id = uuid();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `last_number`
--

CREATE TABLE `last_number` (
  `id` varchar(36) NOT NULL,
  `last_work_order_number` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `last_number`
--

INSERT INTO `last_number` (`id`, `last_work_order_number`) VALUES
('568dbcd8-b445-11ed-abe4-0492260c7ca0', 0);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` varchar(36) NOT NULL DEFAULT 'uuid()',
  `name` varchar(100) NOT NULL,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `createdtime`, `createdby`, `updatedtime`, `updatedby`, `is_deleted`) VALUES
('41c90474-ad25-11ed-8716-0492260c7ca0', 'Owner', '2023-02-15 18:38:24', 'lutfi_sa', NULL, NULL, 0),
('5449543d-ad25-11ed-8716-0492260c7ca0', 'Service Advisor', '2023-02-15 18:38:55', 'lutfi_sa', NULL, NULL, 0);

--
-- Triggers `roles`
--
DELIMITER $$
CREATE TRIGGER `before_insert_roles` BEFORE INSERT ON `roles` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` varchar(36) NOT NULL,
  `name` text NOT NULL,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `createdtime`, `createdby`, `updatedtime`, `updatedby`, `is_deleted`) VALUES
('00c97e73-b6a4-11ed-b11a-0492260c7ca0', 'Las Penggantian Panel', '2023-02-27 20:38:22', 'maslutfi', NULL, NULL, 0),
('0a93d344-b688-11ed-b11a-0492260c7ca0', 'Tanduk Bumper', '2023-02-27 17:18:12', 'maslutfi', NULL, NULL, 0),
('0ac1d5ea-b6a4-11ed-b11a-0492260c7ca0', 'Cat Velg', '2023-02-27 20:38:38', 'maslutfi', NULL, NULL, 0),
('0c02b9b8-b68e-11ed-b11a-0492260c7ca0', 'Pintu Depan Samping Kanan / Kiri', '2023-02-27 18:01:12', 'maslutfi', NULL, NULL, 0),
('0e22d793-b69e-11ed-b11a-0492260c7ca0', 'Lantai Bak Pick Up', '2023-02-27 19:55:47', 'maslutfi', NULL, NULL, 0),
('13995230-af63-11ed-a68b-0492260c7ca0', 'Bumper Depan / Belakang', '2023-02-18 15:05:58', 'maslutfi', '2023-02-24 16:41:28', 'maslutfi', 0),
('19832194-b68e-11ed-b11a-0492260c7ca0', 'Pintu Tengah Samping Kanan / Kiri', '2023-02-27 18:01:34', 'maslutfi', NULL, NULL, 0),
('19ad7150-b6a4-11ed-b11a-0492260c7ca0', 'Bongkar / Pasang Steering System', '2023-02-27 20:39:04', 'maslutfi', NULL, NULL, 0),
('1b5ed30b-b688-11ed-b11a-0492260c7ca0', 'Bull Head (Buffle) Kanan / Kiri', '2023-02-27 17:18:40', 'maslutfi', NULL, NULL, 0),
('2c72d912-b68d-11ed-b11a-0492260c7ca0', 'Engsel Kap Mesin', '2023-02-27 17:54:57', 'maslutfi', NULL, NULL, 0),
('2d9278b5-b6a4-11ed-b11a-0492260c7ca0', 'Bongkar / Pasang Knalpot', '2023-02-27 20:39:37', 'maslutfi', NULL, NULL, 0),
('2f0cfb53-b68e-11ed-b11a-0492260c7ca0', 'List Body Pintu (Gamish) / Spoiler', '2023-02-27 18:02:10', 'maslutfi', NULL, NULL, 0),
('33c10989-b688-11ed-b11a-0492260c7ca0', 'Grille Depan (Warna Body)', '2023-02-27 17:19:21', 'maslutfi', NULL, NULL, 0),
('3c476300-b68d-11ed-b11a-0492260c7ca0', 'Tiang Lock Kap Mesin', '2023-02-27 17:55:23', 'maslutfi', NULL, NULL, 0),
('401cd256-b6a4-11ed-b11a-0492260c7ca0', 'Turun Naik Mesin', '2023-02-27 20:40:08', 'maslutfi', NULL, NULL, 0),
('4179e25d-b688-11ed-b11a-0492260c7ca0', 'Panel Grille', '2023-02-27 17:19:44', 'maslutfi', NULL, NULL, 0),
('420d3daf-b68e-11ed-b11a-0492260c7ca0', 'Tiang Pintu Depan Kanan / Kiri', '2023-02-27 18:02:42', 'maslutfi', NULL, NULL, 0),
('4528d0b3-b6a3-11ed-b11a-0492260c7ca0', 'Kaca Depan / Belakang', '2023-02-27 20:33:07', 'maslutfi', NULL, NULL, 0),
('488c3b88-b6a4-11ed-b11a-0492260c7ca0', 'Bongkar Pasang Suspensi', '2023-02-27 20:40:22', 'maslutfi', NULL, NULL, 0),
('4c81e623-b68d-11ed-b11a-0492260c7ca0', 'Lock Kap Mesin', '2023-02-27 17:55:50', 'maslutfi', NULL, NULL, 0),
('4fad2b70-b688-11ed-b11a-0492260c7ca0', 'Panel Cowel', '2023-02-27 17:20:08', 'maslutfi', NULL, NULL, 0),
('52c5cffa-b69d-11ed-b11a-0492260c7ca0', 'Bak Samping', '2023-02-27 19:50:33', 'maslutfi', NULL, NULL, 0),
('56a10a96-b68e-11ed-b11a-0492260c7ca0', 'Tiang Pintu Tengah Kiri / Kanan (Pilar)', '2023-02-27 18:03:17', 'maslutfi', NULL, NULL, 0),
('5a79ce0e-b68d-11ed-b11a-0492260c7ca0', 'Cruss Member', '2023-02-27 17:56:14', 'maslutfi', NULL, NULL, 0),
('5b0aa481-b6a3-11ed-b11a-0492260c7ca0', 'Panel Bawah Headlamp', '2023-02-27 20:33:44', 'maslutfi', NULL, NULL, 0),
('5e9aa7cb-b688-11ed-b11a-0492260c7ca0', 'Kedok Depan / Panel Depan', '2023-02-27 17:20:33', 'maslutfi', NULL, NULL, 0),
('5f14aa20-b674-11ed-b11a-0492260c7ca0', 'Panel Atas Bumper Depan / Belakang', '2023-02-27 14:57:24', 'maslutfi', NULL, NULL, 0),
('5f9e123e-b68e-11ed-b11a-0492260c7ca0', 'Freon AC', '2023-02-27 18:03:32', 'maslutfi', NULL, NULL, 0),
('68dba93f-b68e-11ed-b11a-0492260c7ca0', 'Handle Pintu', '2023-02-27 18:03:47', 'maslutfi', NULL, NULL, 0),
('6c2c68f8-b68d-11ed-b11a-0492260c7ca0', 'Panel Dek Mesin / Firewall', '2023-02-27 17:56:43', 'maslutfi', NULL, NULL, 0),
('6e20f171-b688-11ed-b11a-0492260c7ca0', 'Pipi Kanan / Kiri', '2023-02-27 17:20:59', 'maslutfi', NULL, NULL, 0),
('71ef11a4-b6a3-11ed-b11a-0492260c7ca0', 'Cat Seluruh Body', '2023-02-27 20:34:22', 'maslutfi', NULL, NULL, 0),
('73901cc5-b6a2-11ed-b11a-0492260c7ca0', 'Roof Atas Sedan', '2023-02-27 20:27:15', 'maslutfi', NULL, NULL, 0),
('7925c0ab-b68e-11ed-b11a-0492260c7ca0', 'Triplang Kiri / Kanan', '2023-02-27 18:04:15', 'maslutfi', NULL, NULL, 0),
('7dc71dee-b6a2-11ed-b11a-0492260c7ca0', 'Panel Roof', '2023-02-27 20:27:32', 'maslutfi', NULL, NULL, 0),
('7fee9c4f-b68d-11ed-b11a-0492260c7ca0', 'Fender / Spakboard Depan', '2023-02-27 17:57:17', 'maslutfi', NULL, NULL, 0),
('7ffecc51-b69c-11ed-b11a-0492260c7ca0', 'Jasa Kunci Pintu', '2023-02-27 19:44:39', 'maslutfi', NULL, NULL, 0),
('82e1de1d-b68e-11ed-b11a-0492260c7ca0', 'Cover Spion', '2023-02-27 18:04:31', 'maslutfi', NULL, NULL, 0),
('8326501f-b6a3-11ed-b11a-0492260c7ca0', 'Tank Chasis (Car O Lines)', '2023-02-27 20:34:51', 'maslutfi', NULL, NULL, 0),
('8374edc5-b69d-11ed-b11a-0492260c7ca0', 'Pintu Bak (Pick Up)', '2023-02-27 19:51:54', 'maslutfi', NULL, NULL, 0),
('8bc48a7b-b68e-11ed-b11a-0492260c7ca0', 'Mudguard', '2023-02-27 18:04:46', 'maslutfi', NULL, NULL, 0),
('8e665b49-b69c-11ed-b11a-0492260c7ca0', 'Bongkar Pasang Kaca Pintu', '2023-02-27 19:45:03', 'maslutfi', NULL, NULL, 0),
('9881667c-b6a3-11ed-b11a-0492260c7ca0', 'Chasis Depan', '2023-02-27 20:35:27', 'maslutfi', NULL, NULL, 0),
('9e61e12a-b68d-11ed-b11a-0492260c7ca0', 'Fender / Spakboard Belakang', '2023-02-27 17:58:08', 'maslutfi', NULL, NULL, 0),
('a0960b68-b69c-11ed-b11a-0492260c7ca0', 'Bongkar Pasang Q Pintu', '2023-02-27 19:45:34', 'maslutfi', NULL, NULL, 0),
('a3bff286-b6a3-11ed-b11a-0492260c7ca0', 'Chasis Belakang', '2023-02-27 20:35:46', 'maslutfi', NULL, NULL, 0),
('a9fec292-b69d-11ed-b11a-0492260c7ca0', 'Lantai / Dek Depan / Belakang', '2023-02-27 19:52:59', 'maslutfi', NULL, NULL, 0),
('ae8907e2-b69c-11ed-b11a-0492260c7ca0', 'Kap Bagasi', '2023-02-27 19:45:57', 'maslutfi', NULL, NULL, 0),
('aeb664cf-b6a2-11ed-b11a-0492260c7ca0', 'Roof Atas Mobil Keluarga', '2023-02-27 20:28:55', 'maslutfi', NULL, NULL, 0),
('af597da8-b68d-11ed-b11a-0492260c7ca0', 'Apron Depan / Belakang', '2023-02-27 17:58:36', 'maslutfi', NULL, NULL, 0),
('b92a6eae-b6a3-11ed-b11a-0492260c7ca0', 'Dashboard', '2023-02-27 20:36:22', 'maslutfi', NULL, NULL, 0),
('bce786d7-b69c-11ed-b11a-0492260c7ca0', 'Panel Bagasi', '2023-02-27 19:46:21', 'maslutfi', NULL, NULL, 0),
('c8a755a2-b688-11ed-b11a-0492260c7ca0', 'Panel Depan Kaca Depan / Cowl', '2023-02-27 17:23:31', 'maslutfi', NULL, NULL, 0),
('c8b19000-b6a2-11ed-b11a-0492260c7ca0', 'Bongkar / Pasang Plafon / Interior', '2023-02-27 20:29:38', 'maslutfi', NULL, NULL, 0),
('cceb0596-b6a3-11ed-b11a-0492260c7ca0', 'Bongkar / Pasang AC System', '2023-02-27 20:36:55', 'maslutfi', NULL, NULL, 0),
('d15a0bef-b69c-11ed-b11a-0492260c7ca0', 'Footsrep', '2023-02-27 19:46:56', 'maslutfi', NULL, NULL, 0),
('d37cc2c2-b69d-11ed-b11a-0492260c7ca0', 'Lantai / Dek Tengah', '2023-02-27 19:54:09', 'maslutfi', NULL, NULL, 0),
('d3d1c1c5-b68d-11ed-b11a-0492260c7ca0', 'Spoller Fender Depan & Belakang', '2023-02-27 17:59:37', 'maslutfi', NULL, NULL, 0),
('dd2455ee-b69c-11ed-b11a-0492260c7ca0', 'Cover Ban Serep', '2023-02-27 19:47:15', 'maslutfi', NULL, NULL, 0),
('dd7ca106-b6a3-11ed-b11a-0492260c7ca0', 'Spooring & Balancing', '2023-02-27 20:37:23', 'maslutfi', NULL, NULL, 0),
('def7b36c-b688-11ed-b11a-0492260c7ca0', 'Tiang Kaca Depan / Belakang', '2023-02-27 17:24:09', 'maslutfi', NULL, NULL, 0),
('e6d493e6-b68d-11ed-b11a-0492260c7ca0', 'Panel Body Belakang / Body Mati', '2023-02-27 18:00:09', 'maslutfi', NULL, NULL, 0),
('ea3cfe72-b6a3-11ed-b11a-0492260c7ca0', 'Electrical System', '2023-02-27 20:37:44', 'maslutfi', NULL, NULL, 0),
('ec6e480a-b688-11ed-b11a-0492260c7ca0', 'Kap Mesin', '2023-02-27 17:24:31', 'maslutfi', NULL, NULL, 0),
('f4c3d98d-b6a3-11ed-b11a-0492260c7ca0', 'Naik Turun Body', '2023-02-27 20:38:02', 'maslutfi', NULL, NULL, 0),
('f7ff863c-b422-11ed-abe4-0492260c7ca0', 'Ext Bumper Depan / Belakang', '2023-02-24 16:09:40', 'maslutfi', '2023-02-24 16:39:02', 'maslutfi', 0),
('faba9af5-b687-11ed-b11a-0492260c7ca0', 'Brecket (Panel) Atas / Bawah Bumper', '2023-02-27 17:17:46', 'maslutfi', NULL, NULL, 0),
('fb8e84d1-b68d-11ed-b11a-0492260c7ca0', 'Body Samping (Non Pintu)', '2023-02-27 18:00:44', 'maslutfi', NULL, NULL, 0),
('fd418bba-b69d-11ed-b11a-0492260c7ca0', 'Lantai / Dek Bagasi', '2023-02-27 19:55:19', 'maslutfi', NULL, NULL, 0);

--
-- Triggers `services`
--
DELIMITER $$
CREATE TRIGGER `before_insert_services` BEFORE INSERT ON `services` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `service_prices`
--

CREATE TABLE `service_prices` (
  `id` varchar(36) NOT NULL,
  `category_id` varchar(36) NOT NULL,
  `service_id` varchar(36) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_prices`
--

INSERT INTO `service_prices` (`id`, `category_id`, `service_id`, `price`, `discount`, `createdtime`, `createdby`, `updatedtime`, `updatedby`, `is_deleted`) VALUES
('00ceeccb-b6a4-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '00c97e73-b6a4-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:38:22', 'maslutfi', NULL, NULL, 0),
('00cf1c6d-b6a4-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '00c97e73-b6a4-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:38:22', 'maslutfi', NULL, NULL, 0),
('00cf4b1b-b6a4-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '00c97e73-b6a4-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:38:22', 'maslutfi', NULL, NULL, 0),
('0a9c4d98-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '0a93d344-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:18:12', 'maslutfi', NULL, NULL, 0),
('0a9d1c28-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '0a93d344-b688-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 17:18:12', 'maslutfi', NULL, NULL, 0),
('0a9dcce0-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '0a93d344-b688-11ed-b11a-0492260c7ca0', 275000, NULL, '2023-02-27 17:18:12', 'maslutfi', NULL, NULL, 0),
('0ac6901b-b6a4-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '0ac1d5ea-b6a4-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 20:38:39', 'maslutfi', NULL, NULL, 0),
('0ac6d016-b6a4-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '0ac1d5ea-b6a4-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:38:39', 'maslutfi', NULL, NULL, 0),
('0ac71452-b6a4-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '0ac1d5ea-b6a4-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:38:39', 'maslutfi', NULL, NULL, 0),
('0c062875-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '0c02b9b8-b68e-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 18:01:12', 'maslutfi', NULL, NULL, 0),
('0c066014-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '0c02b9b8-b68e-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 18:01:12', 'maslutfi', NULL, NULL, 0),
('0c069b6b-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '0c02b9b8-b68e-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 18:01:12', 'maslutfi', NULL, NULL, 0),
('0e28af8b-b69e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '0e22d793-b69e-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 19:55:47', 'maslutfi', NULL, NULL, 0),
('0e30eb63-b69e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '0e22d793-b69e-11ed-b11a-0492260c7ca0', NULL, NULL, '2023-02-27 19:55:47', 'maslutfi', NULL, NULL, 0),
('0e31449d-b69e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '0e22d793-b69e-11ed-b11a-0492260c7ca0', NULL, NULL, '2023-02-27 19:55:47', 'maslutfi', NULL, NULL, 0),
('128274e2-b427-11ed-abe4-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'f7ff863c-b422-11ed-abe4-0492260c7ca0', 100000, NULL, '2023-02-24 16:39:02', 'maslutfi', NULL, NULL, 0),
('12831cc9-b427-11ed-abe4-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'f7ff863c-b422-11ed-abe4-0492260c7ca0', 125000, NULL, '2023-02-24 16:39:02', 'maslutfi', NULL, NULL, 0),
('12915188-b427-11ed-abe4-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'f7ff863c-b422-11ed-abe4-0492260c7ca0', 200000, NULL, '2023-02-24 16:39:02', 'maslutfi', NULL, NULL, 0),
('19872f94-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '19832194-b68e-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 18:01:34', 'maslutfi', NULL, NULL, 0),
('19875e27-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '19832194-b68e-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 18:01:34', 'maslutfi', NULL, NULL, 0),
('19878bd6-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '19832194-b68e-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 18:01:34', 'maslutfi', NULL, NULL, 0),
('19af7071-b6a4-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '19ad7150-b6a4-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:39:04', 'maslutfi', NULL, NULL, 0),
('19af9c1f-b6a4-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '19ad7150-b6a4-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:39:04', 'maslutfi', NULL, NULL, 0),
('19c7c24b-b6a4-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '19ad7150-b6a4-11ed-b11a-0492260c7ca0', 260000, NULL, '2023-02-27 20:39:04', 'maslutfi', NULL, NULL, 0),
('1bc3c249-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '1b5ed30b-b688-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:18:41', 'maslutfi', NULL, NULL, 0),
('1bca8de6-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '1b5ed30b-b688-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:18:41', 'maslutfi', NULL, NULL, 0),
('1bcb47b7-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '1b5ed30b-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:18:41', 'maslutfi', NULL, NULL, 0),
('2c7896af-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '2c72d912-b68d-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:54:57', 'maslutfi', NULL, NULL, 0),
('2c78d637-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '2c72d912-b68d-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:54:57', 'maslutfi', NULL, NULL, 0),
('2c790db7-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '2c72d912-b68d-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:54:57', 'maslutfi', NULL, NULL, 0),
('2d97da58-b6a4-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '2d9278b5-b6a4-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:39:37', 'maslutfi', NULL, NULL, 0),
('2d980bca-b6a4-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '2d9278b5-b6a4-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:39:37', 'maslutfi', NULL, NULL, 0),
('2d984050-b6a4-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '2d9278b5-b6a4-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 20:39:37', 'maslutfi', NULL, NULL, 0),
('2f10d6b0-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '2f0cfb53-b68e-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 18:02:10', 'maslutfi', NULL, NULL, 0),
('2f1c0362-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '2f0cfb53-b68e-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 18:02:11', 'maslutfi', NULL, NULL, 0),
('2f1c5ebd-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '2f0cfb53-b68e-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 18:02:11', 'maslutfi', NULL, NULL, 0),
('33c7482c-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '33c10989-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:19:21', 'maslutfi', NULL, NULL, 0),
('33c7c656-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '33c10989-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:19:21', 'maslutfi', NULL, NULL, 0),
('33c86f2d-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '33c10989-b688-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 17:19:21', 'maslutfi', NULL, NULL, 0),
('3c4cf1ee-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '3c476300-b68d-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:55:23', 'maslutfi', NULL, NULL, 0),
('3c4d49e5-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '3c476300-b68d-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:55:23', 'maslutfi', NULL, NULL, 0),
('3c4d9822-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '3c476300-b68d-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:55:23', 'maslutfi', NULL, NULL, 0),
('40244350-b6a4-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '401cd256-b6a4-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 20:40:08', 'maslutfi', NULL, NULL, 0),
('40248d34-b6a4-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '401cd256-b6a4-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 20:40:08', 'maslutfi', NULL, NULL, 0),
('4024d496-b6a4-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '401cd256-b6a4-11ed-b11a-0492260c7ca0', 800000, NULL, '2023-02-27 20:40:08', 'maslutfi', NULL, NULL, 0),
('418add12-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '4179e25d-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:19:44', 'maslutfi', NULL, NULL, 0),
('4194f8a5-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '4179e25d-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:19:45', 'maslutfi', NULL, NULL, 0),
('4196218c-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '4179e25d-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:19:45', 'maslutfi', NULL, NULL, 0),
('4228103b-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '420d3daf-b68e-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 18:02:42', 'maslutfi', NULL, NULL, 0),
('4228e0fa-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '420d3daf-b68e-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 18:02:42', 'maslutfi', NULL, NULL, 0),
('422992fd-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '420d3daf-b68e-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 18:02:42', 'maslutfi', NULL, NULL, 0),
('452e53c7-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '4528d0b3-b6a3-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 20:33:07', 'maslutfi', NULL, NULL, 0),
('4537a4fb-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '4528d0b3-b6a3-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 20:33:07', 'maslutfi', NULL, NULL, 0),
('4537d73a-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '4528d0b3-b6a3-11ed-b11a-0492260c7ca0', 175000, NULL, '2023-02-27 20:33:07', 'maslutfi', NULL, NULL, 0),
('488db3ba-b6a4-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '488c3b88-b6a4-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:40:22', 'maslutfi', NULL, NULL, 0),
('488df4f0-b6a4-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '488c3b88-b6a4-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:40:22', 'maslutfi', NULL, NULL, 0),
('488e4634-b6a4-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '488c3b88-b6a4-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 20:40:22', 'maslutfi', NULL, NULL, 0),
('4c94f8dc-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '4c81e623-b68d-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:55:50', 'maslutfi', NULL, NULL, 0),
('4c955cf7-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '4c81e623-b68d-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:55:50', 'maslutfi', NULL, NULL, 0),
('4c95be12-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '4c81e623-b68d-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:55:50', 'maslutfi', NULL, NULL, 0),
('4fb2f9e1-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '4fad2b70-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:20:08', 'maslutfi', NULL, NULL, 0),
('4fb3abca-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '4fad2b70-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:20:08', 'maslutfi', NULL, NULL, 0),
('4fbbb663-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '4fad2b70-b688-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 17:20:08', 'maslutfi', NULL, NULL, 0),
('52d1720b-b69d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '52c5cffa-b69d-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 19:50:33', 'maslutfi', NULL, NULL, 0),
('52d1bca2-b69d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '52c5cffa-b69d-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 19:50:33', 'maslutfi', NULL, NULL, 0),
('52d224a6-b69d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '52c5cffa-b69d-11ed-b11a-0492260c7ca0', NULL, NULL, '2023-02-27 19:50:33', 'maslutfi', NULL, NULL, 0),
('56a526a9-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '56a10a96-b68e-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 18:03:17', 'maslutfi', NULL, NULL, 0),
('56a55582-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '56a10a96-b68e-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 18:03:17', 'maslutfi', NULL, NULL, 0),
('56a58245-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '56a10a96-b68e-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 18:03:17', 'maslutfi', NULL, NULL, 0),
('5a7df6c2-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '5a79ce0e-b68d-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:56:14', 'maslutfi', NULL, NULL, 0),
('5a7e2aec-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '5a79ce0e-b68d-11ed-b11a-0492260c7ca0', 175000, NULL, '2023-02-27 17:56:14', 'maslutfi', NULL, NULL, 0),
('5a7e5cbf-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '5a79ce0e-b68d-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:56:14', 'maslutfi', NULL, NULL, 0),
('5b177d59-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '5b0aa481-b6a3-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 20:33:44', 'maslutfi', NULL, NULL, 0),
('5b17bd37-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '5b0aa481-b6a3-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 20:33:44', 'maslutfi', NULL, NULL, 0),
('5b180092-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '5b0aa481-b6a3-11ed-b11a-0492260c7ca0', 175000, NULL, '2023-02-27 20:33:44', 'maslutfi', NULL, NULL, 0),
('5ea12bd1-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '5e9aa7cb-b688-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:20:33', 'maslutfi', NULL, NULL, 0),
('5ea19df5-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '5e9aa7cb-b688-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:20:33', 'maslutfi', NULL, NULL, 0),
('5ea218f2-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '5e9aa7cb-b688-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:20:33', 'maslutfi', NULL, NULL, 0),
('5f2d5712-b674-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '5f14aa20-b674-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 14:57:24', 'maslutfi', NULL, NULL, 0),
('5f2d8e81-b674-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '5f14aa20-b674-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 14:57:24', 'maslutfi', NULL, NULL, 0),
('5f2dd681-b674-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '5f14aa20-b674-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 14:57:24', 'maslutfi', NULL, NULL, 0),
('5f9f721f-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '5f9e123e-b68e-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 18:03:32', 'maslutfi', NULL, NULL, 0),
('5f9fa0e7-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '5f9e123e-b68e-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 18:03:32', 'maslutfi', NULL, NULL, 0),
('5f9fdf3b-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '5f9e123e-b68e-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 18:03:32', 'maslutfi', NULL, NULL, 0),
('68e0946b-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '68dba93f-b68e-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 18:03:47', 'maslutfi', NULL, NULL, 0),
('68e0c2ee-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '68dba93f-b68e-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 18:03:47', 'maslutfi', NULL, NULL, 0),
('68e0f0a5-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '68dba93f-b68e-11ed-b11a-0492260c7ca0', 125000, NULL, '2023-02-27 18:03:47', 'maslutfi', NULL, NULL, 0),
('6939493f-b427-11ed-abe4-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '13995230-af63-11ed-a68b-0492260c7ca0', 350000, NULL, '2023-02-24 16:41:28', 'maslutfi', NULL, NULL, 0),
('69426d4a-b427-11ed-abe4-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '13995230-af63-11ed-a68b-0492260c7ca0', 450000, NULL, '2023-02-24 16:41:28', 'maslutfi', NULL, NULL, 0),
('6942a4ee-b427-11ed-abe4-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '13995230-af63-11ed-a68b-0492260c7ca0', 550000, NULL, '2023-02-24 16:41:28', 'maslutfi', NULL, NULL, 0),
('6c321750-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '6c2c68f8-b68d-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:56:44', 'maslutfi', NULL, NULL, 0),
('6c3af498-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '6c2c68f8-b68d-11ed-b11a-0492260c7ca0', 225000, NULL, '2023-02-27 17:56:44', 'maslutfi', NULL, NULL, 0),
('6c3b264c-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '6c2c68f8-b68d-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 17:56:44', 'maslutfi', NULL, NULL, 0),
('6e395f22-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '6e20f171-b688-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 17:20:59', 'maslutfi', NULL, NULL, 0),
('6e41d3fc-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '6e20f171-b688-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 17:20:59', 'maslutfi', NULL, NULL, 0),
('6e42705a-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '6e20f171-b688-11ed-b11a-0492260c7ca0', 350000, NULL, '2023-02-27 17:21:00', 'maslutfi', NULL, NULL, 0),
('71f5da16-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '71ef11a4-b6a3-11ed-b11a-0492260c7ca0', 4000000, NULL, '2023-02-27 20:34:22', 'maslutfi', NULL, NULL, 0),
('71f6123a-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '71ef11a4-b6a3-11ed-b11a-0492260c7ca0', 7000000, NULL, '2023-02-27 20:34:22', 'maslutfi', NULL, NULL, 0),
('71f63dce-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '71ef11a4-b6a3-11ed-b11a-0492260c7ca0', 9000000, NULL, '2023-02-27 20:34:22', 'maslutfi', NULL, NULL, 0),
('7394bc50-b6a2-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '73901cc5-b6a2-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 20:27:15', 'maslutfi', NULL, NULL, 0),
('7394ff3f-b6a2-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '73901cc5-b6a2-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 20:27:15', 'maslutfi', NULL, NULL, 0),
('739540d4-b6a2-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '73901cc5-b6a2-11ed-b11a-0492260c7ca0', 900000, NULL, '2023-02-27 20:27:15', 'maslutfi', NULL, NULL, 0),
('7929c2d3-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '7925c0ab-b68e-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 18:04:15', 'maslutfi', NULL, NULL, 0),
('7929fc1f-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '7925c0ab-b68e-11ed-b11a-0492260c7ca0', 350000, NULL, '2023-02-27 18:04:15', 'maslutfi', NULL, NULL, 0),
('792a2d5a-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '7925c0ab-b68e-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 18:04:15', 'maslutfi', NULL, NULL, 0),
('7dcb5c2f-b6a2-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '7dc71dee-b6a2-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 20:27:32', 'maslutfi', NULL, NULL, 0),
('7dcb932a-b6a2-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '7dc71dee-b6a2-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 20:27:32', 'maslutfi', NULL, NULL, 0),
('7dcbc2a2-b6a2-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '7dc71dee-b6a2-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 20:27:32', 'maslutfi', NULL, NULL, 0),
('7ff30317-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '7fee9c4f-b68d-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 17:57:17', 'maslutfi', NULL, NULL, 0),
('7ff3429c-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '7fee9c4f-b68d-11ed-b11a-0492260c7ca0', 550000, NULL, '2023-02-27 17:57:17', 'maslutfi', NULL, NULL, 0),
('7ff3867d-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '7fee9c4f-b68d-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 17:57:17', 'maslutfi', NULL, NULL, 0),
('80049783-b69c-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '7ffecc51-b69c-11ed-b11a-0492260c7ca0', 50000, NULL, '2023-02-27 19:44:39', 'maslutfi', NULL, NULL, 0),
('8004d70e-b69c-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '7ffecc51-b69c-11ed-b11a-0492260c7ca0', 50000, NULL, '2023-02-27 19:44:39', 'maslutfi', NULL, NULL, 0),
('80050a7c-b69c-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '7ffecc51-b69c-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 19:44:39', 'maslutfi', NULL, NULL, 0),
('82f2c37f-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '82e1de1d-b68e-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 18:04:31', 'maslutfi', NULL, NULL, 0),
('82f50136-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '82e1de1d-b68e-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 18:04:31', 'maslutfi', NULL, NULL, 0),
('82f9c573-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '82e1de1d-b68e-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 18:04:31', 'maslutfi', NULL, NULL, 0),
('832a4918-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '8326501f-b6a3-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 20:34:51', 'maslutfi', NULL, NULL, 0),
('832a8851-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '8326501f-b6a3-11ed-b11a-0492260c7ca0', 750000, NULL, '2023-02-27 20:34:51', 'maslutfi', NULL, NULL, 0),
('832acc8a-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '8326501f-b6a3-11ed-b11a-0492260c7ca0', 1000000, NULL, '2023-02-27 20:34:51', 'maslutfi', NULL, NULL, 0),
('837a537e-b69d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '8374edc5-b69d-11ed-b11a-0492260c7ca0', 400000, NULL, '2023-02-27 19:51:55', 'maslutfi', NULL, NULL, 0),
('837a84a2-b69d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '8374edc5-b69d-11ed-b11a-0492260c7ca0', NULL, NULL, '2023-02-27 19:51:55', 'maslutfi', NULL, NULL, 0),
('837ab774-b69d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '8374edc5-b69d-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 19:51:55', 'maslutfi', NULL, NULL, 0),
('8bc9ae45-b68e-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '8bc48a7b-b68e-11ed-b11a-0492260c7ca0', 50000, NULL, '2023-02-27 18:04:46', 'maslutfi', NULL, NULL, 0),
('8bc9edac-b68e-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '8bc48a7b-b68e-11ed-b11a-0492260c7ca0', 50000, NULL, '2023-02-27 18:04:46', 'maslutfi', NULL, NULL, 0),
('8bca34d3-b68e-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '8bc48a7b-b68e-11ed-b11a-0492260c7ca0', 75000, NULL, '2023-02-27 18:04:46', 'maslutfi', NULL, NULL, 0),
('8e6bbe42-b69c-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '8e665b49-b69c-11ed-b11a-0492260c7ca0', 75000, NULL, '2023-02-27 19:45:03', 'maslutfi', NULL, NULL, 0),
('8e6bf127-b69c-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '8e665b49-b69c-11ed-b11a-0492260c7ca0', 75000, NULL, '2023-02-27 19:45:03', 'maslutfi', NULL, NULL, 0),
('8e6c238d-b69c-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '8e665b49-b69c-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 19:45:03', 'maslutfi', NULL, NULL, 0),
('9885fabf-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '9881667c-b6a3-11ed-b11a-0492260c7ca0', 400000, NULL, '2023-02-27 20:35:27', 'maslutfi', NULL, NULL, 0),
('9886311d-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '9881667c-b6a3-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 20:35:27', 'maslutfi', NULL, NULL, 0),
('98867a31-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '9881667c-b6a3-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 20:35:27', 'maslutfi', NULL, NULL, 0),
('9e71e85f-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', '9e61e12a-b68d-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 17:58:08', 'maslutfi', NULL, NULL, 0),
('9e723286-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', '9e61e12a-b68d-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 17:58:08', 'maslutfi', NULL, NULL, 0),
('9e727e1d-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', '9e61e12a-b68d-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 17:58:08', 'maslutfi', NULL, NULL, 0),
('a099d7ab-b69c-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'a0960b68-b69c-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 19:45:34', 'maslutfi', NULL, NULL, 0),
('a09a0abc-b69c-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'a0960b68-b69c-11ed-b11a-0492260c7ca0', 125000, NULL, '2023-02-27 19:45:34', 'maslutfi', NULL, NULL, 0),
('a09a3eb8-b69c-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'a0960b68-b69c-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 19:45:34', 'maslutfi', NULL, NULL, 0),
('a3c5867e-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'a3bff286-b6a3-11ed-b11a-0492260c7ca0', 400000, NULL, '2023-02-27 20:35:46', 'maslutfi', NULL, NULL, 0),
('a3c5b665-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'a3bff286-b6a3-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 20:35:46', 'maslutfi', NULL, NULL, 0),
('a3c5e916-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'a3bff286-b6a3-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 20:35:46', 'maslutfi', NULL, NULL, 0),
('aa03728d-b69d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'a9fec292-b69d-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 19:52:59', 'maslutfi', NULL, NULL, 0),
('aa03b156-b69d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'a9fec292-b69d-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 19:52:59', 'maslutfi', NULL, NULL, 0),
('aa03f2f0-b69d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'a9fec292-b69d-11ed-b11a-0492260c7ca0', 400000, NULL, '2023-02-27 19:52:59', 'maslutfi', NULL, NULL, 0),
('ae9ea7b7-b69c-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'ae8907e2-b69c-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 19:45:57', 'maslutfi', NULL, NULL, 0),
('ae9f15d0-b69c-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'ae8907e2-b69c-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 19:45:57', 'maslutfi', NULL, NULL, 0),
('ae9f6a11-b69c-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'ae8907e2-b69c-11ed-b11a-0492260c7ca0', 550000, NULL, '2023-02-27 19:45:57', 'maslutfi', NULL, NULL, 0),
('aeba9ebb-b6a2-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'aeb664cf-b6a2-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 20:28:55', 'maslutfi', NULL, NULL, 0),
('aebada5a-b6a2-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'aeb664cf-b6a2-11ed-b11a-0492260c7ca0', 900000, NULL, '2023-02-27 20:28:55', 'maslutfi', NULL, NULL, 0),
('aebb0d0d-b6a2-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'aeb664cf-b6a2-11ed-b11a-0492260c7ca0', 1000000, NULL, '2023-02-27 20:28:55', 'maslutfi', NULL, NULL, 0),
('af5eb005-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'af597da8-b68d-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 17:58:36', 'maslutfi', NULL, NULL, 0),
('af5ef1be-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'af597da8-b68d-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 17:58:36', 'maslutfi', NULL, NULL, 0),
('af5f32c5-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'af597da8-b68d-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 17:58:36', 'maslutfi', NULL, NULL, 0),
('b9378672-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'b92a6eae-b6a3-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:36:22', 'maslutfi', NULL, NULL, 0),
('b9380af5-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'b92a6eae-b6a3-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 20:36:22', 'maslutfi', NULL, NULL, 0),
('b941c278-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'b92a6eae-b6a3-11ed-b11a-0492260c7ca0', 350000, NULL, '2023-02-27 20:36:22', 'maslutfi', NULL, NULL, 0),
('bceb9c13-b69c-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'bce786d7-b69c-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 19:46:21', 'maslutfi', NULL, NULL, 0),
('bcf908ab-b69c-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'bce786d7-b69c-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 19:46:21', 'maslutfi', NULL, NULL, 0),
('bcf97609-b69c-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'bce786d7-b69c-11ed-b11a-0492260c7ca0', 400000, NULL, '2023-02-27 19:46:21', 'maslutfi', NULL, NULL, 0),
('c8acebcb-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'c8a755a2-b688-11ed-b11a-0492260c7ca0', 400000, NULL, '2023-02-27 17:23:31', 'maslutfi', NULL, NULL, 0),
('c8ad4dec-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'c8a755a2-b688-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 17:23:31', 'maslutfi', NULL, NULL, 0),
('c8adca7a-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'c8a755a2-b688-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 17:23:31', 'maslutfi', NULL, NULL, 0),
('c8b5dbdb-b6a2-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'c8b19000-b6a2-11ed-b11a-0492260c7ca0', 400000, NULL, '2023-02-27 20:29:38', 'maslutfi', NULL, NULL, 0),
('c8b61c92-b6a2-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'c8b19000-b6a2-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 20:29:38', 'maslutfi', NULL, NULL, 0),
('c8b65e38-b6a2-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'c8b19000-b6a2-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 20:29:38', 'maslutfi', NULL, NULL, 0),
('ccf03f3c-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'cceb0596-b6a3-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:36:55', 'maslutfi', NULL, NULL, 0),
('ccf08fbb-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'cceb0596-b6a3-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:36:55', 'maslutfi', NULL, NULL, 0),
('ccf0e019-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'cceb0596-b6a3-11ed-b11a-0492260c7ca0', 180000, NULL, '2023-02-27 20:36:55', 'maslutfi', NULL, NULL, 0),
('d1608f8e-b69c-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'd15a0bef-b69c-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 19:46:56', 'maslutfi', NULL, NULL, 0),
('d160bf15-b69c-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'd15a0bef-b69c-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 19:46:56', 'maslutfi', NULL, NULL, 0),
('d160fff4-b69c-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'd15a0bef-b69c-11ed-b11a-0492260c7ca0', 375000, NULL, '2023-02-27 19:46:56', 'maslutfi', NULL, NULL, 0),
('d3816ad9-b69d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'd37cc2c2-b69d-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 19:54:09', 'maslutfi', NULL, NULL, 0),
('d381a3db-b69d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'd37cc2c2-b69d-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 19:54:09', 'maslutfi', NULL, NULL, 0),
('d381d5d4-b69d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'd37cc2c2-b69d-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 19:54:09', 'maslutfi', NULL, NULL, 0),
('d3d696dc-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'd3d1c1c5-b68d-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:59:37', 'maslutfi', NULL, NULL, 0),
('d3d6cf1f-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'd3d1c1c5-b68d-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 17:59:37', 'maslutfi', NULL, NULL, 0),
('d3d70673-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'd3d1c1c5-b68d-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 17:59:37', 'maslutfi', NULL, NULL, 0),
('dd2a43d4-b69c-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'dd2455ee-b69c-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 19:47:16', 'maslutfi', NULL, NULL, 0),
('dd2a9806-b69c-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'dd2455ee-b69c-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 19:47:16', 'maslutfi', NULL, NULL, 0),
('dd2ad7ad-b69c-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'dd2455ee-b69c-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 19:47:16', 'maslutfi', NULL, NULL, 0),
('dd82c3e2-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'dd7ca106-b6a3-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:37:23', 'maslutfi', NULL, NULL, 0),
('dd830b94-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'dd7ca106-b6a3-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:37:23', 'maslutfi', NULL, NULL, 0),
('dd834f43-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'dd7ca106-b6a3-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 20:37:23', 'maslutfi', NULL, NULL, 0),
('defcd037-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'def7b36c-b688-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:24:09', 'maslutfi', NULL, NULL, 0),
('defd33ef-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'def7b36c-b688-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:24:09', 'maslutfi', NULL, NULL, 0),
('defd9566-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'def7b36c-b688-11ed-b11a-0492260c7ca0', 330000, NULL, '2023-02-27 17:24:09', 'maslutfi', NULL, NULL, 0),
('e6da1654-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'e6d493e6-b68d-11ed-b11a-0492260c7ca0', 200000, NULL, '2023-02-27 18:00:09', 'maslutfi', NULL, NULL, 0),
('e6da55e3-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'e6d493e6-b68d-11ed-b11a-0492260c7ca0', 250000, NULL, '2023-02-27 18:00:09', 'maslutfi', NULL, NULL, 0),
('e6daa00c-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'e6d493e6-b68d-11ed-b11a-0492260c7ca0', 350000, NULL, '2023-02-27 18:00:09', 'maslutfi', NULL, NULL, 0),
('ea4b3fce-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'ea3cfe72-b6a3-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 20:37:44', 'maslutfi', NULL, NULL, 0),
('ea4b7419-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'ea3cfe72-b6a3-11ed-b11a-0492260c7ca0', 135000, NULL, '2023-02-27 20:37:44', 'maslutfi', NULL, NULL, 0),
('ea4baa40-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'ea3cfe72-b6a3-11ed-b11a-0492260c7ca0', 300000, NULL, '2023-02-27 20:37:44', 'maslutfi', NULL, NULL, 0),
('ec7e9277-b688-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'ec6e480a-b688-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 17:24:31', 'maslutfi', NULL, NULL, 0),
('ec7f3d3b-b688-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'ec6e480a-b688-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 17:24:31', 'maslutfi', NULL, NULL, 0),
('ec800cf8-b688-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'ec6e480a-b688-11ed-b11a-0492260c7ca0', 650000, NULL, '2023-02-27 17:24:31', 'maslutfi', NULL, NULL, 0),
('f4c7f66e-b6a3-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'f4c3d98d-b6a3-11ed-b11a-0492260c7ca0', 450000, NULL, '2023-02-27 20:38:02', 'maslutfi', NULL, NULL, 0),
('f4c82a85-b6a3-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'f4c3d98d-b6a3-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 20:38:02', 'maslutfi', NULL, NULL, 0),
('f4c85cf0-b6a3-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'f4c3d98d-b6a3-11ed-b11a-0492260c7ca0', 660000, NULL, '2023-02-27 20:38:02', 'maslutfi', NULL, NULL, 0),
('facbbd90-b687-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'faba9af5-b687-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:17:46', 'maslutfi', NULL, NULL, 0),
('facc95c6-b687-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'faba9af5-b687-11ed-b11a-0492260c7ca0', 100000, NULL, '2023-02-27 17:17:46', 'maslutfi', NULL, NULL, 0),
('facdccc5-b687-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'faba9af5-b687-11ed-b11a-0492260c7ca0', 150000, NULL, '2023-02-27 17:17:46', 'maslutfi', NULL, NULL, 0),
('fbb13b91-b68d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'fb8e84d1-b68d-11ed-b11a-0492260c7ca0', 500000, NULL, '2023-02-27 18:00:44', 'maslutfi', NULL, NULL, 0),
('fbb18b8a-b68d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'fb8e84d1-b68d-11ed-b11a-0492260c7ca0', 600000, NULL, '2023-02-27 18:00:44', 'maslutfi', NULL, NULL, 0),
('fbb1c4a9-b68d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'fb8e84d1-b68d-11ed-b11a-0492260c7ca0', 700000, NULL, '2023-02-27 18:00:44', 'maslutfi', NULL, NULL, 0),
('fd619a4a-b69d-11ed-b11a-0492260c7ca0', '442ef071-ad27-11ed-8716-0492260c7ca0', 'fd418bba-b69d-11ed-b11a-0492260c7ca0', 350000, NULL, '2023-02-27 19:55:19', 'maslutfi', NULL, NULL, 0),
('fd61fc2a-b69d-11ed-b11a-0492260c7ca0', '8e6d536d-ad44-11ed-8716-0492260c7ca0', 'fd418bba-b69d-11ed-b11a-0492260c7ca0', 350000, NULL, '2023-02-27 19:55:19', 'maslutfi', NULL, NULL, 0),
('fd625140-b69d-11ed-b11a-0492260c7ca0', 'd6e9dd25-ad44-11ed-8716-0492260c7ca0', 'fd418bba-b69d-11ed-b11a-0492260c7ca0', 430000, NULL, '2023-02-27 19:55:19', 'maslutfi', NULL, NULL, 0);

--
-- Triggers `service_prices`
--
DELIMITER $$
CREATE TRIGGER `before_insert_service_prices` BEFORE INSERT ON `service_prices` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `spareparts`
--

CREATE TABLE `spareparts` (
  `id` varchar(36) NOT NULL,
  `name` text NOT NULL,
  `price` int(11) DEFAULT NULL,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `spareparts`
--
DELIMITER $$
CREATE TRIGGER `before_insert_spareparts` BEFORE INSERT ON `spareparts` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(36) NOT NULL,
  `role_id` varchar(36) NOT NULL,
  `name` varchar(300) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(300) NOT NULL,
  `auth_key` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `is_deleted` int(11) NOT NULL DEFAULT 0,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL DEFAULT '',
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `username`, `password`, `auth_key`, `email`, `status`, `is_deleted`, `createdtime`, `createdby`, `updatedtime`, `updatedby`) VALUES
('64911d84-ad26-11ed-8716-0492260c7ca0', '5449543d-ad25-11ed-8716-0492260c7ca0', 'Lutfi', 'maslutfi', '$2y$10$4xchMK.i3F6RzryxK1h88OwTMZSjwFIhIFI2NjJeTlez5HsxlqLa2', NULL, 'maslutfi@mail.com', 1, 0, '2023-02-15 18:46:32', '', '2023-02-18 15:10:09', 'maslutfi'),
('cfd96546-aeca-11ed-a43e-0492260c7ca0', '41c90474-ad25-11ed-8716-0492260c7ca0', 'Rudi Sujarwo', 'pakrudi', '$2y$13$7Kyc4majA78cBlzHr3OFpuEQDCwj.4u7rNJXdh.R88DMhqTESHyFu', NULL, 'rudisujarwo@mail.com', 1, 0, '2023-02-17 20:56:01', 'maslutfi', '2023-02-18 15:10:16', 'maslutfi');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `before_insert_users` BEFORE INSERT ON `users` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `work_orders`
--

CREATE TABLE `work_orders` (
  `id` varchar(36) NOT NULL,
  `customer_id` varchar(36) NOT NULL,
  `number` varchar(11) NOT NULL COMMENT 'nomor PKB',
  `status` varchar(100) NOT NULL,
  `entry_date` date NOT NULL,
  `completion_date` date DEFAULT NULL,
  `total_service` int(11) DEFAULT NULL,
  `total_sparepart` int(11) DEFAULT NULL,
  `grand_total` int(11) DEFAULT NULL,
  `customer_complaints` text DEFAULT NULL,
  `service_advisor` varchar(100) NOT NULL DEFAULT 'Lutfi',
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `work_orders`
--
DELIMITER $$
CREATE TRIGGER `before_insert_work_orders` BEFORE INSERT ON `work_orders` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `work_order_details`
--

CREATE TABLE `work_order_details` (
  `id` varchar(36) NOT NULL,
  `work_order_id` varchar(36) NOT NULL,
  `service_id` varchar(36) DEFAULT NULL,
  `sparepart_id` varchar(36) DEFAULT NULL,
  `manual_price` int(11) DEFAULT NULL,
  `manual_discount` int(11) DEFAULT NULL,
  `subtotal` int(11) DEFAULT NULL,
  `createdtime` datetime NOT NULL DEFAULT current_timestamp(),
  `createdby` varchar(100) NOT NULL,
  `updatedtime` datetime DEFAULT NULL,
  `updatedby` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `work_order_details`
--
DELIMITER $$
CREATE TRIGGER `before_insert_work_order_details` BEFORE INSERT ON `work_order_details` FOR EACH ROW BEGIN 
    SET NEW.id = UUID(); 
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `license_plate` (`license_plate`);

--
-- Indexes for table `generals`
--
ALTER TABLE `generals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `last_number`
--
ALTER TABLE `last_number`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_prices`
--
ALTER TABLE `service_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `spareparts`
--
ALTER TABLE `spareparts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_orders`
--
ALTER TABLE `work_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_order_details`
--
ALTER TABLE `work_order_details`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
