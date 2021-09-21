-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 21, 2021 at 01:02 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog_flask`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phoneno` varchar(20) NOT NULL,
  `message` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`sno`, `name`, `email`, `phoneno`, `message`, `date`) VALUES
(1, 'shoaib', 'email@gamil.com', '1234', 'asdadad', '2021-09-18 23:34:11'),
(2, 'Shoaib Abdul Jabbar', 'shoaib@gmail.com', '3333333', 'hi this is shoaib', NULL),
(3, 'Shoaib Abdul Jabbar', '1@email.com', '3333333', 'asdasdada', NULL),
(4, 'Shoaib Abdul Jabbar', '1@email.com', '3333333', 'asdasdada', NULL),
(5, 'Shoaib Abdul Jabbar', '1@email.com', '3333333', 'asdasdada', NULL),
(6, 'Shoaib Abdul ', 'jarvis@gmail.com', '3242422', 'hsadasddadasdasdadasddada', NULL),
(7, 'Shoaib Abdul ', 'jarvis@gmail.com', '3242422', 'hsadasddadasdasdadasddada', NULL),
(8, 'Shoaib Abdul Jabbar', 'shoaib@gmail.com', '3242422', 'dadad', NULL),
(9, '', 'shoaib@gmail.com', '3333333ds', 'dsffds', NULL),
(10, '', 'shoaib@gmail.com', '3333333ds', 'dsffds', '2021-09-18 23:56:07'),
(11, 'Shoaib Abdul Jabbar', 'shoaib@gmail.com', '9108897933', 'sadasdada', '2021-09-18 23:56:25'),
(12, 'Shoaib Abdul Jabbar', 'shoaib@gmail.com', '9108897933', 'sadasdada', '2021-09-18 23:59:14'),
(13, 'Shoaib Abdul Jabbar', 'shoaib@gmail.com', '9108897933', 'sadasdada', '2021-09-18 23:59:34'),
(14, 'Shoaib Abdul Jabbar', 'shoaib@gmail.com', '3333333ds', 'sdfds', '2021-09-18 23:59:45'),
(15, 'ronadlo', 'ronaldo@gmail.com', '7777777777', 'best', '2021-09-19 00:00:30'),
(16, 'messi', 'messi@gmail.com', '10000', 'asdasdas', '2021-09-19 00:01:09'),
(17, 'Shoaib Abdul Jabbar', 'shoaib@gmail.com', '3242422sa', 'saasas', '2021-09-19 00:03:03'),
(23, 'Shoaib Abdul Jabbar', 'shoaib@gmail.com', '9108897933', 'Its working', '2021-09-19 13:06:53');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `slug` varchar(50) NOT NULL,
  `image_file` varchar(50) NOT NULL,
  `tagline` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `content`, `date`, `slug`, `image_file`, `tagline`) VALUES
(1, 'This is my first post title', 'Content', '2021-09-19 13:54:58', 'first_post', 'home-bg.jpg', 'Tagline of first post'),
(2, 'This is my second post', 'second post content and it is edited by admin', '2021-09-20 17:55:05', 'second_post', 'about-bg.jpg', 'Tagline of second post'),
(3, 'this is my fourth post', 'this is my fourth post', '2021-09-21 15:06:19', 'fourth_post', 'about-bg.jpg', 'this is my fourth post'),
(4, 'this is my thire post', 'this is my thire post', '2021-09-21 15:05:32', 'third_post', 'about-bg.jpg', 'this is my thire post'),
(5, 'this is my fifth post', 'this is my fifth post', '2021-09-21 15:08:24', 'fifth_post', 'about-bg.jpg', 'this is my fifth post');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
