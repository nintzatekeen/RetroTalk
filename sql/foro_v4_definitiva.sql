-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 21-05-2021 a las 12:39:56
-- Versión del servidor: 5.7.31
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `foro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(12) NOT NULL,
  `name` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `description` varchar(500) COLLATE latin1_spanish_ci DEFAULT NULL,
  `icon` varchar(500) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `category`
--

INSERT INTO `category` (`id`, `name`, `description`, `icon`) VALUES
(1, 'GENERAL', 'Zona para temas varios', 'fas fa-globe'),
(2, 'CLÁSICO Y VINTAGE', 'Zona de productos clásicos', 'fas fa-gamepad'),
(3, 'HARDWARE Y SOFTWARE RETRO', 'Zona de hardware viejuno', 'fas fa-memory'),
(4, 'COLECCIONES Y GAME ROOMS', 'Zona para mostrar vuestras colecciones retro', 'fas fa-grip-horizontal'),
(5, 'MODERNO Y ACTUAL', 'Zona para productos de la actualidad', 'fas fa-gamepad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `content` varchar(10000) COLLATE latin1_spanish_ci NOT NULL,
  `user` int(12) NOT NULL,
  `thread` int(12) NOT NULL,
  `date` datetime NOT NULL,
  `quote` int(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_UserMessage` (`user`),
  KEY `FK_ThreadMessage` (`thread`),
  KEY `FK_QuoteMessage` (`quote`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `message`
--

INSERT INTO `message` (`id`, `content`, `user`, `thread`, `date`, `quote`) VALUES
(24, 'Hilo creado por el administrador', 1, 12, '2021-05-20 20:29:38', NULL),
(23, 'Hilo creado por el administrador', 1, 11, '2021-05-20 20:29:27', NULL),
(21, 'Hilo creado por el administrador', 1, 9, '2021-05-20 20:29:05', NULL),
(22, 'Hilo creado por el administrador', 1, 10, '2021-05-20 20:29:17', NULL),
(20, 'Hilo creado por el administrador', 1, 8, '2021-05-20 20:28:51', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `private_message`
--

DROP TABLE IF EXISTS `private_message`;
CREATE TABLE IF NOT EXISTS `private_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `message` varchar(10000) COLLATE latin1_spanish_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `product` (`product`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `description` varchar(10000) COLLATE latin1_spanish_ci DEFAULT NULL,
  `price` double NOT NULL,
  `user` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `img` varchar(1000) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `thread`
--

DROP TABLE IF EXISTS `thread`;
CREATE TABLE IF NOT EXISTS `thread` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) COLLATE latin1_spanish_ci NOT NULL,
  `user` int(12) NOT NULL,
  `category` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_UserThread` (`user`),
  KEY `FK_CategoryThread` (`category`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `thread`
--

INSERT INTO `thread` (`id`, `title`, `user`, `category`) VALUES
(9, 'Primer hilo', 1, 2),
(8, 'Primer hilo', 1, 1),
(10, 'Primer hilo', 1, 3),
(11, 'Primer hilo', 1, 4),
(12, 'Primer hilo', 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `password` varchar(500) COLLATE latin1_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `bio` varchar(1000) COLLATE latin1_spanish_ci DEFAULT NULL,
  `avatar` varchar(500) COLLATE latin1_spanish_ci DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `avatar`, `date`) VALUES
(1, 'admin', 'K1c10WgRLh2qNmVMoVTKAOJUQ2mnXxR/5CaJy5wrmKj21gvLwcdCtPqu27PG4qDq', 'nintzatekeen@gmail.com', 'jaja al chile', 'avatars/admin.jpg', '2021-03-05 16:24:56');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
