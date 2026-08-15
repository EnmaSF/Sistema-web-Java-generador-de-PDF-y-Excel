-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-05-2026 a las 05:51:18
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tareaexcelpdf`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `rol` varchar(100) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `PASSWORD` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `rol`, `nombre`, `username`, `PASSWORD`) VALUES
(1, 'Administrador', 'Enmanuel Suarez', 'enadmin', '1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `categoria`, `nombre`, `precio`, `stock`) VALUES
(1, 'Ropa masculina', 'Abrigo Hombre La Martina color beige', 400.00, 70),
(2, 'Accesorios de celular', 'Power Bank Xiaomi 20000mAh 33W Fast Charger Azul', 180.00, 50),
(3, 'Electrodomesticos de cocina', 'Licuadora Profesional 2L Potencia Maxima 1400W BN701CL', 590.00, 60),
(4, 'Televisores', 'Televisor 65\" Qled Q7f Vision Ai Smart Tv', 3000.00, 56),
(5, 'Parlantes', 'Torre de sonido LG XBOOM OK99M 2000W Bluetooth Karaoke Star', 2200.00, 61),
(6, 'Tablets', 'Tablet Samsung Galaxy Tab A11 8.7\" 4GB + 64GB Gris', 800.00, 45),
(7, 'Impresoras', 'Impresora multifuncional L3250 EPSON', 760.00, 52),
(8, 'Laptops', 'Laptop Gamer Victus Amd Ryzen 7 Rtx 4050 16 Gb Ram  1tb Ssd 15.6\"  15-fb3036la Nvidia Geforce', 4700.00, 43),
(9, 'SmartWatchs', 'Anillo Inteligente Ring 4 OURA', 1300.00, 45),
(10, 'SmartWatchs', 'SAMSUNG Galaxy Fit3', 240.00, 59);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
