-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 25-10-2025 a las 15:36:31
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
-- Base de datos: `history_terror`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historias`
--

CREATE TABLE `historias` (
  `id_historia` int(11) NOT NULL,
  `Id_usuario` int(11) DEFAULT NULL,
  `titulo` varchar(150) NOT NULL,
  `autor` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `archivo_pdf` varchar(255) DEFAULT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `estado` enum('pendiente','aprobado','rechazado') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historias`
--

INSERT INTO `historias` (`id_historia`, `Id_usuario`, `titulo`, `autor`, `descripcion`, `archivo_pdf`, `fecha_publicacion`, `estado`) VALUES
(1, 2, 'El origen de las máquinas', 'Carlos Castillo', 'Ensayo sobre la evolución de la automatización industrial.', 'origen_maquinas.pdf', '2025-10-25', 'pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `Id_rol` int(11) NOT NULL,
  `nombreRol` varchar(50) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`Id_rol`, `nombreRol`, `Descripcion`) VALUES
(1, 'Administrador', 'Gestiona usuarios y contenidos'),
(2, 'Estudiante', 'Puede subir y leer historias'),
(3, 'Revisor', 'Evalúa historias enviadas por los usuarios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Id_usuario` int(11) NOT NULL,
  `Id_rol` int(11) DEFAULT NULL,
  `Nombre` varchar(50) NOT NULL,
  `ApellidoP` varchar(50) NOT NULL,
  `ApellidoM` varchar(50) NOT NULL,
  `Carrera` varchar(100) DEFAULT NULL,
  `Semestre` varchar(20) DEFAULT NULL,
  `Matricula` varchar(30) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Id_usuario`, `Id_rol`, `Nombre`, `ApellidoP`, `ApellidoM`, `Carrera`, `Semestre`, `Matricula`, `correo`) VALUES
(1, 1, 'Jonathan', 'Hernández', 'González', 'Ingeniería en Sistemas Computacionales', '7º', 'ISC2025001', 'jonathan@example.com'),
(2, 2, 'Carlos', 'Castillo', 'López', 'Ingeniería Industrial', '6º', 'IND2025002', 'carlos@example.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `historias`
--
ALTER TABLE `historias`
  ADD PRIMARY KEY (`id_historia`),
  ADD KEY `Id_usuario` (`Id_usuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Id_usuario`),
  ADD UNIQUE KEY `Matricula` (`Matricula`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `Id_rol` (`Id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `historias`
--
ALTER TABLE `historias`
  MODIFY `id_historia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `Id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `historias`
--
ALTER TABLE `historias`
  ADD CONSTRAINT `historias_ibfk_1` FOREIGN KEY (`Id_usuario`) REFERENCES `usuarios` (`Id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`Id_rol`) REFERENCES `roles` (`Id_rol`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
