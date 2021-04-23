-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 23-04-2021 a las 09:49:04
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `foro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=20 ;

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

CREATE TABLE IF NOT EXISTS `private_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `message` varchar(10000) COLLATE latin1_spanish_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `product` (`product`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `product`
--

INSERT INTO `product` (`id`, `title`, `description`, `price`, `user`, `date`, `img`) VALUES
(1, 'Game Boy', 'videoconsola portátil desarrollada y comercializada por Nintendo, lanzada por primera vez en Japón y América del Norte en 1989, y en Europa un año después. Perteneció a la línea de consolas Game Boy, siendo esta la primera de la serie.', 65, 1, '2021-04-19 15:20:05', 'GameBoy1'),
(2, 'Nintendo 64', 'Nintendo 64 es la cuarta videoconsola de sobremesa producida por Nintendo, desarrollada para suceder a la Super Nintendo y para competir con el Saturn de Sega y la PlayStation de Sony. ', 180, 1, '2021-04-20 16:11:38', 'Nintendo642'),
(3, 'Sega Saturn', 'Sega Saturn es la quinta videoconsola de sobremesa producida por Sega. Fue desarrollada para suceder a la Mega Drive/Genesis y competir contra la 3DO Interactive Multiplayer, Atari Jaguar, Neo Geo CD, PlayStation, y más adelante Nintendo 64, entre otras.', 64.95, 1, '2021-04-13 09:56:07', 'SegaSaturn3'),
(4, 'Tekken 3 PS1', 'Tekken 3 es la tercera entrega de Tekken, la popular serie de juegos de lucha. Fue el primer juego lanzado en el hardware del System 12 de Namco en 1997 (una mejora a los dos juegos originales de Tekken, que utilizaron el System 11), aparte de ser la última entrega de Tekken para PlayStation. Fue lanzado para PlayStation en 1998 y en 2005 para PlayStation 2 como parte del Modo Historia del Arcade de Tekken 5.', 12.5, 1, '2021-04-16 14:13:19', 'Tekken34'),
(5, 'Super Mario 64', 'Super Mario 64 es un videojuego de plataformas de mundo abierto para la videoconsola Nintendo 64, desarrollado por Nintendo Entertainment Analysis and Development y publicado por la propia Nintendo. Su debut en Japón fue el 23 de junio de 1996, en América del Norte el 29 de septiembre de 1996 y en Europa el 1 de marzo de 1997.5? Junto con Pilotwings 64, fue uno de los títulos de lanzamiento para la consola.? Como el juego principal del nuevo sistema de Nintendo, fortaleció las primeras ventas de la Nintendo 64, y ha llegado a vender más de 11 millones de copias en total,? sin incluir las ventas de la Consola Virtual de Wii y Wii U y su inclusión en el juego Super Mario 3D All Stars para Nintendo Switch. ', 30, 1, '2021-04-17 08:06:43', 'SuperMario645'),
(6, 'Sonic 1991', 'Sonic the Hedgehog es un videojuego desarrollado por Sonic Team y distribuido por Sega en 1991 para la videoconsola Sega Mega Drive protagonizado por Sonic. Este videojuego de plataformas fue, durante mucho tiempo, considerado el buque insignia de Sega, el ejemplo a seguir para sus futuros juegos. Incluso llegó a dar nombre a uno de sus equipos de desarrollo: Sonic Team. ', 26, 1, '2021-04-20 19:04:01', 'Sonic19916'),
(7, 'The Legend of Zelda: Ocarina of Time', 'The Legend of Zelda: Ocarina of Time es un videojuego de acción-aventura de 1998 desarrollado por la filial Nintendo EAD y publicado por Nintendo para la consola Nintendo 64. Fue lanzado en Japón el 21 de noviembre de 1998,7 mientras que a Norteamérica llegó dos días después, el 23 de noviembre, y en Europa se estrenó el 11 de diciembre de ese mismo año. Para el caso de Sudamérica, fue presentado en Chile el 23 de noviembre de 1998 en un evento especial para periodistas. A pesar de que en un inicio los diseñadores planeaban lanzar el juego para el periférico Nintendo 64DD, al final se optó por diseñarlo para un cartucho de 256 megabits (igual a 32 megabytes), que eran los de mayor capacidad producidos por Nintendo en ese entonces.Ocarina of Time es el quinto lanzamiento de la franquicia The Legend of Zelda, y se convirtió en el primero de la serie en hacer uso de gráficos 3D.', 55, 1, '2021-04-18 17:15:09', 'OcarinaofTime7'),
(8, 'Mega Drive', 'Mega Drive, conocida en diversos territorios de América como Genesis, es una clásica videoconsola de sobremesa de 16 bits desarrollada por Sega Enterprises, Ltd. Mega Drive fue la tercera consola de Sega y la sucesora de Master System. Compitió contra la SNES de Nintendo, como parte de las videoconsolas de cuarta generación. La primera versión fue lanzada en Japón en 1988, sucedida por el lanzamiento en Norteamérica bajo el renombramiento de Genesis en 1989.', 160, 1, '2021-04-19 17:05:14', 'MegaDrive8'),
(9, 'Xbox', 'Xbox, también llamada Xbox Clásica, es una videoconsola de sobremesa de la sexta generación de consolas producida por Microsoft y la primera de esta empresa, en colaboración con Intel. Su principal característica es su procesador central basado en el procesador Intel Pentium III. El sistema también incorpora un lector de DVD, un disco duro interno, un puerto ethernet, y por último el sistema dispone de cuatro conectores para los mandos. Las unidades vendidas de este equipo fueron 24 000 000 consolas, según las cifras oficiales', 105, 1, '2021-04-11 19:07:22', 'Xbox9');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `thread`
--

CREATE TABLE IF NOT EXISTS `thread` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) COLLATE latin1_spanish_ci NOT NULL,
  `user` int(12) NOT NULL,
  `category` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_UserThread` (`user`),
  KEY `FK_CategoryThread` (`category`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=8 ;

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

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `password` varchar(500) COLLATE latin1_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `bio` varchar(1000) COLLATE latin1_spanish_ci DEFAULT NULL,
  `avatar` varchar(500) COLLATE latin1_spanish_ci DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `bio`, `avatar`, `date`) VALUES
(1, 'admin', 'K1c10WgRLh2qNmVMoVTKAOJUQ2mnXxR/5CaJy5wrmKj21gvLwcdCtPqu27PG4qDq', 'nintzatekeen@gmail.com', 'jaja al chile', 'avatars/admin.jpg', '2021-03-05 16:24:56'),
(3, 'Pepe', 'Qbv+VT9rxDBfzSO3ah0hR1kgq5oaTHcJMthfhlCXa1e5CLrav2oEwd81payY31Lk', 'falso@asd.com', NULL, NULL, '2021-04-23 11:43:15');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
