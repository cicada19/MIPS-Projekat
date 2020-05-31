-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 31, 2020 at 12:45 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `esp01`
--

-- --------------------------------------------------------

--
-- Table structure for table `measurement`
--

DROP TABLE IF EXISTS `measurement`;
CREATE TABLE IF NOT EXISTS `measurement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `soil_moisture` float NOT NULL,
  `illumination` float NOT NULL,
  `measured_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `measurement`
--

INSERT INTO `measurement` (`id`, `temperature`, `humidity`, `soil_moisture`, `illumination`, `measured_at`) VALUES
(50, 22, 49, 0, 28, '2020-02-17 08:59:33'),
(49, 20, 52, 0, 19, '2020-02-16 23:20:01'),
(48, 22, 50, 0, 0, '2020-02-16 23:15:07'),
(28, 23, 51, 0, 56, '2020-02-16 16:55:10'),
(29, 23, 50, 0, 56, '2020-02-16 17:02:01'),
(30, 19, 59, 0, 1, '2020-02-16 18:42:02'),
(31, 23, 49, 0, 48, '2020-02-16 19:58:25'),
(32, 22, 49, 0, 58, '2020-02-16 20:28:48'),
(41, 21, 53, 0, 57, '2020-02-16 21:54:07'),
(52, 23, 46, 0, 38, '2020-02-17 09:07:33'),
(51, 23, 45, 0, 54, '2020-02-17 09:04:36'),
(47, 22, 50, 0, 59, '2020-02-16 22:10:10');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(55) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `auth_key` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `token`, `auth_key`) VALUES
(1, 'mare19', '$2y$13$Q1gYdcYXMEKfxAArk.RQYOeay5MHXai6ggTX8GDun8tgMdhU6.33u', 'XVDcITEX9h09XRRY08fiA2phYpEv8u1-', 'SV2xsSFfRMcqUPsK1fEc0q0Yq57jRboF'),
(5, 'admin', '$2y$13$zJmxt.EPGL/NIu3BKHDMtekU7snTxmkpt2Q8csU7jHEMibC16U4Fe', 'ZRZbI35M4D04ZEPgN9ry4Vt2dov10dUb', 'wtugX-x8OaYGliw4gnRJsu2LJT0ZUVvS');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
