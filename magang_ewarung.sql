-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2021 at 08:17 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `magang_ewarung`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(30) NOT NULL,
  `category` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`) VALUES
(1, 'Daging'),
(2, 'Sayuran'),
(3, 'Buah'),
(4, 'Produk UMKM');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(30) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `category` int(30) NOT NULL,
  `buy_price` int(11) NOT NULL,
  `sell_price` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `satuan` enum('Pcs','Kg','Paket') NOT NULL,
  `is_ready` tinyint(1) DEFAULT 0,
  `photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_name`, `category`, `buy_price`, `sell_price`, `stock`, `satuan`, `is_ready`, `photo`) VALUES
(1, 'Daging Sapi', 1, 108000, 110000, 2000, 'Kg', 1, ''),
(2, 'Buah Apel', 3, 24000, 25000, 300, 'Pcs', 1, NULL),
(3, 'Daging Kambing', 1, 80000, 82000, 3000, 'Kg', 1, NULL),
(4, 'Selada', 2, 2000, 4000, 250, 'Paket', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` int(30) NOT NULL,
  `warung` int(30) NOT NULL,
  `is_stocked` tinyint(1) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `warung`, `is_stocked`, `date`) VALUES
(1, 1, 0, '2021-10-15 04:39:19'),
(2, 2, 0, '2021-10-15 04:39:19'),
(3, 1, 1, '2021-10-15 04:39:19'),
(4, 2, 1, '2021-10-15 04:39:19');

-- --------------------------------------------------------

--
-- Table structure for table `stock_request`
--

CREATE TABLE `stock_request` (
  `id` int(30) NOT NULL,
  `product` int(30) NOT NULL,
  `request` int(30) NOT NULL,
  `stock` int(11) NOT NULL,
  `is_accepted` tinyint(1) DEFAULT NULL,
  `alasan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock_request`
--

INSERT INTO `stock_request` (`id`, `product`, `request`, `stock`, `is_accepted`, `alasan`) VALUES
(1, 4, 1, 400, NULL, NULL),
(2, 1, 1, 200, 0, 'stok kosong'),
(3, 2, 3, 200, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stok_warung`
--

CREATE TABLE `stok_warung` (
  `id` int(30) NOT NULL,
  `warung` int(30) NOT NULL,
  `product` int(30) NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stok_warung`
--

INSERT INTO `stok_warung` (`id`, `warung`, `product`, `stock`) VALUES
(1, 1, 2, 250),
(3, 2, 1, 4000);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(30) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('1','2') NOT NULL DEFAULT '1',
  `photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`, `role`, `photo`) VALUES
(1, 'Nicky Erlangga', 'nerlangga@gmail.com', 'nerlangga', '12345678', '1', ''),
(2, 'Agassi Putra', 'agassi@gmail.com', 'agassi', '12345678', '2', '');

-- --------------------------------------------------------

--
-- Table structure for table `warung`
--

CREATE TABLE `warung` (
  `id` int(30) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user` int(30) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warung`
--

INSERT INTO `warung` (`id`, `name`, `user`, `alamat`) VALUES
(1, 'Warung Ekonomis', 1, 'Jl.Sumber galian no.45'),
(2, 'Warung Kapitalis', 2, 'Jl.ke Surga no.50'),
(3, 'Warung Komunis', 1, 'JL. ke Neraka no.02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_category` (`category`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_warung3` (`warung`);

--
-- Indexes for table `stock_request`
--
ALTER TABLE `stock_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_product` (`product`),
  ADD KEY `rel_request` (`request`);

--
-- Indexes for table `stok_warung`
--
ALTER TABLE `stok_warung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_warung` (`warung`),
  ADD KEY `rel_product1` (`product`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warung`
--
ALTER TABLE `warung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_user1` (`user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `stock_request`
--
ALTER TABLE `stock_request`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stok_warung`
--
ALTER TABLE `stok_warung`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `warung`
--
ALTER TABLE `warung`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `rel_category` FOREIGN KEY (`category`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `rel_warung3` FOREIGN KEY (`warung`) REFERENCES `warung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stock_request`
--
ALTER TABLE `stock_request`
  ADD CONSTRAINT `rel_product` FOREIGN KEY (`product`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_request` FOREIGN KEY (`request`) REFERENCES `requests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stok_warung`
--
ALTER TABLE `stok_warung`
  ADD CONSTRAINT `rel_product1` FOREIGN KEY (`product`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `rel_warung` FOREIGN KEY (`warung`) REFERENCES `warung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `warung`
--
ALTER TABLE `warung`
  ADD CONSTRAINT `rel_user1` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
