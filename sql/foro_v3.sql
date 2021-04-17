-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 17-04-2021 a las 15:20:46
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
(1, 'GENERAL', 'Zona para hablar de temas varios.', ''),
(2, 'Weas', 'Weas xD', NULL);

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
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `message`
--

INSERT INTO `message` (`id`, `content`, `user`, `thread`, `date`, `quote`) VALUES
(1, 'Hehe boi', 1, 1, '2021-03-05 16:26:27', NULL),
(2, 'jaja k loko xd', 1, 1, '2021-03-14 15:52:43', NULL),
(3, 'ouisdfjosdifhs', 1, 2, '2021-03-25 18:45:06', NULL),
(5, 'kdnbawijdbsj', 1, 2, '2021-03-25 18:47:23', NULL),
(16, '[img]https://e00-marca.uecdn.es/assets/multimedia/imagenes/2020/09/08/15995636175475.jpg[/img]', 1, 2, '2021-04-05 15:16:22', NULL),
(17, '[quote]1[/quote] pelotudo', 1, 2, '2021-04-05 15:49:07', NULL),
(18, '[img]https://upload.wikimedia.org/wikipedia/commons/1/13/Red_2019_Ferrari_SF90_Stradale_%2848264238897%29_%28cropped%29.jpg[/img]\r\nPeaso de buga xd', 1, 2, '2021-04-05 16:04:07', NULL),
(19, '[quote]3[/quote][quote]5[/quote]jajaja', 1, 2, '2021-04-05 16:17:45', NULL);

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
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `thread`
--

INSERT INTO `thread` (`id`, `title`, `user`, `category`) VALUES
(1, 'Yoqsetio xDxDD', 1, 1),
(2, 'aa sos retroll', 1, 1);

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
