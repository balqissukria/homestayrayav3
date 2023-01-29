-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 29, 2023 at 06:57 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `homestayraya`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_homestay`
--

CREATE TABLE `tbl_homestay` (
  `homestay_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `homestay_name` varchar(255) NOT NULL,
  `homestay_desc` varchar(255) NOT NULL,
  `homestay_price` varchar(255) NOT NULL,
  `homestay_qty` int(10) NOT NULL,
  `homestay_state` varchar(255) NOT NULL,
  `homestay_local` varchar(255) NOT NULL,
  `homestay_lat` varchar(255) NOT NULL,
  `homestay_lng` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_homestay`
--

INSERT INTO `tbl_homestay` (`homestay_id`, `user_id`, `homestay_name`, `homestay_desc`, `homestay_price`, `homestay_qty`, `homestay_state`, `homestay_local`, `homestay_lat`, `homestay_lng`) VALUES
(6, 5, 'DVilla Raudhah', 'Available for family', '200', 2, 'Kedah', 'Changlun', '6.4027317', '100.42339'),
(7, 5, 'Permai Indah', 'Good environment and chepest price', '120', 2, 'Kedah', 'Changlun', '6.4027317', '100.42339'),
(8, 6, 'Forest Vill', 'Enviroment : 100%', '240', 1, 'Kedah', 'Changlun', '6.4027317', '100.42339'),
(9, 6, 'DFore Home', 'In green environment ', '230', 1, 'Kedah', 'Changlun', '6.4027317', '100.42339'),
(10, 6, 'Frest Dvillage', 'Good for people who love green view', '300', 1, 'Kedah', 'Changlun', '6.4027317', '100.42339'),
(11, 1, 'Cute Homstay Raya', 'Great View and great scenery', '200', 2, 'Kedah', 'Changlun', '6.4027317', '100.42339'),
(13, 1, 'British DHomestay', 'Elegant Look for stay in this homestay', '320', 2, 'Kedah', 'Changlun', '6.4027317', '100.42339'),
(14, 1, 'Sehijau Vill', 'A great place to stay with love', '200', 1, 'Kedah', 'Changlun', '6.4027317', '100.42339');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(5) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_phone` varchar(15) NOT NULL,
  `user_password` varchar(50) NOT NULL,
  `user_address` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_name`, `user_email`, `user_phone`, `user_password`, `user_address`) VALUES
(1, 'Balqis Sukria', 'balqis00@gmail.com', '0174992898', '9fc6b8b152a3de41e3f6909a9d9e26b6ca82af10', 'na'),
(2, '', '', '', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', 'na'),
(3, 'Meimei', 'mei@gmail.com', '0198765432', 'd8bff44165dfde9b9620c1caf6e60baf71e9bab3', 'na'),
(4, 'Qiqish', 'Qish00@gmail.com', '0192765502', '9fc6b8b152a3de41e3f6909a9d9e26b6ca82af10', 'na'),
(5, 'Syazwan', 'syazwan@gmail.com', '01121414052', '9fc6b8b152a3de41e3f6909a9d9e26b6ca82af10', 'na'),
(6, 'Raneea', 'Raneea@gmail.com', '0174662325', '9fc6b8b152a3de41e3f6909a9d9e26b6ca82af10', 'na'),
(7, 'Bush', 'bush@gmail.com', '01876445231', '9fc6b8b152a3de41e3f6909a9d9e26b6ca82af10', 'na'),
(8, 'Ajmal', 'ajmal@gmail.com', '01154233112', '9fc6b8b152a3de41e3f6909a9d9e26b6ca82af10', 'na');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_homestay`
--
ALTER TABLE `tbl_homestay`
  ADD PRIMARY KEY (`homestay_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_homestay`
--
ALTER TABLE `tbl_homestay`
  MODIFY `homestay_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
