-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 29, 2023 at 06:51 PM
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_homestay`
--
ALTER TABLE `tbl_homestay`
  ADD PRIMARY KEY (`homestay_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_homestay`
--
ALTER TABLE `tbl_homestay`
  MODIFY `homestay_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
