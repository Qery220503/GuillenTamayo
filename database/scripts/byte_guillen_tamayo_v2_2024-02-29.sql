-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 29, 2024 at 03:49 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `byte_guillen_tamayo`
--

-- --------------------------------------------------------

--
-- Table structure for table `afectacion_igv`
--

CREATE TABLE `afectacion_igv` (
  `cod_afectacion` int UNSIGNED NOT NULL,
  `descripcion` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `afectacion_igv`
--

INSERT INTO `afectacion_igv` (`cod_afectacion`, `descripcion`) VALUES
(10, 'GRAVADO - OPERACIÓN ONEROSA'),
(11, 'GRAVADO – RETIRO POR PREMIO'),
(12, 'GRAVADO – RETIRO POR DONACIÓN'),
(13, 'GRAVADO – RETIRO'),
(14, 'GRAVADO – RETIRO POR PUBLICIDAD'),
(15, 'GRAVADO – BONIFICACIONES'),
(16, 'GRAVADO – RETIRO POR ENTREGA A TRABAJADORES'),
(17, 'GRAVADO – IVAP'),
(20, 'EXONERADO - OPERACIÓN ONEROSA'),
(21, 'EXONERADO – TRANSFERENCIA GRATUITA'),
(30, 'INAFECTO - OPERACIÓN ONEROSA '),
(31, 'INAFECTO – RETIRO POR BONIFICACIÓN'),
(32, 'INAFECTO – RETIRO'),
(33, 'INAFECTO – RETIRO POR MUESTRAS MÉDICAS'),
(34, 'INAFECTO - RETIRO POR CONVENIO COLECTIVO'),
(35, 'INAFECTO – RETIRO POR PREMIO'),
(36, 'INAFECTO - RETIRO POR PUBLICIDAD'),
(40, 'EXPORTACIÓN DE BIENES O SERVICIOS');

-- --------------------------------------------------------

--
-- Table structure for table `almacen_movimientos`
--

CREATE TABLE `almacen_movimientos` (
  `id_almacen_movimientos` int UNSIGNED NOT NULL,
  `id_tipo_movimiento` int UNSIGNED DEFAULT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `id_producto` int UNSIGNED DEFAULT NULL,
  `cantidad` decimal(11,2) NOT NULL DEFAULT '0.00',
  `stock_inicial` decimal(11,2) NOT NULL DEFAULT '0.00',
  `stock_actual` decimal(11,2) NOT NULL DEFAULT '0.00',
  `precio_unitario` decimal(11,2) NOT NULL DEFAULT '0.00',
  `precio_total` decimal(11,2) NOT NULL DEFAULT '0.00',
  `codigo_producto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_producto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `almacen_movimientos`
--

INSERT INTO `almacen_movimientos` (`id_almacen_movimientos`, `id_tipo_movimiento`, `id_sucursal`, `id_producto`, `cantidad`, `stock_inicial`, `stock_actual`, `precio_unitario`, `precio_total`, `codigo_producto`, `nombre_producto`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 1, '1.00', '990.00', '989.00', '887.00', '887.00', 'A001-02GUC24', 'GUCCI A001-02GUC24', '2024-02-23 16:59:41', '2024-02-23 11:59:41'),
(2, 2, 2, 1, '1.00', '989.00', '988.00', '887.00', '887.00', 'A001-02GUC24', 'GUCCI A001-02GUC24', '2024-02-26 15:24:51', '2024-02-26 10:24:51'),
(3, 2, 2, 1, '1.00', '988.00', '987.00', '887.00', '887.00', 'A001-02GUC24', 'GUCCI A001-02GUC24', '2024-02-26 15:42:47', '2024-02-26 10:42:47');

-- --------------------------------------------------------

--
-- Table structure for table `almacen_movimientos_tipos`
--

CREATE TABLE `almacen_movimientos_tipos` (
  `id_tipo_movimiento` int UNSIGNED NOT NULL,
  `tipo_movimiento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `almacen_movimientos_tipos`
--

INSERT INTO `almacen_movimientos_tipos` (`id_tipo_movimiento`, `tipo_movimiento`) VALUES
(1, 'ENTRADA COMPRA'),
(2, 'SALIDA VENTA'),
(3, 'DEVOLUCIÓN'),
(4, 'ENTRADA MANUAL');

-- --------------------------------------------------------

--
-- Table structure for table `anamnesis`
--

CREATE TABLE `anamnesis` (
  `id_anamnesis` int UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `id_cliente` int UNSIGNED DEFAULT NULL,
  `id_clinica` int UNSIGNED DEFAULT NULL,
  `id_doctor` int UNSIGNED DEFAULT NULL,
  `id_empresa_convenio` int UNSIGNED DEFAULT NULL,
  `sintomas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `medicamentos` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `frecuencia_visita` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `antecedentes_familiares` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `estado` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `anamnesis`
--

INSERT INTO `anamnesis` (`id_anamnesis`, `id_sucursal`, `id_cliente`, `id_clinica`, `id_doctor`, `id_empresa_convenio`, `sintomas`, `medicamentos`, `frecuencia_visita`, `antecedentes_familiares`, `estado`, `created_at`, `updated_at`) VALUES
(1, 2, 4, 1, 1, 1, 'OJO SECO,DIABETES', '', '', 'DESPRENDIMIENTO DE RETINA,PRESIÓN ARTERIAL,QUERATOCONO', 0, '2024-02-23 16:58:54', '2024-02-23 16:59:41'),
(2, 2, 4, 1, 1, 1, 'OJO SECO,DOLOR DE CABEZA,DIABETES', 'JKJHKJ', 'GGJHG', 'DESPRENDIMIENTO DE RETINA,RETINOPATIA DIABETICA,GLAUCOMA', 0, '2024-02-23 17:09:47', '2024-02-26 15:42:47'),
(3, 2, 4, 1, 1, 1, 'OJO SECO,ESTRABISMO,DIABETES', '', '', '', 1, '2024-02-26 15:55:05', '2024-02-26 15:55:05');

-- --------------------------------------------------------

--
-- Table structure for table `anamnesis_estados_historico`
--

CREATE TABLE `anamnesis_estados_historico` (
  `id` bigint UNSIGNED NOT NULL,
  `anamnesis_id` int UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `fecha` date DEFAULT NULL,
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `anamnesis_estados_historico`
--

INSERT INTO `anamnesis_estados_historico` (`id`, `anamnesis_id`, `user_id`, `fecha`, `estado`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2024-02-23', 'anamnesis_creada', '2024-02-23 16:58:54', '2024-02-23 16:58:54'),
(2, 1, 2, '2024-02-23', 'anamnesis_paso_1', '2024-02-23 16:58:54', '2024-02-23 16:58:54'),
(3, 1, 2, '2024-02-23', 'anamnesis_paso_2', '2024-02-23 16:59:22', '2024-02-23 16:59:22'),
(4, 1, 2, '2024-02-23', 'anamnesis_paso_3', '2024-02-23 16:59:41', '2024-02-23 16:59:41'),
(5, 1, 2, '2024-02-23', 'anamnesis_cerrada', '2024-02-23 16:59:41', '2024-02-23 16:59:41'),
(6, 2, 2, '2024-02-23', 'anamnesis_creada', '2024-02-23 17:09:47', '2024-02-23 17:09:47'),
(7, 2, 2, '2024-02-23', 'anamnesis_paso_1', '2024-02-23 17:09:47', '2024-02-23 17:09:47'),
(8, 2, 2, '2024-02-23', 'anamnesis_paso_2', '2024-02-23 17:12:33', '2024-02-23 17:12:33'),
(9, 1, 2, '2024-02-26', 'anamnesis_paso_3', '2024-02-26 15:24:51', '2024-02-26 15:24:51'),
(10, 1, 2, '2024-02-26', 'anamnesis_cerrada', '2024-02-26 15:24:51', '2024-02-26 15:24:51'),
(11, 2, 2, '2024-02-26', 'anamnesis_paso_3', '2024-02-26 15:42:47', '2024-02-26 15:42:47'),
(12, 2, 2, '2024-02-26', 'anamnesis_cerrada', '2024-02-26 15:42:47', '2024-02-26 15:42:47'),
(13, 3, 2, '2024-02-26', 'anamnesis_creada', '2024-02-26 15:55:05', '2024-02-26 15:55:05'),
(14, 3, 2, '2024-02-26', 'anamnesis_paso_1', '2024-02-26 15:55:05', '2024-02-26 15:55:05'),
(15, 3, 2, '2024-02-26', 'anamnesis_paso_2', '2024-02-26 18:28:25', '2024-02-26 18:28:25');

-- --------------------------------------------------------

--
-- Table structure for table `caja`
--

CREATE TABLE `caja` (
  `id_caja` int UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `monto_inicial` decimal(11,2) DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `caja`
--

INSERT INTO `caja` (`id_caja`, `id_sucursal`, `id_usuario`, `monto_inicial`, `estado`, `created_at`, `updated_at`) VALUES
(1, 2, 2, '0.00', 0, '2024-02-23 16:52:18', '2024-02-26 15:24:20'),
(2, 2, 2, '100.00', 0, '2024-02-26 15:24:25', '2024-02-27 16:28:45'),
(3, 2, 2, '0.00', 0, '2024-02-27 16:28:48', '2024-02-28 13:23:12'),
(4, 2, 2, '0.00', 1, '2024-02-28 13:23:16', '2024-02-28 13:23:16'),
(5, 2, 2, '0.00', 1, '2024-02-29 13:54:58', '2024-02-29 13:54:58');

-- --------------------------------------------------------

--
-- Table structure for table `caja_cuadre`
--

CREATE TABLE `caja_cuadre` (
  `id_cuadre` int UNSIGNED NOT NULL,
  `id_caja` int UNSIGNED NOT NULL,
  `centimos10` int NOT NULL,
  `centimos20` int NOT NULL,
  `centimos50` int NOT NULL,
  `soles1` int NOT NULL,
  `soles2` int NOT NULL,
  `soles5` int NOT NULL,
  `soles10` int NOT NULL,
  `soles20` int NOT NULL,
  `soles50` int NOT NULL,
  `soles100` int NOT NULL,
  `soles200` int NOT NULL,
  `total` int NOT NULL,
  `sobrante_faltante` int NOT NULL,
  `observacion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_estado` int UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `motivo_eliminacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `caja_cuadre_estado`
--

CREATE TABLE `caja_cuadre_estado` (
  `id_estado` int UNSIGNED NOT NULL,
  `nombre_estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT '#FFF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `caja_cuadre_estado`
--

INSERT INTO `caja_cuadre_estado` (`id_estado`, `nombre_estado`, `color`) VALUES
(1, 'CAJA CUADRADA', 'success'),
(2, 'SOBRA DINERO', 'warning'),
(3, 'FALTA DINERO', 'error');

-- --------------------------------------------------------

--
-- Table structure for table `caja_turnos`
--

CREATE TABLE `caja_turnos` (
  `id_caja_turno` int UNSIGNED NOT NULL,
  `nombre_turno` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `caja_turnos`
--

INSERT INTO `caja_turnos` (`id_caja_turno`, `nombre_turno`) VALUES
(1, 'MAÑANA'),
(2, 'TARDE');

-- --------------------------------------------------------

--
-- Table structure for table `calendario_feriados`
--

CREATE TABLE `calendario_feriados` (
  `id` int UNSIGNED NOT NULL,
  `fecha` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `calendario_feriados`
--

INSERT INTO `calendario_feriados` (`id`, `fecha`) VALUES
(1, '2023-01-01'),
(2, '2023-04-06'),
(3, '2023-04-07'),
(4, '2023-05-01'),
(5, '2023-06-29'),
(6, '2023-07-28'),
(7, '2023-07-29'),
(8, '2023-08-06'),
(9, '2023-08-30'),
(10, '2023-10-08'),
(11, '2023-11-01'),
(12, '2023-12-08'),
(13, '2023-12-09'),
(14, '2023-12-25');

-- --------------------------------------------------------

--
-- Table structure for table `campanas`
--

CREATE TABLE `campanas` (
  `id` bigint NOT NULL,
  `name` varchar(255) NOT NULL,
  `id_user` bigint UNSIGNED NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `active` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int UNSIGNED NOT NULL,
  `id_rubro_trabajo` int UNSIGNED DEFAULT NULL,
  `id_ocupacion` int UNSIGNED DEFAULT NULL,
  `cod_tipo_doc` int UNSIGNED DEFAULT NULL,
  `nro_documento` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '00000000',
  `nombre_razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono_adic` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_departamento` int UNSIGNED DEFAULT NULL,
  `id_provincia` int UNSIGNED DEFAULT NULL,
  `id_distrito` int UNSIGNED DEFAULT NULL,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lista_negra` tinyint DEFAULT NULL COMMENT 'usuario esta en lista ngra? 1=SI, 0=NO',
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `id_rubro_trabajo`, `id_ocupacion`, `cod_tipo_doc`, `nro_documento`, `nombre_razon_social`, `fecha_nacimiento`, `telefono`, `telefono_adic`, `email`, `id_departamento`, `id_provincia`, `id_distrito`, `direccion`, `lista_negra`, `estado`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 1, '00000000', 'CLIENTES VARIOS', '2000-01-01', '000000000', '000000000', '-', 4, 401, 40105, 'Sin Dirección', 0, 1, '2022-12-02 19:54:40', '2022-12-02 19:54:40'),
(2, NULL, 5, 1, '75465465', 'JOSE ENRIQUE PISCONTE CHALAN', '2023-01-10', '123456789', '324324324', 'DASDASD@FFEFWEWR.PE', 2, 202, 20203, 'EDWDAS', 0, 1, '2023-01-11 20:38:49', '2023-07-03 13:58:03'),
(3, NULL, 5, 1, '71132586', 'JAVIER FERNANDO ANGULO OSORIO', '2023-01-12', '121321344', '44444', 'PRUEBAS@GMAIL.COM', 4, 401, 40101, 'DIRECCION PRUEBA 123', 0, 1, '2023-01-12 22:01:37', '2023-07-03 13:58:21'),
(4, NULL, 2, 1, '72613790', 'ALEXANDER ACUÑA RAMIREZ', '2023-01-13', '999999999', '999999999', 'ACUNARAMIREZALEXANDER487@GMAIL.COM', 4, 401, 40101, '999999999', 1, 1, '2023-01-13 18:10:36', '2024-02-20 17:02:14'),
(5, NULL, 2, 1, '72613791', 'YANNY MIRELIA HUMPIRI YUCRA', '1986-05-07', '929399399', '999999999', 'correo@gmail.com', 4, 401, 40101, '-', NULL, 1, '2023-01-25 21:01:55', '2023-01-25 21:01:55'),
(6, NULL, NULL, 1, '74357798', 'ERIKA PAOLA MACHACA RAMOS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2023-02-14 20:54:55', '2023-02-14 20:54:55'),
(7, NULL, 2, 1, '70016022', 'RAUL EDUARDO MIRANDA RIOS', '2023-03-06', '988459485', '932493234', 'raul.miranda@gmail.com', 13, 1301, 130101, 'av. Miranda 123', NULL, 1, '2023-03-06 16:43:16', '2023-03-06 16:43:16'),
(8, NULL, 2, 1, '41231312', 'JUANA BELU SANCHEZ MACHUCA', '1964-02-11', '993483748', '923493249', 'juana_sanchez@gmail.com', 4, 401, 40101, 'calle benavides alarcon 123', NULL, 1, '2023-03-06 16:58:59', '2023-03-06 16:58:59'),
(9, NULL, 2, 1, '44354326', 'CATHERINE CELIA CHANG BARBOZA', '2018-08-15', '998493859', '990943504', 'catherine@gmail.com', 4, 401, 40101, 'Santa Elena 277', NULL, 1, '2023-03-06 17:59:02', '2023-03-06 17:59:02'),
(10, NULL, 2, 1, '77893921', 'CAMILA ROUSSE AMARO SEGURA', NULL, '990898938', '998888323', 'camila_amaro@gmail.com', 4, 401, 40101, 'av marina 321', NULL, 1, '2023-03-06 18:23:23', '2023-03-06 18:23:23'),
(11, NULL, 3, 1, '43428748', 'ELIZABET TUCTO HUAMAN', NULL, '993012930', '919283921', 'eli_huaman@gmail.com', 4, 401, 40101, 'av marina 321', NULL, 1, '2023-03-06 18:31:57', '2023-03-06 18:31:57'),
(12, NULL, 1, 1, '70545041', 'PAOLO FALCÓN ESCALANTE', '1998-11-28', '123456789', NULL, 'PAOFAB_98@OUTLOOK.COM', 4, 401, 40101, 'URB. GONZÁLES III', 0, 1, '2023-06-28 14:47:54', '2023-06-28 15:23:25');

-- --------------------------------------------------------

--
-- Table structure for table `clinicas`
--

CREATE TABLE `clinicas` (
  `id_clinica` int UNSIGNED NOT NULL,
  `nombre_clinica` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono_clinica` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_clinica` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enviar_correos` int DEFAULT '1' COMMENT '1=SI, 0=NO',
  `afiliacion` tinyint NOT NULL DEFAULT '0',
  `descuento` int UNSIGNED DEFAULT '10',
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clinicas`
--

INSERT INTO `clinicas` (`id_clinica`, `nombre_clinica`, `telefono_clinica`, `email_clinica`, `enviar_correos`, `afiliacion`, `descuento`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'VARIOS', '000000000', '-', 0, 0, 0, 1, NULL, '2023-10-12 04:40:21');

-- --------------------------------------------------------

--
-- Table structure for table `clinicas_sucursales`
--

CREATE TABLE `clinicas_sucursales` (
  `id_clini_suc` int UNSIGNED NOT NULL,
  `id_clinica` int UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `compras`
--

CREATE TABLE `compras` (
  `id_compra` bigint UNSIGNED NOT NULL,
  `user_id_update` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `id_proveedor` int UNSIGNED DEFAULT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `id_origen_dinero` int UNSIGNED DEFAULT NULL,
  `id_medio_pago` int UNSIGNED NOT NULL,
  `nombre_proveedor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_documento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guia_factura` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_serie` int UNSIGNED NOT NULL,
  `correlativo` bigint NOT NULL,
  `fecha` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(11,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(11,2) NOT NULL DEFAULT '0.00',
  `igv` decimal(11,2) NOT NULL DEFAULT '0.00',
  `referencia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '-',
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion_pago` tinyint NOT NULL COMMENT '1=Al Contado\r\n2=Al Crédito\r\n3=Al Crédito con Cuotas',
  `deuda_tipo` enum('total','saldo','cuotas') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'total',
  `deuda_total_abonado` decimal(11,2) NOT NULL DEFAULT '0.00',
  `deuda_saldo` decimal(11,2) NOT NULL DEFAULT '0.00',
  `fecha_vencimiento` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `direccion_proveedor` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `compras_detalle`
--

CREATE TABLE `compras_detalle` (
  `id_compra_detalle` bigint UNSIGNED NOT NULL,
  `id_compra` bigint UNSIGNED NOT NULL,
  `codigo_producto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_producto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unidad_medida` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad` decimal(11,2) NOT NULL DEFAULT '0.00',
  `precio_compra` decimal(11,2) NOT NULL DEFAULT '0.00',
  `precio_total` decimal(11,2) NOT NULL DEFAULT '0.00',
  `precio_sin_igv` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comprobantes`
--

CREATE TABLE `comprobantes` (
  `id_comprobante` int UNSIGNED NOT NULL,
  `id_cliente` int UNSIGNED DEFAULT NULL,
  `id_tipo_comprobante` int UNSIGNED DEFAULT NULL,
  `id_tipo_documento` int UNSIGNED DEFAULT NULL,
  `id_usuario` bigint UNSIGNED DEFAULT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `id_estado_comprobante` tinyint UNSIGNED DEFAULT '4',
  `id_medio_pago` int UNSIGNED DEFAULT NULL,
  `id_serie` int UNSIGNED DEFAULT NULL,
  `correlativo` int DEFAULT NULL,
  `nombre_cliente` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion_cliente` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_emision` timestamp NULL DEFAULT NULL,
  `factura_gratuita` tinyint(1) NOT NULL DEFAULT '0',
  `nro_operacion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `porcentaje_igv` decimal(3,2) DEFAULT NULL,
  `igv` decimal(11,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(11,2) NOT NULL DEFAULT '0.00',
  `total` decimal(11,2) NOT NULL DEFAULT '0.00',
  `condicion_pago` tinyint DEFAULT '0',
  `adelanto` decimal(11,2) NOT NULL DEFAULT '0.00',
  `saldo` decimal(11,2) NOT NULL DEFAULT '0.00',
  `dscto_porcentaje` decimal(11,2) NOT NULL DEFAULT '0.00',
  `dscto_fijo` decimal(11,2) NOT NULL DEFAULT '0.00',
  `comentario` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `formato_impresion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_anulacion` date DEFAULT NULL,
  `motivo_anulacion` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_caja` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_orden_lab` int UNSIGNED DEFAULT NULL,
  `id_eps_discount` int UNSIGNED DEFAULT NULL,
  `eps_discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fecha_vencimiento` date NOT NULL,
  `total_abonado` decimal(10,2) NOT NULL DEFAULT '0.00',
  `id_comprobante_eps` int UNSIGNED DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `nota_credito_referencia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comprobantes`
--

INSERT INTO `comprobantes` (`id_comprobante`, `id_cliente`, `id_tipo_comprobante`, `id_tipo_documento`, `id_usuario`, `id_sucursal`, `id_estado_comprobante`, `id_medio_pago`, `id_serie`, `correlativo`, `nombre_cliente`, `nro_documento`, `direccion_cliente`, `fecha_emision`, `factura_gratuita`, `nro_operacion`, `porcentaje_igv`, `igv`, `subtotal`, `total`, `condicion_pago`, `adelanto`, `saldo`, `dscto_porcentaje`, `dscto_fijo`, `comentario`, `external_id`, `formato_impresion`, `fecha_anulacion`, `motivo_anulacion`, `id_caja`, `created_at`, `updated_at`, `id_orden_lab`, `id_eps_discount`, `eps_discount`, `fecha_vencimiento`, `total_abonado`, `id_comprobante_eps`, `observaciones`, `nota_credito_referencia`) VALUES
(1, 4, 2, 1, 2, 2, 4, 1, 2, 42, 'ALEXANDER ACUÑA RAMIREZ', '72613790', '999999999', '2024-02-23 05:00:00', 0, '90809', NULL, '183.36', '1018.64', '1202.00', 1, '0.00', '0.00', '0.00', '0.00', '', 'c30981ab-8ffe-41f8-8997-fb0190066347', NULL, NULL, NULL, 1, '2024-02-23 16:59:41', '2024-02-23 16:59:50', 1, NULL, '0.00', '2024-02-23', '0.00', NULL, NULL, NULL),
(3, 4, 2, 1, 2, 2, 4, 2, 2, 44, 'ALEXANDER ACUÑA RAMIREZ', '72613790', '999999999', '2024-02-26 05:00:00', 0, NULL, NULL, '183.36', '1018.64', '1202.00', 1, '0.00', '0.00', '0.00', '0.00', '', 'fa475240-8360-467d-a2f6-0104ac99d966', NULL, NULL, NULL, 2, '2024-02-26 15:42:47', '2024-02-26 15:42:55', 2, NULL, '0.00', '2024-02-26', '0.00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comprobantes_detalles`
--

CREATE TABLE `comprobantes_detalles` (
  `id_comprobante_detalle` int UNSIGNED NOT NULL,
  `id_comprobante` int UNSIGNED DEFAULT NULL,
  `item_type` tinyint DEFAULT NULL,
  `id_unidad_medida` int UNSIGNED DEFAULT NULL,
  `detalle_item` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad` decimal(11,2) DEFAULT NULL,
  `precio_unitario` decimal(11,2) NOT NULL DEFAULT '0.00',
  `precio_total` decimal(11,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_precio_lente` int UNSIGNED DEFAULT NULL,
  `id_servicio` int UNSIGNED DEFAULT NULL,
  `id_producto` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comprobantes_detalles`
--

INSERT INTO `comprobantes_detalles` (`id_comprobante_detalle`, `id_comprobante`, `item_type`, `id_unidad_medida`, `detalle_item`, `cantidad`, `precio_unitario`, `precio_total`, `created_at`, `updated_at`, `id_precio_lente`, `id_servicio`, `id_producto`) VALUES
(1, 1, 1, 1, 'GUCCI A001-02GUC24', '1.00', '887.00', '887.00', '2024-02-23 16:59:41', '2024-02-23 16:59:41', NULL, NULL, 1),
(2, 1, 2, 2, 'BIFOCAL DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87', '1.00', '315.00', '315.00', '2024-02-23 16:59:41', '2024-02-23 16:59:41', 512, NULL, NULL),
(5, 3, 1, 1, 'GUCCI A001-02GUC24', '1.00', '887.00', '887.00', '2024-02-26 15:42:47', '2024-02-26 15:42:47', NULL, NULL, 1),
(6, 3, 2, 2, 'BIFOCAL DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87', '1.00', '315.00', '315.00', '2024-02-26 15:42:47', '2024-02-26 15:42:47', 512, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comprobantes_deudas`
--

CREATE TABLE `comprobantes_deudas` (
  `id` int UNSIGNED NOT NULL,
  `monto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fecha` date NOT NULL,
  `id_comprobante` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comprobantes_estados`
--

CREATE TABLE `comprobantes_estados` (
  `id_estado_comprobante` tinyint UNSIGNED NOT NULL,
  `nombre_estado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#FFF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comprobantes_estados`
--

INSERT INTO `comprobantes_estados` (`id_estado_comprobante`, `nombre_estado`, `color`) VALUES
(1, 'APROBADO', 'success'),
(2, 'ANULADO', 'accent'),
(3, 'RECHAZADO', 'warning'),
(4, 'REGISTRADO', 'info'),
(5, 'POR ANULAR', 'error'),
(6, 'ENVIADO', 'success'),
(7, 'OBSERVADO', 'warning');

-- --------------------------------------------------------

--
-- Table structure for table `comprobantes_pagos`
--

CREATE TABLE `comprobantes_pagos` (
  `id` int UNSIGNED NOT NULL,
  `monto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `saldo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fecha` date NOT NULL,
  `id_comprobante` int UNSIGNED NOT NULL,
  `id_caja` int UNSIGNED NOT NULL,
  `id_metodo_pago` int UNSIGNED NOT NULL,
  `observacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `id_user` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comprobantes_series`
--

CREATE TABLE `comprobantes_series` (
  `id_serie` int UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `id_tipo_comprobante` int UNSIGNED DEFAULT NULL,
  `serie` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comprobantes_series`
--

INSERT INTO `comprobantes_series` (`id_serie`, `id_sucursal`, `id_tipo_comprobante`, `serie`, `estado`) VALUES
(1, 2, 1, 'F001', 1),
(2, 2, 2, 'B001', 1),
(3, 2, 3, 'NP001', 1),
(4, 2, 4, 'CT01', 1),
(5, 2, 8, 'GC01', 1),
(6, 2, 8, 'GC02', 1),
(7, 4, 8, 'YC01', 1),
(8, 5, 8, 'IC01', 1),
(9, 5, 8, 'IC02', 1),
(10, 4, 8, 'YC02', 1),
(11, 2, 5, 'P2KK', 0),
(12, 2, 5, 'GR01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `conformidad_montura`
--

CREATE TABLE `conformidad_montura` (
  `id` int UNSIGNED NOT NULL,
  `id_anamnesis` int UNSIGNED NOT NULL,
  `p1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p1_respuesta` json DEFAULT NULL,
  `p2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p2_respuesta` json DEFAULT NULL,
  `p3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p3_respuesta` json DEFAULT NULL,
  `p4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p4_respuesta` json DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id_cotizacion` bigint UNSIGNED NOT NULL,
  `id_serie` int UNSIGNED NOT NULL,
  `id_anamnesis` int UNSIGNED DEFAULT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `correlativo` bigint UNSIGNED NOT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_cliente` int UNSIGNED DEFAULT NULL,
  `receta` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cotizaciones`
--

INSERT INTO `cotizaciones` (`id_cotizacion`, `id_serie`, `id_anamnesis`, `id_sucursal`, `correlativo`, `estado`, `created_at`, `updated_at`, `id_cliente`, `receta`) VALUES
(1, 4, 3, 0, 1, 1, '2024-02-26 15:57:26', '2024-02-26 15:57:26', 4, '{\"od\": {\"alt\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"avcc\": \"1\", \"prismas\": \"1\", \"add_cerca\": \"1\", \"add_intermedio\": \"1\"}, \"oi\": {\"alt\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"avcc\": \"1\", \"prismas\": \"1\", \"add_cerca\": \"1\", \"add_intermedio\": \"1\"}, \"dip\": \"1\", \"far\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"near\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"bifocal\": {\"od\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"panoramic_angle\": null, \"vertex_distance\": null, \"pantoscopic_angle\": null}, \"contact\": {\"od\": {\"cb\": \"1\", \"k1\": \"1\", \"k2\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"sag\": \"1\", \"dhiv\": \"1\", \"diametro\": \"1\"}, \"oi\": {\"cb\": \"1\", \"k1\": \"1\", \"k2\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"sag\": \"1\", \"dhiv\": \"1\", \"diametro\": \"1\"}, \"color\": \"1\", \"geometry\": \"1\", \"material\": \"1\", \"replacement\": \"1\"}, \"selection\": \"contact\", \"multifocal\": {\"od\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"intermediate\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"panoramic_angle\": \"1\", \"vertex_distance\": \"1\", \"pantoscopic_angle\": \"1\"}');

-- --------------------------------------------------------

--
-- Table structure for table `cotizaciones_detalle`
--

CREATE TABLE `cotizaciones_detalle` (
  `id_cotizacion_detalle` bigint UNSIGNED NOT NULL,
  `id_cotizacion` bigint UNSIGNED NOT NULL,
  `id_precio_lente` int UNSIGNED NOT NULL,
  `id_producto` int UNSIGNED NOT NULL,
  `montaje` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `montura` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cotizaciones_detalle`
--

INSERT INTO `cotizaciones_detalle` (`id_cotizacion_detalle`, `id_cotizacion`, `id_precio_lente`, `id_producto`, `montaje`, `montura`) VALUES
(1, 1, 512, 1, 'REDUCCIÓN DE DIAMETRO', 'AL AIRE'),
(2, 1, 153, 1, 'REDUCCIÓN DE DIAMETRO', 'SEMI AL AIRE');

-- --------------------------------------------------------

--
-- Table structure for table `cupones`
--

CREATE TABLE `cupones` (
  `id` bigint UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `codigo_cupon` varchar(255) DEFAULT NULL,
  `tipo_descuento` tinyint UNSIGNED DEFAULT NULL COMMENT '1=S/.\r\n2=%',
  `descuento` decimal(10,0) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `active` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_comprobante_origen` int UNSIGNED DEFAULT NULL,
  `id_comprobante_uso` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cupones`
--

INSERT INTO `cupones` (`id`, `id_usuario`, `id_sucursal`, `codigo_cupon`, `tipo_descuento`, `descuento`, `fecha_vencimiento`, `status`, `active`, `created_at`, `updated_at`, `id_comprobante_origen`, `id_comprobante_uso`) VALUES
(1, 2, 2, 'ABYX4R8E', 2, '20', '2025-02-23', 1, 1, '2024-02-23 16:59:41', '2024-02-23 11:59:41', 1, NULL),
(3, 2, 2, 'OP2R99KN', 2, '20', '2025-02-26', 1, 1, '2024-02-26 15:42:47', '2024-02-26 10:42:47', 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deuda_compra_cuotas`
--

CREATE TABLE `deuda_compra_cuotas` (
  `id_cuota` bigint UNSIGNED NOT NULL,
  `id_compra` bigint UNSIGNED NOT NULL,
  `fecha` date DEFAULT NULL,
  `monto` float(11,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deuda_compra_pagos`
--

CREATE TABLE `deuda_compra_pagos` (
  `id_pago_deuda` int UNSIGNED NOT NULL,
  `id_compra` bigint UNSIGNED NOT NULL,
  `monto_abonado` decimal(11,2) NOT NULL DEFAULT '0.00',
  `saldo` decimal(11,2) NOT NULL DEFAULT '0.00',
  `fecha` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banco` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_operacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_origen_dinero` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctores`
--

CREATE TABLE `doctores` (
  `id_doctor` int UNSIGNED NOT NULL,
  `nombres` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellidos` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_documento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_telefono` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '00000000',
  `fecha_nacimiento` date DEFAULT NULL,
  `enviar_correos` tinyint DEFAULT NULL COMMENT '1=SI, 0=NO',
  `convenio` tinyint DEFAULT NULL COMMENT '1=AFILIADO, 0 NO AFILIADO',
  `porcentaje_comision` decimal(5,2) NOT NULL DEFAULT '0.00',
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doctores`
--

INSERT INTO `doctores` (`id_doctor`, `nombres`, `apellidos`, `email`, `nro_documento`, `nro_telefono`, `fecha_nacimiento`, `enviar_correos`, `convenio`, `porcentaje_comision`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'VARIOS', NULL, '-', '00000000', '000000000', '2000-01-01', 0, 0, '0.00', 1, '2000-01-01 05:00:00', '2023-07-03 13:51:32');

-- --------------------------------------------------------

--
-- Table structure for table `doctores_sucursales`
--

CREATE TABLE `doctores_sucursales` (
  `id_empresa_sucursal` int UNSIGNED NOT NULL,
  `id_doctor` int UNSIGNED DEFAULT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `egresos`
--

CREATE TABLE `egresos` (
  `id_egreso` bigint UNSIGNED NOT NULL,
  `id_caja` int UNSIGNED DEFAULT NULL,
  `id_compra` bigint UNSIGNED DEFAULT NULL,
  `descripcion` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monto` decimal(11,2) DEFAULT NULL,
  `origen` tinyint NOT NULL DEFAULT '1',
  `fecha_egreso` date DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_medio_pago` int UNSIGNED DEFAULT NULL,
  `id_proveedor` int UNSIGNED DEFAULT NULL,
  `observaciones` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_user` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `empresas_convenio`
--

CREATE TABLE `empresas_convenio` (
  `id_empresa_convenio` int UNSIGNED NOT NULL,
  `nombre_empresa` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion_empresa` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ruc_empresa` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono_empresa` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_empresa` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enviar_correos` tinyint DEFAULT '1' COMMENT 'Empresa desea recibir correos informativos? 1=SI, 0=NO',
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cobertura` tinyint NOT NULL DEFAULT '0' COMMENT '0 => NO ALERTAR COBERTURA; 1=> ALERTAR COBERTURA',
  `descuento_cobertura` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `empresas_convenio`
--

INSERT INTO `empresas_convenio` (`id_empresa_convenio`, `nombre_empresa`, `direccion_empresa`, `ruc_empresa`, `telefono_empresa`, `email_empresa`, `enviar_correos`, `estado`, `created_at`, `updated_at`, `cobertura`, `descuento_cobertura`) VALUES
(1, 'VARIOS', '-', '00000000000', '000000000', '-', 0, 1, '2000-10-02 04:43:19', '2023-07-03 13:52:54', 0, '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `encuestas_satisfaccion`
--

CREATE TABLE `encuestas_satisfaccion` (
  `id_encuesta` int UNSIGNED NOT NULL,
  `id_cliente` int UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `id_comprobante` int UNSIGNED NOT NULL,
  `id_anamnesis` int UNSIGNED NOT NULL,
  `id_user` bigint UNSIGNED NOT NULL,
  `nivel_satisfaccion` tinyint UNSIGNED NOT NULL,
  `estado` tinyint UNSIGNED DEFAULT '1',
  `sugerencias` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `encuesta_etapas`
--

CREATE TABLE `encuesta_etapas` (
  `id_etapa_encuesta` int UNSIGNED NOT NULL,
  `parte` int UNSIGNED NOT NULL,
  `etapa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `encuesta_etapas`
--

INSERT INTO `encuesta_etapas` (`id_etapa_encuesta`, `parte`, `etapa`) VALUES
(1, 1, 'ETAPA DE ATENCIÓN'),
(2, 1, 'ETAPA DE COTIZACIÓN'),
(3, 1, 'ETAPA DE FIDELIZACIÓN'),
(4, 2, 'ETAPA DE SATISFACCIÓN'),
(5, 2, 'ETAPA DE SATISFACCIÓN GENERAL');

-- --------------------------------------------------------

--
-- Table structure for table `encuesta_preguntas`
--

CREATE TABLE `encuesta_preguntas` (
  `id_encuesta_pregunta` int UNSIGNED NOT NULL,
  `pregunta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_etapa_encuesta` int UNSIGNED NOT NULL,
  `alternativas` int UNSIGNED NOT NULL DEFAULT '2',
  `estado` tinyint UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `encuesta_preguntas`
--

INSERT INTO `encuesta_preguntas` (`id_encuesta_pregunta`, `pregunta`, `id_etapa_encuesta`, `alternativas`, `estado`) VALUES
(1, '¿El ambiente estaba limpio y despejado?', 1, 2, 1),
(2, '¿El personal se presento dando su nombre?', 2, 2, 1),
(3, '¿Se le hablo sobre los descuentos corporativos y se uso la lista de precios como una herramienta de ventas?', 2, 2, 1),
(4, '¿Se le explicó las garantías del centro óptico?', 2, 2, 1),
(5, '¿Se le explicó las características, ventajas y beneficios de cada uno de los productos?', 2, 2, 1),
(6, '¿Se le explicaron las características de las monturas? (Recomendación de acuerdo al tipo de rostro)', 3, 3, 1),
(7, '¿El personal se desinfectó las manos antes de entrar en contacto con Ud.?', 3, 2, 1),
(8, '¿Se le tomó el centro focal y la altura de los lentes?', 3, 2, 1),
(9, '¿Se le dió la bienvenida?', 4, 2, 1),
(10, '¿Se le utilizó el test de lectura?', 4, 3, 1),
(11, '¿Se le explicó las garantías del centro óptico?', 4, 2, 1),
(12, '¿Se le explicó sobre el cuidado del material adquirido?', 4, 2, 1),
(13, '¿Quedó satisfecho con la atención recibida?', 4, 2, 1),
(14, '¿Se utilizaron herramientas visuales? Ej. Realidad Virtual, Tipos de lentes, Linterna UV, etc.', 4, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `encuesta_respuestas`
--

CREATE TABLE `encuesta_respuestas` (
  `id_encuesta_respuesta` int UNSIGNED NOT NULL,
  `id_encuesta` int UNSIGNED NOT NULL,
  `id_encuesta_pregunta` int UNSIGNED NOT NULL,
  `respuesta` int UNSIGNED NOT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eps`
--

CREATE TABLE `eps` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `ruc` char(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `eps`
--

INSERT INTO `eps` (`id`, `name`, `ruc`, `created_at`, `updated_at`, `status`) VALUES
(1, 'RIMAC SEGUROS', '12345678901', '2023-09-29 15:43:19', '2023-09-29 15:43:19', 1),
(2, 'PACIFICO SEGUROS', '98765432109', '2023-09-29 15:43:19', '2023-09-29 15:43:19', 1);

-- --------------------------------------------------------

--
-- Table structure for table `eps_descuentos`
--

CREATE TABLE `eps_descuentos` (
  `id` int UNSIGNED NOT NULL,
  `eps_id` int UNSIGNED NOT NULL,
  `detail` varchar(255) NOT NULL,
  `discount_type` enum('AMOUNT','PERCENTAGE') NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `eps_descuentos`
--

INSERT INTO `eps_descuentos` (`id`, `eps_id`, `detail`, `discount_type`, `discount`, `created_at`, `updated_at`, `status`) VALUES
(1, 1, 'S./10.50', 'AMOUNT', '10.50', '2023-09-29 15:43:19', '2023-09-29 15:43:19', 1),
(2, 2, 'S./5.75', 'AMOUNT', '5.75', '2023-09-29 15:43:19', '2023-09-29 15:43:19', 1),
(3, 1, '15%', 'PERCENTAGE', '15.00', '2023-09-29 15:43:19', '2023-09-29 15:43:19', 1);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guia_remision`
--

CREATE TABLE `guia_remision` (
  `id_guia_remision` int UNSIGNED NOT NULL,
  `id_serie` int UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `id_cliente` int UNSIGNED NOT NULL,
  `id_motivo_traslado` int UNSIGNED NOT NULL,
  `id_unidad_medida` int UNSIGNED NOT NULL,
  `id_departamento_partida` int UNSIGNED NOT NULL,
  `id_provincia_partida` int UNSIGNED NOT NULL,
  `id_distrito_partida` int UNSIGNED NOT NULL,
  `id_departamento_llegada` int UNSIGNED NOT NULL,
  `id_provincia_llegada` int UNSIGNED NOT NULL,
  `id_distrito_llegada` int UNSIGNED NOT NULL,
  `fecha_emision` date NOT NULL,
  `fecha_traslado` date NOT NULL,
  `modo_traslado` tinyint(1) NOT NULL,
  `descripcion_motivo_traslado` varchar(255) DEFAULT NULL,
  `peso_total` float(6,2) NOT NULL,
  `cantidad` int DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `direccion_partida` varchar(150) DEFAULT NULL,
  `direccion_llegada` varchar(150) DEFAULT NULL,
  `dni_conductor` varchar(25) NOT NULL,
  `nombre_conductor` varchar(255) NOT NULL,
  `licencia_conductor` varchar(80) DEFAULT NULL,
  `telefono_conductor` varchar(15) DEFAULT NULL,
  `placa_vehiculo` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medio_pago`
--

CREATE TABLE `medio_pago` (
  `id_medio_pago` int UNSIGNED NOT NULL,
  `medio_pago` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medio_pago`
--

INSERT INTO `medio_pago` (`id_medio_pago`, `medio_pago`) VALUES
(1, 'EFECTIVO'),
(2, 'TARJETA'),
(3, 'YAPE'),
(4, 'DEPOSITO'),
(5, 'NOTA DE CRÉDITO');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2022_08_09_000000_create_sucursales_table', 1),
(3, '2022_08_09_000001_create_ocupaciones_table', 1),
(4, '2022_08_09_000002_create_afectacion_igv_table', 1),
(5, '2022_08_09_000003_create_productos_marcas_table', 1),
(6, '2022_08_09_000004_create_productos_material_table', 1),
(7, '2022_08_09_000005_create_rubros_trabajo_table', 1),
(8, '2022_08_09_000006_create_productos_tipo_aro_table', 1),
(9, '2022_08_09_000007_create_tipos_documentos_table', 1),
(10, '2022_08_09_000008_create_clinicas_table', 1),
(11, '2022_08_09_000009_create_productos_forma_montura_table', 1),
(12, '2022_08_09_000010_create_empresas_convenio_table', 1),
(13, '2022_08_09_000011_create_productos_categorias_table', 1),
(14, '2022_08_09_000012_create_productos_table', 1),
(15, '2022_08_09_000013_create_precios_lentes_table', 1),
(16, '2022_08_09_000016_create_servicios_table', 2),
(17, '2022_08_09_000017_create_empresas_convenio_sucursales_table', 2),
(18, '2022_08_09_000018_create_clinicas_sucursales_table', 2),
(19, '2022_08_09_000019_create_users_table', 2),
(20, '2022_08_09_000020_create_password_resets_table', 2),
(21, '2022_08_09_000021_create_failed_jobs_table', 2),
(22, '2022_08_09_000023_create_permission_tables', 2),
(23, '2022_08_22_131348_create_caja_table', 2),
(24, '2022_08_22_131459_create_caja_turnos_table', 2),
(25, '2022_08_22_131626_create_medio_pago_table', 2),
(26, '2022_08_22_132015_create_almacen_movimientos_tipos_table', 2),
(27, '2022_08_22_132144_create_doctores_tipos_table', 2),
(28, '2022_08_22_132232_create_ubigeo_departamentos_table', 2),
(29, '2022_08_22_132336_create_origen_dinero_table', 2),
(30, '2022_08_22_132602_create_doctores_sucursales_table', 2),
(31, '2022_09_08_000414_create_ubigeo_provincias_table', 2),
(32, '2022_09_08_002800_create_ubigeo_distritos_table', 2),
(33, '2022_10_05_125301_create_compras_table', 3),
(34, '2022_10_05_144134_create_compras_detalle_table', 4),
(35, '2022_10_05_144201_create_pago_deuda_table', 5),
(36, '2022_10_09_000014_create_clientes_table', 6),
(37, '2023_01_11_173850_add_fields_to_sucursales_table', 7),
(63, '2023_01_17_162611_create_cotizaciones_table', 8),
(64, '2023_01_17_162740_create_cotizaciones_detalle_table', 9),
(65, '2023_01_25_141120_create_unidades_medida_table', 10),
(66, '2023_01_25_152310_add_fields_to_comprobante_detalle_table', 11),
(67, '2023_01_25_161034_add_fields_to_comprobante_table', 12);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `motivo_traslado`
--

CREATE TABLE `motivo_traslado` (
  `id_motivo_traslado` int UNSIGNED NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `motivo_traslado`
--

INSERT INTO `motivo_traslado` (`id_motivo_traslado`, `descripcion`) VALUES
(1, 'Venta'),
(2, 'Compra'),
(3, 'Venta con entrega a terceros'),
(4, 'Traslado entre establecimientos de la misma empresa'),
(5, 'Consignación'),
(6, 'Devolución'),
(7, 'Recojo de bienes transformados'),
(8, 'Importación'),
(9, 'Exportación'),
(13, 'Otros no comprendidos en ningún código del presente catálogo'),
(14, 'Venta sujeta a confirmación del comprador'),
(17, 'Traslado de bienes para transformación'),
(18, 'Traslado por emisor itinerante de comprobantes de pago');

-- --------------------------------------------------------

--
-- Table structure for table `notas`
--

CREATE TABLE `notas` (
  `id_nota` int UNSIGNED NOT NULL,
  `id_serie` int UNSIGNED NOT NULL,
  `id_comprobante` int UNSIGNED NOT NULL,
  `id_tipo_nota` int UNSIGNED NOT NULL,
  `id_cliente` int UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `external_id` varchar(70) DEFAULT NULL,
  `id_estado_comprobante` tinyint UNSIGNED NOT NULL,
  `id_tipo_comprobantes` int UNSIGNED NOT NULL COMMENT '6 => NOTA CRÉDITO, 7=> NOTA DEBÍTO',
  `correlativo` int NOT NULL,
  `fecha_emision` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `descripcion` varchar(255) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `subtotal` decimal(11,2) NOT NULL,
  `igv` decimal(11,2) NOT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `nota_detalle`
--

CREATE TABLE `nota_detalle` (
  `id_nota_detalle` int UNSIGNED NOT NULL,
  `id_nota` int UNSIGNED NOT NULL,
  `id_precio_lente` int UNSIGNED DEFAULT NULL,
  `id_servicio` int UNSIGNED DEFAULT NULL,
  `id_producto` int UNSIGNED DEFAULT NULL,
  `item_type` tinyint DEFAULT NULL COMMENT '1 => Producto, 2 => Precio Lentes, 3 => Servicios',
  `id_unidad_medida` int UNSIGNED NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `cantidad` decimal(11,2) NOT NULL,
  `precio_unitario` decimal(11,2) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `ocupaciones`
--

CREATE TABLE `ocupaciones` (
  `id_ocupacion` int UNSIGNED NOT NULL,
  `nombre_ocupacion` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ocupaciones`
--

INSERT INTO `ocupaciones` (`id_ocupacion`, `nombre_ocupacion`, `estado`) VALUES
(1, 'INGENIERO', 1),
(2, 'PROFESOR', 1),
(3, 'ARQUITECTO', 1),
(4, 'OFICINISTA', 1),
(5, 'ELECTRICISTA', 1),
(6, 'AGRICULTOR', 1),
(7, 'SOLDADOR', 1),
(8, 'ALBAÑIL', 1),
(9, 'CARPINTERO', 1),
(10, 'OPERADOR DE MAQUINARIA PESADA', 1),
(11, 'ABOGADO', 1),
(12, 'MÉDICO', 1),
(13, 'PROFESOR', 1),
(14, 'MECÁNICO', 1),
(15, 'OTROS', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orden_laboratorio`
--

CREATE TABLE `orden_laboratorio` (
  `id_orden_laboratorio` int UNSIGNED NOT NULL,
  `id_montura` int UNSIGNED DEFAULT NULL,
  `id_cliente` int UNSIGNED DEFAULT NULL,
  `id_precio_lentes` int UNSIGNED DEFAULT NULL,
  `id_anamnesis` int UNSIGNED DEFAULT NULL,
  `id_estado_orden_laboratorio` int UNSIGNED DEFAULT '1',
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `montura_cliente` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_montura` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `montaje` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_entrega` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_entrega` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monto_compra_proyectado` decimal(11,2) DEFAULT '0.00',
  `monto_compra_detallado` decimal(11,2) DEFAULT '0.00',
  `estado` tinyint NOT NULL DEFAULT '1',
  `id_sucursal` int UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `receta` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orden_laboratorio`
--

INSERT INTO `orden_laboratorio` (`id_orden_laboratorio`, `id_montura`, `id_cliente`, `id_precio_lentes`, `id_anamnesis`, `id_estado_orden_laboratorio`, `observaciones`, `montura_cliente`, `tipo_montura`, `montaje`, `fecha_entrega`, `hora_entrega`, `monto_compra_proyectado`, `monto_compra_detallado`, `estado`, `id_sucursal`, `id_usuario`, `created_at`, `updated_at`, `receta`) VALUES
(1, 1, 4, 512, 1, 1, '', NULL, 'ARO COMPLETO', 'BISELL BRILLANTE', '2024-02-23', '03:14', '180.00', '180.00', 1, 2, 2, '2024-02-23 16:59:22', '2024-02-23 16:59:22', '{\"od\": {\"alt\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"avcc\": \"1\", \"prismas\": \"1\", \"add_cerca\": \"1\", \"add_intermedio\": \"1\"}, \"oi\": {\"alt\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"avcc\": \"1\", \"prismas\": \"1\", \"add_cerca\": \"1\", \"add_intermedio\": \"1\"}, \"dip\": \"1\", \"far\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"near\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"bifocal\": {\"od\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"panoramic_angle\": null, \"vertex_distance\": null, \"pantoscopic_angle\": null}, \"contact\": {\"od\": {\"cb\": null, \"k1\": null, \"k2\": null, \"cyl\": null, \"eje\": null, \"esf\": null, \"sag\": null, \"dhiv\": null, \"diametro\": null}, \"oi\": {\"cb\": null, \"k1\": null, \"k2\": null, \"cyl\": null, \"eje\": null, \"esf\": null, \"sag\": null, \"dhiv\": null, \"diametro\": null}, \"color\": null, \"geometry\": null, \"material\": null, \"replacement\": null}, \"selection\": \"far\", \"multifocal\": {\"od\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"intermediate\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"panoramic_angle\": \"1\", \"vertex_distance\": \"1\", \"pantoscopic_angle\": \"1\"}'),
(2, 1, 4, 512, 2, 1, '', NULL, 'ARO COMPLETO', 'BISELL BRILLANTE', '2024-02-23', '10:45', '180.00', '180.00', 1, 2, 2, '2024-02-23 17:12:33', '2024-02-23 17:12:33', '{\"od\": {\"alt\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"avcc\": \"1\", \"prismas\": \"1\", \"add_cerca\": \"1\", \"add_intermedio\": \"1\"}, \"oi\": {\"alt\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"avcc\": \"1\", \"prismas\": \"1\", \"add_cerca\": \"1\", \"add_intermedio\": \"1\"}, \"dip\": \"1\", \"far\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"near\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"bifocal\": {\"od\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"panoramic_angle\": null, \"vertex_distance\": null, \"pantoscopic_angle\": null}, \"contact\": {\"od\": {\"cb\": null, \"k1\": null, \"k2\": null, \"cyl\": null, \"eje\": null, \"esf\": null, \"sag\": null, \"dhiv\": null, \"diametro\": null}, \"oi\": {\"cb\": null, \"k1\": null, \"k2\": null, \"cyl\": null, \"eje\": null, \"esf\": null, \"sag\": null, \"dhiv\": null, \"diametro\": null}, \"color\": null, \"geometry\": null, \"material\": null, \"replacement\": null}, \"selection\": \"far\", \"multifocal\": {\"od\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"intermediate\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"panoramic_angle\": \"1\", \"vertex_distance\": \"1\", \"pantoscopic_angle\": \"1\"}'),
(3, 1, 4, 153, 3, 1, '', NULL, 'SEMI AL AIRE', 'REDUCCIÓN DE DIAMETRO', '2024-02-26', '03:00', '160.00', '160.00', 1, 2, 2, '2024-02-26 18:28:25', '2024-02-26 18:28:25', '{\"od\": {\"alt\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"avcc\": \"1\", \"prismas\": \"1\", \"add_cerca\": \"1\", \"add_intermedio\": \"1\"}, \"oi\": {\"alt\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"avcc\": \"1\", \"prismas\": \"1\", \"add_cerca\": \"1\", \"add_intermedio\": \"1\"}, \"dip\": \"1\", \"far\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"near\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"bifocal\": {\"od\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"panoramic_angle\": null, \"vertex_distance\": null, \"pantoscopic_angle\": null}, \"contact\": {\"od\": {\"cb\": \"1\", \"k1\": \"1\", \"k2\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"sag\": \"1\", \"dhiv\": \"1\", \"diametro\": \"1\"}, \"oi\": {\"cb\": \"1\", \"k1\": \"1\", \"k2\": \"1\", \"cyl\": \"1\", \"eje\": \"1\", \"esf\": \"1\", \"sag\": \"1\", \"dhiv\": \"1\", \"diametro\": \"1\"}, \"color\": \"1\", \"geometry\": \"1\", \"material\": \"1\", \"replacement\": \"1\"}, \"selection\": \"contact\", \"multifocal\": {\"od\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"add\": null, \"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"intermediate\": {\"od\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}, \"oi\": {\"alt\": null, \"cyl\": null, \"dnp\": null, \"eje\": null, \"esf\": null, \"prismas\": null}}, \"panoramic_angle\": \"1\", \"vertex_distance\": \"1\", \"pantoscopic_angle\": \"1\"}');

-- --------------------------------------------------------

--
-- Table structure for table `orden_laboratorio_estados`
--

CREATE TABLE `orden_laboratorio_estados` (
  `id_estado_orden_laboratorio` int UNSIGNED NOT NULL,
  `nombre_estado` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#FFF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orden_laboratorio_estados`
--

INSERT INTO `orden_laboratorio_estados` (`id_estado_orden_laboratorio`, `nombre_estado`, `color`) VALUES
(1, 'ENVIADO LABORATORIO', 'info'),
(2, 'LISTO ENTREGA', 'warning'),
(3, 'ENTREGADO', 'success'),
(4, 'OBSERVADO', 'accent'),
(5, 'ANULADO', 'error'),
(6, 'CONTROL DE CALIDAD', 'info');

-- --------------------------------------------------------

--
-- Table structure for table `orden_laboratorio_historial_estados`
--

CREATE TABLE `orden_laboratorio_historial_estados` (
  `id` int UNSIGNED NOT NULL,
  `id_orden` int UNSIGNED NOT NULL,
  `id_estado` int UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orden_laboratorio_historial_estados`
--

INSERT INTO `orden_laboratorio_historial_estados` (`id`, `id_orden`, `id_estado`, `id_usuario`, `estado`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 1, '2024-02-23 16:59:22', '2024-02-23 16:59:22'),
(2, 2, 1, 2, 1, '2024-02-23 17:12:33', '2024-02-23 17:12:33'),
(3, 3, 1, 2, 1, '2024-02-26 18:28:25', '2024-02-26 18:28:25');

-- --------------------------------------------------------

--
-- Table structure for table `origen_dinero`
--

CREATE TABLE `origen_dinero` (
  `id_origen_dinero` int UNSIGNED NOT NULL,
  `nombre_origen` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion_origen` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `origen_dinero`
--

INSERT INTO `origen_dinero` (`id_origen_dinero`, `nombre_origen`, `descripcion_origen`, `id_sucursal`, `created_at`, `updated_at`) VALUES
(1, 'CAJA CHICA', 'caja chica', 2, NULL, NULL),
(2, 'CUENTA BANCARIA', 'cuenta bancaria', 2, NULL, NULL),
(3, 'CAJA FUERTE', 'caja fuerte', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `active` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `title`, `description`, `status`, `active`, `created_at`, `updated_at`) VALUES
(1, 'users_update', 'web', 'Actualizar usuarios', NULL, 1, 1, NULL, NULL),
(2, 'users_create', 'web', 'Crear Usuarios', NULL, 1, 1, NULL, NULL),
(3, 'users_read', 'web', 'Leer usuarios', NULL, 1, 1, NULL, NULL),
(4, 'users_destroy', 'web', 'Eliminar usuarios', NULL, 1, 1, NULL, NULL),
(5, 'roles_create', 'web', 'Crear roles', NULL, 1, 1, NULL, NULL),
(6, 'roles_read', 'web', 'Leer roles', NULL, 1, 1, NULL, NULL),
(7, 'roles_update', 'web', 'Actualizar roles', NULL, 1, 1, NULL, NULL),
(8, 'roles_destroy', 'web', 'Eliminar roles', NULL, 1, 1, NULL, NULL),
(9, 'permissions_create', 'web', 'Crear Permisos', NULL, 1, 1, NULL, NULL),
(10, 'permissions_read', 'web', 'Leer permisos', NULL, 1, 1, NULL, NULL),
(11, 'permissions_update', 'web', 'Actualizar permisos', NULL, 1, 1, NULL, NULL),
(12, 'permissions_destroy', 'web', 'Eliminar permisos', NULL, 1, 1, NULL, NULL),
(13, 'assign_permissions', 'web', 'Asignar permisos', NULL, 1, 1, NULL, NULL),
(14, 'cuentascobrar_create', 'web', 'Crear Cuentas Cobrar', NULL, 1, 1, '2023-08-11 13:12:59', '2023-08-11 13:12:59'),
(15, 'cuentascobrar_read', 'web', 'Leer Cuentas Cobrar', NULL, 1, 1, '2023-08-11 13:13:11', '2023-08-11 13:13:11'),
(16, 'cuentascobrar_update', 'web', 'Actualizar Cuentas Cobrar', NULL, 1, 1, '2023-08-11 13:13:28', '2023-08-11 13:13:28'),
(17, 'cuentascobrar_delete', 'web', 'Eliminar Cuentas Cobrar', NULL, 1, 1, '2023-08-11 13:13:51', '2023-08-11 13:13:51'),
(18, 'cuentaspagar_create', 'web', 'Crear Cuentas Pagar', NULL, 1, 1, '2023-08-11 13:14:26', '2023-08-11 13:14:26'),
(19, 'cuentaspagar_read', 'web', 'Leer Cuentas Pagar', NULL, 1, 1, '2023-08-11 13:14:37', '2023-08-11 13:14:37'),
(20, 'cuentaspagar_update', 'web', 'Actualizar Cuentas Cobrar', NULL, 1, 1, '2023-08-11 13:14:49', '2023-08-11 13:14:49'),
(21, 'cuentaspagar_delete', 'web', 'Eliminar Cuentas Cobrar', NULL, 1, 1, '2023-08-11 13:15:03', '2023-08-11 13:15:03'),
(22, 'cupones_create', 'web', 'Crear Cupones', NULL, 1, 1, '2023-09-12 14:15:50', '2023-09-12 14:16:24'),
(23, 'cupones_read', 'web', 'Leer Cupones', NULL, 1, 1, '2023-09-12 14:16:07', '2023-09-12 14:16:07'),
(24, 'cupones_update', 'web', 'Actualizar Cupones', NULL, 1, 1, '2023-09-12 14:16:51', '2023-09-12 14:17:05'),
(25, 'cupones_delete', 'web', 'Eliminar Cupones', NULL, 1, 1, '2023-09-12 14:17:33', '2023-09-12 14:17:33'),
(26, 'traslados_create', 'web', 'Crear Traslados', NULL, 1, 1, '2023-09-23 13:55:00', '2023-09-23 13:55:00'),
(27, 'traslados_read', 'web', 'Leer Traslados', NULL, 1, 1, '2023-09-23 13:55:14', '2023-09-23 13:55:14'),
(28, 'traslados_update', 'web', 'Actualizar Traslados', NULL, 1, 1, '2023-09-23 13:55:29', '2023-09-23 13:55:29'),
(29, 'traslados_delete', 'web', 'Eliminar Traslados', NULL, 1, 1, '2023-09-23 13:55:44', '2023-09-23 13:56:05'),
(30, 'cotizaciones_create', 'web', 'Crear Cotización', NULL, 1, 1, '2024-02-26 16:02:29', '2024-02-26 16:02:29');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 2, 'MyApp', '584dbc45f86ad020adc5470ae13da24b34c8ee2b89cab4de91e89a7f317eadb0', '[\"*\"]', '2024-02-23 17:04:24', '2024-02-23 16:52:07', '2024-02-23 17:04:24'),
(2, 'App\\Models\\User', 2, 'MyApp', '86701a0afc275f27332e13c0c334e9b933a47e3c3f0899764fe55e0bf4259f2d', '[\"*\"]', '2024-02-26 14:09:52', '2024-02-26 13:56:42', '2024-02-26 14:09:52'),
(3, 'App\\Models\\User', 2, 'MyApp', 'fd8c8dbbd872ddd68ec74045c3e874264db111ca89540a7493762f976d5aae6c', '[\"*\"]', NULL, '2024-02-26 16:18:17', '2024-02-26 16:18:17'),
(4, 'App\\Models\\User', 2, 'MyApp', '8faa363d1d50ebf34b12a9c3ff67a983a12f0f277fe7e89bebbac6defbfe2e7a', '[\"*\"]', NULL, '2024-02-26 18:45:53', '2024-02-26 18:45:53'),
(5, 'App\\Models\\User', 2, 'MyApp', '9d541595bd0c42ca4c6933e0c3f76ac51f5d68cb674813b1c1a51ee1469a33d2', '[\"*\"]', NULL, '2024-02-27 14:05:49', '2024-02-27 14:05:49'),
(6, 'App\\Models\\User', 2, 'MyApp', '4a05a2ebd07b4a9e77ce070f87cb22699dbeeccd1397fd3d12d742e0ac27b19b', '[\"*\"]', '2024-02-29 15:41:19', '2024-02-28 13:19:04', '2024-02-29 15:41:19');

-- --------------------------------------------------------

--
-- Table structure for table `precios_lentes`
--

CREATE TABLE `precios_lentes` (
  `id_precio_lente` int UNSIGNED NOT NULL,
  `modelo` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fabricacion` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serie` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tratamiento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fotocromatico` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_fotocromatico` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `laboratorio` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_propio` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_laboratorio` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_compra` decimal(11,2) DEFAULT NULL,
  `precio_venta` decimal(11,2) DEFAULT NULL,
  `tiempo_espera` int NOT NULL DEFAULT '0',
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `es_trio` tinyint DEFAULT '0' COMMENT 'lente pertenece a los contabilizados como trio? 1= SI, 0 = no',
  `estado` tinyint DEFAULT '1',
  `active` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `precios_lentes`
--

INSERT INTO `precios_lentes` (`id_precio_lente`, `modelo`, `fabricacion`, `material`, `serie`, `tratamiento`, `nombre`, `fotocromatico`, `color_fotocromatico`, `laboratorio`, `nombre_propio`, `nombre_laboratorio`, `precio_compra`, `precio_venta`, `tiempo_espera`, `id_sucursal`, `es_trio`, `estado`, `active`, `created_at`, `updated_at`) VALUES
(1, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'PRIMERA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 PRIMERA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 BLINDEX', '14.00', '50.00', 24, 2, 0, 1, 1, '2022-09-07 22:36:21', '2023-03-07 16:26:06'),
(2, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'PRIMERA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 PRIMERA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 MATIC', '25.00', '115.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(3, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'PRIMERA SERIE', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO FAMHIES', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 PRIMERA SERIE AR DELUXE', 'LABORATORIO FAMHIES MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 AR', '34.00', '130.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(4, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'PRIMERA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 PRIMERA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 BLINDEX', '8.70', '80.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(5, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'PRIMERA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 PRIMERA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 MATIC', '17.10', '115.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(6, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'PRIMERA SERIE', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO FAMHIES', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 PRIMERA SERIE AR DELUXE', 'LABORATORIO FAMHIES MONOFOCAL CONVENCIONAL NK-55 1.56 AR', '7.65', '130.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(7, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'SEGUNDA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 SEGUNDA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 BLINDEX', '32.00', '90.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-12-28 05:08:49'),
(8, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'SEGUNDA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 SEGUNDA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 MATIC', '40.00', '140.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(9, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'SEGUNDA SERIE', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO FAMHIES', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 SEGUNDA SERIE AR DELUXE', 'LABORATORIO FAMHIES MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 AR', '42.50', '160.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(10, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'SEGUNDA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 SEGUNDA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 BLINDEX', '11.40', '90.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(11, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'SEGUNDA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 SEGUNDA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 MATIC', '24.70', '140.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(12, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'SEGUNDA SERIE', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO FAMHIES', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 SEGUNDA SERIE AR DELUXE', 'LABORATORIO FAMHIES MONOFOCAL CONVENCIONAL NK-55 1.56 AR', '22.11', '160.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(13, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'TERCERA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 TERCERA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 BLINDEX', '42.00', '120.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(14, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'TERCERA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 TERCERA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 MATIC', '60.00', '180.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(15, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'TERCERA SERIE', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO FAMHIES', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 TERCERA SERIE AR DELUXE', 'LABORATORIO FAMHIES MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 AR', '59.50', '230.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(16, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'TERCERA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 TERCERA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 BLINDEX', '42.00', '120.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(17, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'TERCERA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 TERCERA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 MATIC', '72.20', '180.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(18, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'TERCERA SERIE', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO FAMHIES', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 TERCERA SERIE AR DELUXE', 'LABORATORIO FAMHIES MONOFOCAL CONVENCIONAL NK-55 1.56 AR', '29.00', '230.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(19, 'MONOFOCAL', 'CONVENCIONAL', 'FINE 1.60', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL FINE 1.60 ANTI RAYAS', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL ALTO INDICE 1.60 DURA +', '50.00', '170.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(20, 'MONOFOCAL', 'CONVENCIONAL', 'FINE 1.60', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL FINE 1.60 AR PREMIUM', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL ALTO INDICE 1.60 AR LAYER', '80.00', '225.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(21, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 ANTI RAYAS', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 DURA +', '100.00', '250.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(22, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR PREMIUM', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 AR LAYER', '170.00', '395.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(23, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 ANTI RAYAS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 ANTI RAYAS', '166.00', '415.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(24, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 NOX', '235.84', '545.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(25, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR DELUXE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 DEVA BLUE', '286.00', '660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(26, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 BLUE TECH AR PREMIUM', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL POLICARBONATO INDIGO AR SIMPLE (UNA CARA)', '59.50', '0.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(27, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO FAMHIES', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH AR DELUXE', 'LABORATORIO FAMHIES MONOFOCAL CONVENCIONAL NK-55 1.56 PROTECCION DE LUZ AZUL BLUE BLOCK AR', '60.00', '0.00', 0, 2, 1, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(28, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60 BLUE TECH', 'N/A', 'AR PREMIUM', 'NORMATIVA ANSI Z87.1', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 BLUE TECH AR PREMIUM', 'LABORATORIO TOPSA MONOFOCAL FREE EVOLUTION BLUE PROTECT VISUAL KIDS AR 16', '140.00', '415.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(29, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60 BLUE TECH', 'N/A', 'AR DELUXE', 'NORMATIVA ANSI Z87.1', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 BLUE TECH AR DELUXE', 'LABORATORIO TOPSA MONOFOCAL 1.60 FREE EVOLUTION BLUE PROTECT VISUAL KIDS AR SKY', '140.00', '450.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(30, 'MONOFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL DIGITAL TRIVEX 1.53 AR PREMIUM', 'LABORATORIO UNO MONOFOCAL SUPERVEX AR SIMPLE (UNA CARA)', '120.00', '480.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(31, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'ANTI RAYAS', 'NORMATIVA ANSI Z87.1', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 ANTI RAYAS', 'LABORATORIO TOPSA MONOFOCAL DIGITAL VISUAL KIDS 1.60 DQ', '140.00', '380.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(32, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'AR PREMIUM', 'NORMATIVA ANSI Z87.1', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 AR PREMIUM', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 VISUAL KIDS AR 16', '175.00', '390.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(33, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'AR DELUXE', 'NORMATIVA ANSI Z87.1', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 AR DELUXE', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 VISUAL KIDS AR SKY', '236.00', '430.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(34, 'MONOFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL EXTRA FINE 1.67 ANTI RAYAS', 'LABORATORIO TRIMAX MONOFOCAL DIGITAL ALTO INDICE 1.67 ANTI RAYAS SMART SV / AS WORN', '170.40', '395.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(35, 'MONOFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL EXTRA FINE 1.67 AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL DIGITAL ALTO INDICE 1.67 NOX SMART SV / AS WORN', '240.60', '555.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(36, 'MONOFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL EXTRA FINE 1.67 AR DELUXE', 'LABORATORIO TRIMAX MONOFOCAL DIGITAL ALTO INDICE 1.67 DEVA BLUE SMART SV / AS WORN', '290.40', '670.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(37, 'MONOFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL HYPER FINE 1.74 ANTI RAYAS', 'LABORATORIO TRIMAX MONOFOCAL DIGITAL ALTO INDICE 1.74 BLINDEX DIGITAL ABSOLUT', '221.00', '565.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(38, 'MONOFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL HYPER FINE 1.74 AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL DIGITAL ALTO INDICE 1.74 AR 16', '279.68', '740.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(39, 'MONOFOCAL', 'DIGITAL', 'HYPER FINE 1.74 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL HYPER FINE 1.74 BLUE TECH AR DELUXE', 'LABORATORIO TRIMAX MONOFOCAL DIGITAL ALTO INDICE 1.74 PROTECCION DE LUZ AZUL AR DEVABLUE', '377.58', '865.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(40, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 ANTI RAYAS TRANSITIONS GEN 8 GRIS', '250.00', '505.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(41, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 NOX TRANSITIONS GEN 8 GRIS', '280.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(42, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 DEVA BLUE TRANSITIONS GEN 8 GRIS', '310.00', '780.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(43, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 ANTI RAYAS TRANSITIONS GEN 8 MARRON', '250.00', '505.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(44, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 NOX TRANSITIONS GEN 8 MARRON', '280.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(45, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 DEVA BLUE TRANSITIONS GEN 8 MARRON', '310.00', '780.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(46, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 ANTI RAYAS TRANSITIONS GEN 8 VERDE', '250.00', '505.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(47, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 NOX TRANSITIONS GEN 8 VERDE', '280.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(48, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 DEVA BLUE TRANSITIONS GEN 8 VERDE', '310.00', '780.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(49, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', '250.00', '505.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(50, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 NOX TRANSITIONS GEN 8 ZAFIRO', '280.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(51, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 DEVA BLUE TRANSITIONS GEN 8 ZAFIRO', '310.00', '780.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(52, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', '250.00', '505.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(53, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 NOX TRANSITIONS GEN 8 AMATISTA', '280.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(54, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 DEVA BLUE TRANSITIONS GEN 8 AMATISTA', '310.00', '780.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(55, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 ANTI RAYAS TRANSITIONS GEN 8 GRIS', '238.00', '550.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(56, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 NOX TRANSITIONS GEN 8 GRIS', '307.84', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(57, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 DEVA BLUE TRANSITIONS GEN 8 GRIS', '358.00', '825.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(58, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 ANTI RAYAS TRANSITIONS GEN 8 MARRON', '308.00', '550.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(59, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 NOX TRANSITIONS GEN 8 MARRON', '350.00', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(60, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 DEVA BLUE TRANSITIONS GEN 8 MARRON', '490.00', '825.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(61, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 ANTI RAYAS TRANSITIONS GEN 8 VERDE', '308.00', '550.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(62, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 NOX TRANSITIONS GEN 8 VERDE', '350.00', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(63, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 DEVA BLUE TRANSITIONS GEN 8 VERDE', '490.00', '825.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(64, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', '308.00', '550.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(65, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 NOX TRANSITIONS GEN 8 ZAFIRO', '350.00', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(66, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 DEVA BLUE TRANSITIONS GEN 8 ZAFIRO', '490.00', '825.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(67, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', '308.00', '550.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(68, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 NOX TRANSITIONS GEN 8 AMATISTA', '350.00', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(69, 'MONOFOCAL', 'CONVENCIONAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.67 DEVA BLUE TRANSITIONS GEN 8 AMATISTA', '490.00', '825.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(70, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 ANTI RAYAS TRANSITIONS GEN 8 GRIS', '340.00', '785.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(71, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 NOX TRANSITIONS GEN 8 GRIS', '409.84', '945.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(72, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 DEVA BLUE TRANSITIONS GEN 8 GRIS', '460.00', '1060.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(73, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 ANTI RAYAS TRANSITIONS GEN 8 MARRON', '340.00', '785.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(74, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 NOX TRANSITIONS GEN 8 MARRON', '409.84', '945.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(75, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 DEVA BLUE TRANSITIONS GEN 8 MARRON', '460.00', '1060.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(76, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 ANTI RAYAS TRANSITIONS GEN 8 VERDE', '340.00', '785.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(77, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 NOX TRANSITIONS GEN 8 VERDE', '409.84', '945.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(78, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 DEVA BLUE TRANSITIONS GEN 8 VERDE', '460.00', '1060.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(79, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', '340.00', '785.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(80, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 NOX TRANSITIONS GEN 8 ZAFIRO', '409.84', '945.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(81, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 DEVA BLUE TRANSITIONS GEN 8 ZAFIRO', '460.00', '1060.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(82, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', '340.00', '785.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(83, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 NOX TRANSITIONS GEN 8 AMATISTA', '409.84', '945.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(84, 'MONOFOCAL', 'CONVENCIONAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL ALTO INDICE 1.74 DEVA BLUE TRANSITIONS GEN 8 AMATISTA', '460.00', '1060.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(85, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS XTRACTIVE GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 ANTI RAYAS XTRACTIVE GRIS', '202.00', '465.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(86, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM XTRACTIVE GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 NOX XTRACTIVE GRIS', '271.84', '625.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(87, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE XTRACTIVE GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 DEVA BLUE XTRACTIVE GRIS', '322.00', '740.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(88, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS VANTAGE GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 ANTI RAYAS VANTAGE GRIS', '280.00', '705.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(89, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM VANTAGE GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 NOX VANTAGE GRIS', '349.84', '645.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(90, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE VANTAGE GRIS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 DEVA BLUE VANTAGE GRIS', '400.00', '805.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(91, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'N/A', 'ANTI RAYAS', 'N/A', 'DRIVEWEAR', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS DRIVEWEAR ', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 BLINDEX DRIVEWEAR', '469.84', '920.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(92, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'N/A', 'AR PREMIUM', 'N/A', 'DRIVEWEAR', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM DRIVEWEAR', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 MATIC DRIVEWEAR', '420.00', '965.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(93, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'N/A', 'AR DELUXE', 'N/A', 'DRIVEWEAR', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE DRIVEWEAR', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 ONDAX DRIVEWEAR', '450.00', '1035.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(94, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'ANTI RAYAS', 'N/A', 'POLARIZADO', 'GRIS', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ANTI RAYAS POLARIZADO GRIS', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA 1.49 DURA + POLARIZADO GRIS', '120.00', '280.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(95, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'ANTI RAYAS', 'N/A', 'POLARIZADO', 'MARRON', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ANTI RAYAS POLARIZADO MARRON', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA 1.49 DURA + POLARIZADO MARRON', '120.00', '280.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(96, 'MONOFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 CURVE', 'N/A', 'ANTI RAYAS', 'PRIORITY LENS CURVE', 'POLARIZADO', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL PRIORITY LENS 1.59 CURVE ANTI RAYAS POLARIZADO GRIS', 'LABORATORIO TRIMAX MONOFOCAL SMART ATTITUDE POLICARBONATO 1.59 ANTI RAYAS POLARIZADO GRIS', '246.00', '565.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(97, 'MONOFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 CURVE', 'N/A', 'ANTI RAYAS', 'PRIORITY LENS CURVE', 'POLARIZADO', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL PRIORITY LENS 1.59 CURVE ANTI RAYAS POLARIZADO MARRON', 'LABORATORIO TRIMAX MONOFOCAL SMART ATTITUDE POLICARBONATO 1.59 ANTI RAYAS POLARIZADO MARRON', '246.00', '565.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(98, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'N/A', 'N/A', 'ESPEJADO POLARIZADO', 'PLATEADO', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ESPEJADO POLARIZADO PLATEADO', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA 1.49  ESPEJADO POLARIZADO PLATEADO', '130.00', '300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(99, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'N/A', 'N/A', 'ESPEJADO POLARIZADO', 'ROJO', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ESPEJADO POLARIZADO ROJO', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA 1.49  ESPEJADO POLARIZADO ROJO', '130.00', '300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(100, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'N/A', 'N/A', 'ESPEJADO POLARIZADO', 'ROSADO', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ESPEJADO POLARIZADO ROSADO', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA 1.49  ESPEJADO POLARIZADO ROSADO', '130.00', '300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(101, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'N/A', 'N/A', 'ESPEJADO POLARIZADO', 'AZUL', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ESPEJADO POLARIZADO AZUL', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA 1.49 ESPEJADO POLARIZADO AZUL', '130.00', '300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(102, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'N/A', 'N/A', 'ESPEJADO POLARIZADO', 'DORADO', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ESPEJADO POLARIZADO DORADO', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA 1.49 AR SIMPLE (UNA CARA) ESPEJADO POLARIZADO DORADO', '130.00', '300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(103, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'N/A', 'N/A', 'ESPEJADO POLARIZADO', 'VERDE', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ESPEJADO POLARIZADO VERDE', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA 1.49 ESPEJADO POLARIZADO VERDE', '130.00', '300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(104, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'ANTI RAYAS', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49  ANTI RAYAS CHROMASOL GRIS', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL RESINA 1.49 DQ SENSITIVE GRIS', '100.00', '230.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(105, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'AR PREMIUM', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 AR PREMIUM CHROMASOL GRIS', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL RESINA 1.49 AR 16 SENSITIVE GRIS', '150.00', '345.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(106, 'MONOFOCAL', 'DIGITAL', 'PRIORITY LENS 1.49', 'N/A', 'AR DELUXE', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL PRIORITY LENS 1.49 AR DELUXE CHROMASOL GRIS', 'LABORATORIO TOPSA MONOFOCAL DIGITAL RESINA 1.49 AR SKY FOTOMATIC IQ GRIS', '200.00', '460.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(107, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'ANTI RAYAS', 'N/A', 'CHROMASOL', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 ANTI RAYAS CHROMASOL MARRON', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL RESINA 1.49 DQ SENSITIVE MARRON', '100.00', '230.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(108, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'AR PREMIUM', 'N/A', 'CHROMASOL', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.49 AR PREMIUM CHROMASOL MARRON', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL RESINA 1.49 AR 16 SENSITIVE MARRON', '150.00', '345.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(109, 'MONOFOCAL', 'DIGITAL', 'PRIORITY LENS 1.49', 'N/A', 'AR DELUXE', 'N/A', 'CHROMASOL', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL PRIORITY LENS 1.49 AR DELUXE CHROMASOL MARRON', 'LABORATORIO TOPSA MONOFOCAL DIGITAL RESINA 1.49 AR SKY FOTOMATIC IQ MARRON', '200.00', '460.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(110, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS COLOREADO 1.49 D.70', 'PRIMERA Y SEGUNDA SERIE', 'N/A', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS COLOREADO 1.49 PRIMERA Y SEGUNDA SERIE', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA COLOREADA CON UV.', '55.00', '160.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(111, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS COLOREADO 1.49 D.80', 'PRIMERA Y SEGUNDA SERIE', 'N/A', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS COLOREADO 1.49 PRIMERA Y SEGUNDA SERIE', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL RESINA COLOREADA BLINDEX CON UV.', '60.00', '200.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(112, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS COLOREADO 1.49 D.80', 'TERCERA SERIE', 'N/A', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS COLOREADO 1.49 TERCERA SERIE', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL RESINA COLOREADA CON UV.', '130.00', '260.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(113, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'PRIMERA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 PRIMERA SERIE ANTI RAYAS ENDURECIDO', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL CRISTAL 1.55 ENDURECIDO', '23.60', '60.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(114, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'PRIMERA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 PRIMERA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL CRISTAL 1.55 MATIC', '72.00', '170.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(115, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'SEGUNDA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 SEGUNDA SERIE ANTI RAYAS ENDURECIDO', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL CRISTAL 1.55 ENDURECIDO', '40.00', '95.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(116, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'SEGUNDA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55  SEGUNDA SERIE AR PREMIUM ', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL CRISTAL 1.55 MATIC', '100.00', '230.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(117, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'TERCERA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 TERCERA SERIE ANTI RAYAS ENDURECIDO', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL CRISTAL 1.55 ENDURECIDO', '54.00', '135.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(118, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'TERCERA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 TERCERA SERIE AR PREMIUM ', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL CRISTAL 1.55 MATIC', '120.00', '280.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(119, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'PRIMERA SERIE', 'ANTI RAYAS', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 PRIMERA SERIE ANTI RAYAS FOTOCROMATICO GRIS', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE SIMPLE FOTOCROMATICO GRIS', '56.00', '115.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(120, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'PRIMERA SERIE', 'AR PREMIUM', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 PRIMERA SERIE AR PREMIUM FOTOCROMATICO GRIS', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE AR 16 FOTOCROMATICO GRIS', '128.00', '260.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(121, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'PRIMERA SERIE', 'ANTI RAYAS', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 PRIMERA SERIE ANTI RAYAS FOTOCROMATICO MARRON', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE SIMPLE FOTOCROMATICO MARRON', '56.00', '115.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(122, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'PRIMERA SERIE', 'AR PREMIUM', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 PRIMERA SERIE AR PREMIUM FOTOCROMATICO MARRON', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE AR 16 FOTOCROMATICO MARRON', '128.00', '260.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(123, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'SEGUNDA SERIE', 'ANTI RAYAS', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 SEGUNDA SERIE ANTI RAYAS FOTOCROMATICO GRIS', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE SIMPLE FOTOCROMATICO GRIS', '84.00', '170.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(124, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'SEGUNDA SERIE', 'AR PREMIUM', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 SEGUNDA SERIE AR PREMIUM FOTOCROMATICO GRIS', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE AR 16 FOTOCROMATICO GRIS', '135.00', '270.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(125, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'SEGUNDA SERIE', 'ANTI RAYAS', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 SEGUNDA SERIE ANTI RAYAS FOTOCROMATICO MARRON', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE SIMPLE FOTOCROMATICO MARRON', '84.00', '170.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(126, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'SEGUNDA SERIE', 'AR PREMIUM', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 SEGUNDA SERIE AR PREMIUM FOTOCROMATICO MARRON', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE AR 16 FOTOCROMATICO MARRON', '135.00', '270.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(127, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'TERCERA SERIE', 'ANTI RAYAS', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 TERCERA SERIE ANTI RAYAS FOTOCROMATICO GRIS', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE SIMPLE FOTOCROMATICO GRIS', '101.00', '205.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(128, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'TERCERA SERIE', 'AR PREMIUM', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 TERCERA SERIE AR PREMIUM FOTOCROMATICO GRIS', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE AR 16 FOTOCROMATICO GRIS', '146.00', '295.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(129, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'TERCERA SERIE', 'ANTI RAYAS', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 TERCERA SERIE ANTI RAYAS FOTOCROMATICO MARRON', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE SIMPLE FOTOCROMATICO MARRON', '101.00', '205.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(130, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'TERCERA SERIE', 'AR PREMIUM', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TOPSA', 'MONOFOCAL CONVENCIONAL CRISTAL 1.55 TERCERA SERIE AR PREMIUM FOTOCROMATICO MARRON', 'LABORATORIO TOPSA MONOFOCAL CONVENCIONAL CRISTAL X-LITE AR 16 FOTOCROMATICO MARRON', '146.00', '295.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(131, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'BIFOCAL CONVENCIONAL FLAP TOP CRISTAL 1.55 ENDURECIDO ANTI RAYAS', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL CRISTAL 1.55 ENDURECIDO', '60.00', '155.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(132, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'BIFOCAL CONVENCIONAL FLAP TOP CRISTAL 1.55 AR PREMIUM', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL CRISTAL 1.55 MATIC', '100.00', '230.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(133, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'ANTI RAYAS', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO OXO', 'BIFOCAL CONVENCIONAL FLAP TOP CRISTAL 1.55 ANTI RAYAS FOTOCROMATICO GRIS', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL CRISTAL 1.55 ENDURECIDO FOTOCROMATICO GRIS', '116.00', '270.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(134, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'AR PREMIUM', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO OXO', 'BIFOCAL CONVENCIONAL FLAP TOP CRISTAL 1.55 AR PREMIUM FOTOCROMATICO GRIS', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL CRISTAL 1.55 MATIC FOTOCROMATICO GRIS', '120.00', '280.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(135, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'ANTI RAYAS', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO OXO', 'BIFOCAL CONVENCIONAL FLAP TOP CRISTAL 1.55 ANTI RAYAS FOTOCROMATICO MARRON', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL CRISTAL 1.55 ENDURECIDO FOTOCROMATICO MARRON', '116.00', '270.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21');
INSERT INTO `precios_lentes` (`id_precio_lente`, `modelo`, `fabricacion`, `material`, `serie`, `tratamiento`, `nombre`, `fotocromatico`, `color_fotocromatico`, `laboratorio`, `nombre_propio`, `nombre_laboratorio`, `precio_compra`, `precio_venta`, `tiempo_espera`, `id_sucursal`, `es_trio`, `estado`, `active`, `created_at`, `updated_at`) VALUES
(136, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'AR PREMIUM', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO OXO', 'BIFOCAL CONVENCIONAL FLAP TOP CRISTAL 1.55 AR PREMIUM FOTOCROMATICO MARRON', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL CRISTAL 1.55 MATIC FOTOCROMATICO MARRON', '120.00', '280.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(137, 'MULTIFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MULTIFOCAL CONVENCIONAL CRISTAL 1.55 ANTI RAYAS ENDURECIDO ', 'LABORATORIO OXO MULTIFOCAL CONVENCIONAL CRISTAL 1.55 ENDURECIDO', '206.00', '500.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(138, 'MULTIFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MULTIFOCAL CONVENCIONAL CRISTAL 1.55 AR PREMIUM', 'LABORATORIO OXO MULTIFOCAL CONVENCIONAL CRISTAL 1.55 MATIC', '270.00', '620.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(139, 'MULTIFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'ANTI RAYAS', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO OXO', 'MULTIFOCAL CONVENCIONAL CRISTAL 1.55 ANTI RAYAS ENDURECIDO FOTOCROMATICO GRIS', 'LABORATORIO OXO MULTIFOCAL CONVENCIONAL CRISTAL 1.55 ENDURECIDO FOTOCROMATICO GRIS', '286.00', '660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(140, 'MULTIFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'AR PREMIUM', 'N/A', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO OXO', 'MULTIFOCAL CONVENCIONAL CRISTAL 1.55 AR PREMIUM FOTOCROMATICO GRIS', 'LABORATORIO OXO MULTIFOCAL CONVENCIONAL CRISTAL 1.55 MATIC FOTOCROMATICO GRIS', '370.00', '850.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(141, 'MULTIFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'ANTI RAYAS', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO OXO', 'MULTIFOCAL CONVENCIONAL CRISTAL 1.55 ANTI RAYAS ENDURECIDO FOTOCROMATICO MARRON', 'LABORATORIO OXO MULTIFOCAL CONVENCIONAL CRISTAL 1.55 ENDURECIDO FOTOCROMATICO MARRON', '286.00', '660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(142, 'MULTIFOCAL', 'CONVENCIONAL', 'CRISTAL 1.55', 'N/A', 'AR PREMIUM', 'N/A', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO OXO', 'MULTIFOCAL CONVENCIONAL CRISTAL 1.55 AR PREMIUM FOTOCROMATICO MARRON', 'LABORATORIO OXO MULTIFOCAL CONVENCIONAL CRISTAL 1.55 MATIC FOTOCROMATICO MARRON', '370.00', '850.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(143, 'MULTIFOCAL', 'CONVENCIONAL', 'CRISTAL 1.7', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MULTIFOCAL CONVENCIONAL CRISTAL 1.7 ANTI RAYAS', 'LABORATORIO OXO MULTIFOCAL CONVENCIONAL CRISTAL 1.7 CRISTAL BLANCO', '256.00', '650.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(144, 'MULTIFOCAL', 'CONVENCIONAL', 'CRISTAL 1.7', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MULTIFOCAL CONVENCIONAL CRISTAL 1.7 AR PREMIUM', 'LABORATORIO OXO MULTIFOCAL CONVENCIONAL CRISTAL 1.7 MATIC', '320.00', '735.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(145, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.8', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL CRISTAL 1.8 ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL CRISTAL 1.8 CRISTAL BLANCO', '200.00', '460.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(146, 'MONOFOCAL', 'CONVENCIONAL', 'CRISTAL 1.8', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL CRISTAL 1.8 AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL CRISTAL 1.8 MATIC', '240.00', '555.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(147, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.59 ANTI RAYAS', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL POLICARBONATO 1.59 BLINDEX', '50.00', '115.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(148, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.59 AR PREMIUM', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL POLICARBONATO 1.59 MATIC', '82.00', '190.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(149, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.59', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.59 AR DELUXE', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL POLICARBONATO 1.59 ONDAX', '112.00', '260.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(150, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'ANTI RAYAS', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 ANTI RAYAS CHROMASOL GRIS', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 BLINDEX CROMAX GRIS', '160.00', '370.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(151, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'AR PREMIUM', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 AR PREMIUM CHROMASOL GRIS', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 MATIC CROMAX GRIS', '180.00', '415.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(152, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'AR DELUXE', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 AR DELUXE CHROMASOL GRIS', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 ONDAX CROMAX GRIS', '210.00', '485.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(153, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'ANTI RAYAS', 'N/A', 'CHROMASOL', 'MARRON', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 ANTI RAYAS CHROMASOL MARRON', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 BLINDEX CROMAX MARRON', '160.00', '370.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(154, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'AR PREMIUM', 'N/A', 'CHROMASOL', 'MARRON', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 AR PREMIUM CHROMASOL MARRON', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 MATIC CROMAX MARRON', '180.00', '415.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(155, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'N/A', 'AR DELUXE', 'N/A', 'CHROMASOL', 'MARRON', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 AR DELUXE CHROMASOL MARRON', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 ONDAX CROMAX MARRON', '210.00', '485.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(156, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'CHROMASOL AZUL', 'GRIS', 'LABORATORIO OXO', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS NK 1.56 ANTI RAYAS CHROMASOL BLUE TECH GRIS', 'LABORATORIO OXO BIFOCAL INVISIBLE DIGITAL DIPPING BLINDEX', '280.00', '645.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(157, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'CHROMASOL AZUL', 'GRIS', 'LABORATORIO OXO', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS NK 1.56 AR PREMIUM CHROMASOL BLUE TECH GRIS', 'LABORATORIO OXO BIFOCAL INVISIBLE DIGITAL DIPPING MATIC', '310.00', '713.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(158, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'CHROMASOL AZUL', 'GRIS', 'LABORATORIO OXO', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS NK 1.56 AR DELUXE CHROMASOL BLUE TECH GRIS', 'LABORATORIO OXO BIFOCAL INVISIBLE DIGITAL DIPPING ONDAX', '340.00', '785.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(159, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS COLOREADO 1.49', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 ANTI RAYAS COLOREADO ', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 COLOREADA CON UV BLINDEX', '27.00', '150.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(160, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS COLOREADO 1.49', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 AR PREMIUM COLOREADO ', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 COLOREADA CON UV MATIC', '80.00', '220.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(161, 'BIFOCAL FLAP TOP', 'CONVENCIONAL', 'PRIORITY LENS COLOREADO 1.49', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'BIFOCAL FLAP TOP CONVENCIONAL PRIORITY LENS 1.49 AR DELUXE COLOREADO ', 'LABORATORIO OXO BIFOCAL FLAP TOP CONVENCIONAL RESINA 1.49 COLOREADA CON UV ONDAX', '110.00', '280.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(162, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 ANTI RAYAS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO ANTI RAYAS', '146.40', '340.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(163, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR PREMIUM', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO NOX', '216.60', '500.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(164, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR DELUXE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO DEVA BLUE', '266.40', '615.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(165, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 ANTI RAYAS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO ANTI RAYAS', '207.60', '480.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(166, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR PREMIUM', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO NOX', '277.80', '640.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(167, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR DELUXE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO DEVA BLUE', '327.60', '755.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(168, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 ANTI RAYAS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO ANTI RAYAS', '279.60', '645.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(169, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR PREMIUM', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO NOX', '349.80', '805.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(170, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR DELUXE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO DEVA BLUE', '399.60', '920.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(171, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 VERDE', '308.40', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(172, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO NOX TRANSITIONS GEN 8 VERDE', '378.60', '875.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(173, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 VERDE', '428.40', '990.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(174, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', '308.40', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(175, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO NOX TRANSITIONS GEN 8 ZAFIRO', '378.60', '875.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(176, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 ZAFIRO', '428.40', '990.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(177, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 GRIS', '308.40', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(178, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO NOX TRANSITIONS GEN 8 GRIS', '378.60', '875.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(179, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 GRIS', '428.40', '990.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(180, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', '308.40', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(181, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO NOX TRANSITIONS GEN 8 AMATISTA', '378.60', '875.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(182, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 AMATISTA', '428.40', '990.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(183, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 MARRON', '308.40', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(184, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO NOX TRANSITIONS GEN 8 MARRON', '378.60', '875.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(185, 'BIFOCAL INVISIBLE', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL PRIORITY LENS 1.59 AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL POLICARBONATO 1.59 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 MARRON', '428.40', '990.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(186, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 VERDE', '500.00', '1020.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(187, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO NOX TRANSITIONS GEN 8 VERDE', '511.80', '1180.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(188, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 VERDE', '561.60', '1295.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(189, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', '441.60', '1020.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(190, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO NOX TRANSITIONS GEN 8 ZAFIRO', '511.80', '1180.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(191, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 ZAFIRO', '561.60', '1295.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(192, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 GRIS', '441.60', '1020.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(193, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO NOX TRANSITIONS GEN 8 GRIS', '511.80', '1180.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(194, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 GRIS', '561.60', '1295.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(195, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', '441.60', '1020.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(196, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO NOX TRANSITIONS GEN 8 AMATISTA', '511.80', '1180.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(197, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 AMATISTA', '561.60', '1295.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(198, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 MARRON', '441.60', '1020.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(199, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO NOX TRANSITIONS GEN 8 MARRON', '511.80', '1180.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(200, 'BIFOCAL INVISIBLE', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL EXTRA FINE 1.67 AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.67 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 MARRON', '561.60', '1295.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(201, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 GRIS', '462.00', '1065.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(202, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO NOX TRANSITIONS GEN 8 GRIS', '532.20', '1225.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(203, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 GRIS', '582.00', '1340.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(204, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 MARRON', '462.00', '1065.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(205, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO NOX TRANSITIONS GEN 8 MARRON', '532.20', '1225.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(206, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 MARRON', '582.00', '1340.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(207, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 VERDE', '462.00', '1065.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(208, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO NOX TRANSITIONS GEN 8 VERDE', '532.20', '1225.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(209, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 VERDE', '582.00', '1340.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(210, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', '462.00', '1065.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(211, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO NOX TRANSITIONS GEN 8 ZAFIRO', '532.20', '1225.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(212, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 ZAFIRO', '582.00', '1340.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(213, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', '462.00', '1065.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(214, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO NOX TRANSITIONS GEN 8 AMATISTA', '532.20', '1225.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(215, 'BIFOCAL INVISIBLE', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'N/A', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'BIFOCAL INVISIBLE DIGITAL HYPER FINE 1.74 AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX BIFOCAL INVISIBLE DIGITAL ALTO INDICE 1.74 SHAMIR DUO DEVA BLUE TRANSITIONS GEN 8 AMATISTA', '582.00', '1340.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(216, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO ADAPTAR ANTI RAYAS', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DQ EASY VIEW SHORT HD', '250.00', '575.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(217, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO ADAPTAR AR PREMIUM', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 EASY VIEW SHORT HD', '250.00', '600.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(218, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO ADAPTAR AR DELUXE', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR SKY EASY VIEW SHORT HD', '250.00', '635.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(219, 'MULTIFOCAL', 'DIGITAL', 'FINE 1.60', 'N/A', 'ANTI RAYAS', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL FINE 1.60 PROGRESIVO ADAPTAR ANTI RAYAS', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL ALTO INDICE 1.60 DQ EASY VIEW SHORT HD', '250.00', '580.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(220, 'MULTIFOCAL', 'DIGITAL', 'FINE 1.60', 'N/A', 'AR PREMIUM', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL FINE 1.60 PROGRESIVO ADAPTAR AR PREMIUM', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL ALTO INDICE 1.60 AR 16 EASY VIEW SHORT HD', '250.00', '600.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(221, 'MULTIFOCAL', 'DIGITAL', 'FINE 1.60', 'N/A', 'AR DELUXE', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL FINE 1.60 PROGRESIVO ADAPTAR AR DELUXE', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL ALTO INDICE 1.60 AR SKY EASY VIEW SHORT HD', '250.00', '650.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(222, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO ADAPTAR ANTI RAYAS', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL ALTO INDICE 1.67 DQ EASY VIEW SHORT HD', '250.00', '600.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(223, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO ADAPTAR AR PREMIUM', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL ALTO INDICE 1.67 AR 16 EASY VIEW SHORT HD', '250.00', '660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(224, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'PROGRESIVO ADAPTAR', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO ADAPTAR AR DELUXE', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL ALTO INDICE 1.67 AR SKY EASY VIEW SHORT HD', '250.00', '720.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(225, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'ANTI RAYAS', 'PROGRESIVO ADAPTAR', 'CHROMASOL', 'GRIS', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO ADAPTAR ANTI RAYAS CHROMASOL GRIS', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 DQ EASY VIEW SHORT HD FOTOMATIC IQ GRIS', '250.00', '1110.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(226, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR PREMIUM', 'PROGRESIVO ADAPTAR', 'CHROMASOL', 'GRIS', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO ADAPTAR AR PREMIUM CHROMASOL GRIS', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 EASY VIEW SHORT HD FOTOMATIC IQ GRIS', '250.00', '1195.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(227, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR DELUXE', 'PROGRESIVO ADAPTAR', 'CHROMASOL', 'GRIS', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO ADAPTAR AR DELUXE CHROMASOL GRIS', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR SKY EASY VIEW SHORT HD FOTOMATIC IQ GRIS', '250.00', '1260.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(228, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'ANTI RAYAS', 'PROGRESIVO ADAPTAR', 'CHROMASOL', 'MARRON', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO ADAPTAR ANTI RAYAS CHROMASOL MARRON', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 DQ EASY VIEW SHORT HD FOTOMATIC IQ MARRON', '250.00', '1110.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(229, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR PREMIUM', 'PROGRESIVO ADAPTAR', 'CHROMASOL', 'MARRON', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO ADAPTAR AR PREMIUM CHROMASOL MARRON', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 EASY VIEW SHORT HD FOTOMATIC IQ MARRON', '250.00', '1195.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(230, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR DELUXE', 'PROGRESIVO ADAPTAR', 'CHROMASOL', 'MARRON', 'LABORATORIO TOPSA', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO ADAPTAR AR DELUXE CHROMASOL MARRON', 'LABORATORIO TOPSA MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR SKY EASY VIEW SHORT HD FOTOMATIC IQ MARRON', '250.00', '1260.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(231, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO GOLD', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO GOLD ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS REVEAL', '250.00', '645.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(232, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO GOLD', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO GOLD AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 REVEAL', '320.20', '770.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(233, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO GOLD', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO GOLD AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE REVEAL', '370.00', '1040.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(234, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO GOLD', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 BLUE TECH PROGRESIVO GOLD ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 PROTECCION DE LUZ AZUL ANTI RAYAS REVEAL', '250.00', '680.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(235, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO GOLD', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 BLUE TECH PROGRESIVO GOLD AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 PROTECCION DE LUZ AZUL AR 16 REVEAL', '320.20', '805.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(236, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO GOLD', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 BLUE TECH PROGRESIVO GOLD AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 PROTECCION DE LUZ AZUL DEVA BLUE REVEAL', '370.00', '1090.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(237, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS REVEAL TRANSITIONS GEN 8 GRIS', '338.00', '850.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(238, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 REVEAL TRANSITIONS GEN 8 GRIS', '408.20', '1015.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(239, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE REVEAL TRANSITIONS GEN 8 GRIS', '458.00', '1370.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(240, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS REVEAL TRANSITIONS GEN 8 MARRON', '338.00', '850.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(241, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 REVEAL TRANSITIONS GEN 8 MARRON', '408.20', '1015.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(242, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE REVEAL TRANSITIONS GEN 8 MARRON', '458.00', '1370.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(243, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS REVEAL TRANSITIONS GEN 8 VERDE', '338.00', '850.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(244, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 REVEAL TRANSITIONS GEN 8 VERDE', '408.20', '1015.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(245, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE REVEAL TRANSITIONS GEN 8 VERDE', '458.00', '1370.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(246, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS REVEAL TRANSITIONS GEN 8 AMATISTA', '338.00', '850.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(247, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 REVEAL TRANSITIONS GEN 8 AMATISTA', '408.20', '1015.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(248, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE REVEAL TRANSITIONS GEN 8 AMATISTA', '458.00', '1370.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(249, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS REVEAL TRANSITIONS GEN 8 ZAFIRO', '338.00', '850.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(250, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 REVEAL TRANSITIONS GEN 8 ZAFIRO', '408.20', '1015.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(251, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE REVEAL TRANSITIONS GEN 8 ZAFIRO', '458.00', '1370.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(252, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD ANTI RAYAS TRANSITIONS GEN 8 XTRACTIVE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS REVEAL TRANSITIONS GEN 8 XTRACTIVE GRIS', '310.00', '780.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(253, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR PREMIUM TRANSITIONS GEN 8 XTRACTIVE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 REVEAL TRANSITIONS GEN 8 XTRACTIVE GRIS', '380.20', '920.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(254, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO GOLD', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO GOLD AR DELUXE TRANSITIONS GEN 8 XTRACTIVE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE REVEAL TRANSITIONS GEN 8 XTRACTIVE GRIS', '430.00', '1250.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(255, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO URBAN TOP 180', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO URBAN TOP 180 ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS SHAMIR URBAN', '386.40', '940.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(256, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO URBAN TOP 180', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO URBAN TOP 180 AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 SHAMIR URBAN', '456.60', '1190.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(257, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO URBAN TOP 180', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO URBAN TOP 180 AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE SHAMIR URBAN', '506.40', '1605.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(258, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS SHAMIR URBAN TRANSITIONS GEN 8 ZAFIRO', '488.40', '1125.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(259, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 SHAMIR URBAN TRANSITIONS GEN 8 ZAFIRO', '558.60', '1300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(260, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE SHAMIR URBAN TRANSITIONS GEN 8 ZAFIRO', '608.40', '1675.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21');
INSERT INTO `precios_lentes` (`id_precio_lente`, `modelo`, `fabricacion`, `material`, `serie`, `tratamiento`, `nombre`, `fotocromatico`, `color_fotocromatico`, `laboratorio`, `nombre_propio`, `nombre_laboratorio`, `precio_compra`, `precio_venta`, `tiempo_espera`, `id_sucursal`, `es_trio`, `estado`, `active`, `created_at`, `updated_at`) VALUES
(261, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS SHAMIR URBAN TRANSITIONS GEN 8 GRIS', '488.40', '1125.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(262, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 SHAMIR URBAN TRANSITIONS GEN 8 GRIS', '558.60', '1300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(263, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE SHAMIR URBAN TRANSITIONS GEN 8 GRIS', '608.40', '1675.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(264, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS SHAMIR URBAN TRANSITIONS GEN 8 MARRON', '488.40', '1125.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(265, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 SHAMIR URBAN TRANSITIONS GEN 8 MARRON', '558.60', '1300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(266, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE SHAMIR URBAN TRANSITIONS GEN 8 MARRON', '608.40', '1675.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(267, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS SHAMIR URBAN TRANSITIONS GEN 8 VERDE', '488.40', '1125.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(268, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 SHAMIR URBAN TRANSITIONS GEN 8 VERDE', '558.60', '1300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(269, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE SHAMIR URBAN TRANSITIONS GEN 8 VERDE', '608.40', '1675.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(270, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS SHAMIR URBAN TRANSITIONS GEN 8 AMATISTA', '488.40', '1125.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(271, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 SHAMIR URBAN TRANSITIONS GEN 8 AMATISTA', '558.60', '1300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(272, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE SHAMIR URBAN TRANSITIONS GEN 8 AMATISTA', '608.40', '1675.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(273, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 ANTI RAYAS TRANSITIONS XTRACTIVE GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS SHAMIR URBAN TRANSITIONS GEN 8 XTRACTIVE GRIS', '468.00', '1080.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(274, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR PREMIUM TRANSITIONS XTRACTIVE GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 SHAMIR URBAN TRANSITIONS GEN 8 XTRACTIVE GRIS', '538.20', '1240.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(275, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO URBAN TOP 180', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO URBAN TOP 180 AR DELUXE TRANSITIONS XTRACTIVE GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE SHAMIR URBAN TRANSITIONS GEN 8 XTRACTIVE GRIS', '588.00', '1355.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(276, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'ANTI RAYAS', 'PROGRESIVO URBAN TOP 180', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL DIGITAL TRIVEX 1.53 PROGRESIVO URBAN TOP 180 ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 ANTI RAYAS SHAMIR URBAN', '340.80', '785.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(277, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR PREMIUM', 'PROGRESIVO URBAN TOP 180', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL DIGITAL TRIVEX 1.53 PROGRESIVO URBAN TOP 180 AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 AR 16 SHAMIR URBAN', '411.00', '950.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(278, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR DELUXE', 'PROGRESIVO URBAN TOP 180', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL DIGITAL TRIVEX 1.53 PROGRESIVO URBAN TOP 180 AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 DEVA BLUE SHAMIR URBAN', '460.80', '1060.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(279, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO SIGNATURE 8K ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS XYLERIS NEO', '468.00', '1080.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(280, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO SIGNATURE 8K AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR NOX XYLERIS NEO', '538.20', '1240.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(281, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO SIGNATURE 8K AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE XYLERIS NEO', '588.00', '1355.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(282, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE BLUE PROTECT 1.67 ANTI RAYAS XYLERIS NEO', '489.60', '1130.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(283, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE BLUE PROTECT 1.67 AR 16 XYLERIS NEO', '559.80', '1290.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(284, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE BLUE PROTECT 1.67 DEVA BLUE XYLERIS NEO', '609.60', '1405.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(285, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 ANTI RAYAS XYLERIS NEO', '504.00', '1160.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(286, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 AR 16 XYLERIS NEO', '574.20', '1325.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(287, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 DEVA BLUE XYLERIS NEO', '624.00', '1440.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(288, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 GRIS', '589.20', '1360.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(289, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO TRANSITIONS GEN 8 GRIS', '659.40', '1520.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(290, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 GRIS', '709.20', '1635.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(291, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 MARRON', '589.20', '1360.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(292, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO TRANSITIONS GEN 8 MARRON', '659.40', '1520.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(293, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 MARRON', '709.20', '1635.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(294, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 VERDE', '589.20', '1360.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(295, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO TRANSITIONS GEN 8 VERDE', '659.40', '1520.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(296, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 VERDE', '709.20', '1635.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(297, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '589.20', '1360.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(298, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '659.40', '1520.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(299, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '709.20', '1635.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(300, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '589.20', '1360.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(301, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '659.40', '1520.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(302, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '709.20', '1635.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(303, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 GRIS', '612.00', '1410.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(304, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 AR 16 XYLERIS NEO TRANSITIONS GEN 8 GRIS', '682.20', '1570.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(305, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 GRIS', '732.00', '1685.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(306, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 MARRON', '612.00', '1410.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(307, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 AR 16 XYLERIS NEO TRANSITIONS GEN 8 MARRON', '682.20', '1570.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(308, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 MARRON', '732.00', '1685.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(309, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 VERDE', '612.00', '1410.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(310, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 AR 16 XYLERIS NEO TRANSITIONS GEN 8 VERDE', '682.20', '1570.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(311, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 VERDE', '732.00', '1685.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(312, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '612.00', '1410.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(313, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 AR 16 XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '682.20', '1570.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(314, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '732.00', '1685.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(315, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '612.00', '1410.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(316, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 AR 16 XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '682.20', '1570.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(317, 'MULTIFOCAL', 'DIGITAL', 'EXTRA FINE 1.67', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL EXTRA FINE 1.67 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.67 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '732.00', '1685.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(318, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 GRIS', '650.40', '1500.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(319, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 AR 16 XYLERIS NEO TRANSITIONS GEN 8 GRIS', '720.60', '1660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(320, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 GRIS', '770.40', '1775.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(321, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 MARRON', '650.40', '1500.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(322, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 AR 16 XYLERIS NEO TRANSITIONS GEN 8 MARRON', '720.60', '1660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(323, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 MARRON', '770.40', '1775.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(324, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 VERDE', '650.40', '1500.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(325, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 AR 16 XYLERIS NEO TRANSITIONS GEN 8 VERDE', '720.60', '1660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(326, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 VERDE', '770.40', '1775.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(327, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '650.40', '1500.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(328, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 AR 16 XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '720.60', '1660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(329, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 ZAFIRO', '770.40', '1775.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(330, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '650.40', '1500.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(331, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 AR 16 XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '720.60', '1660.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(332, 'MULTIFOCAL', 'DIGITAL', 'HYPER FINE 1.74', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL HYPER FINE 1.74 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL ALTO INDICE 1.74 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 AMATISTA', '770.40', '1775.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(333, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 XTRACTIVE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 XTRACTIVE GRIS', '576.00', '1325.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(334, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 XTRACTIVE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO TRANSITIONS GEN 8 XTRACTIVE GRIS', '646.20', '1490.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(335, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 XTRACTIVE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 XTRACTIVE GRIS', '696.00', '1600.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(336, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS TRANSITIONS GEN 8 VANTAGE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO TRANSITIONS GEN 8 VANTAGE GRIS', '624.00', '1440.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(337, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM TRANSITIONS GEN 8 VANTAGE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO TRANSITIONS GEN 8 VANTAGE GRIS', '694.20', '1600.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(338, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE TRANSITIONS GEN 8 VANTAGE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO TRANSITIONS GEN 8 VANTAGE GRIS', '744.00', '1715.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(339, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS POLARIZADO GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO POLARIZADO GRIS', '500.40', '1150.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(340, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM POLARIZADO GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO POLARIZADO GRIS', '570.60', '1315.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(341, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'PHOTO GRAY PHX', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE POLARIZADO GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO POLARIZADO GRIS', '620.40', '1430.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(342, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K ANTI RAYAS POLARIZADO MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS XYLERIS NEO POLARIZADO MARRON', '500.40', '1150.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(343, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR PREMIUM POLARIZADO MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 XYLERIS NEO POLARIZADO MARRON', '570.60', '1315.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(344, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'PHOTO BROWN PB', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO SIGNATURE 8K AR DELUXE POLARIZADO MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE XYLERIS NEO POLARIZADO MARRON', '620.40', '1430.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(345, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'ANTI RAYAS', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL TRIVEX 1.53 PROGRESIVO SIGNATURE 8K ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 ANTI RAYAS XYLERIS NEO', '415.20', '960.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(346, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR PREMIUM', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL TRIVEX 1.53 PROGRESIVO SIGNATURE 8K AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 AR 16 XYLERIS NEO', '485.40', '1120.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(347, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR DELUXE', 'PROGRESIVO SIGNATURE 8K', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL TRIVEX 1.53 PROGRESIVO SIGNATURE 8K AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 DEVA BLUE XYLERIS NEO', '535.20', '1235.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(348, 'OCUPACIONAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'OCUPACIONAL', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'OCUPACIONAL DIGITAL PRIORITY LENS 1.59 BLUE TECH ANTI RAYAS', 'LABORATORIO TRIMAX OCUPACIONAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS WORK SPACE', '187.20', '435.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(349, 'OCUPACIONAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'OCUPACIONAL', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'OCUPACIONAL DIGITAL PRIORITY LENS 1.59 BLUE TECH AR PREMIUM', 'LABORATORIO TRIMAX OCUPACIONAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 WORK SPACE', '257.40', '600.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(350, 'OCUPACIONAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'OCUPACIONAL', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'OCUPACIONAL DIGITAL PRIORITY LENS 1.59 BLUE TECH AR DELUXE', 'LABORATORIO TRIMAX OCUPACIONAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE WORK SPACE', '307.20', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(351, 'OCUPACIONAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'ANTI RAYAS', 'OCUPACIONAL', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'OCUPACIONAL DIGITAL TRIVEX 1.53 ANTI RAYAS', 'LABORATORIO TRIMAX OCUPACIONAL DIGITAL TRIVEX 1.53 ANTI RAYAS WORK SPACE', '204.00', '470.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(352, 'OCUPACIONAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR PREMIUM', 'OCUPACIONAL', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'OCUPACIONAL DIGITAL TRIVEX 1.53 AR PREMIUM', 'LABORATORIO TRIMAX OCUPACIONAL DIGITAL TRIVEX 1.53 AR 16 WORK SPACE', '274.20', '635.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(353, 'OCUPACIONAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR DELUXE', 'OCUPACIONAL', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'OCUPACIONAL DIGITAL TRIVEX 1.53 AR DELUXE', 'LABORATORIO TRIMAX OCUPACIONAL DIGITAL TRIVEX 1.53 DEVA BLUE WORK SPACE', '324.40', '750.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(354, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO DEPORTIVO ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 ANTI RAYAS ATTITUDE III', '565.20', '1300.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(355, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO DEPORTIVO AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 AR 16 ATTITUDE III', '635.40', '1465.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(356, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 PROGRESIVO DEPORTIVO AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 DEVA BLUE ATTITUDE III', '685.20', '1580.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(357, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL TRIVEX 1.53 PROGRESIVO DEPORTIVO ANTI RAYAS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 ANTI RAYAS ATTITUDE III', '528.00', '1215.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(358, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL TRIVEX 1.53 PROGRESIVO DEPORTIVO AR PREMIUM', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 AR 16 ATTITUDE III', '598.20', '1380.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(359, 'MULTIFOCAL', 'DIGITAL', 'TRIVEX 1.53', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL TRIVEX 1.53 PROGRESIVO DEPORTIVO AR DELUXE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL TRIVEX 1.53 DEVA BLUE ATTITUDE III', '648.00', '1495.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(360, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III TRANSITIONS GEN 8 GRIS', '696.00', '1605.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(361, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III TRANSITIONS GEN 8 GRIS', '766.20', '1765.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(362, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE TRANSITIONS GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III TRANSITIONS GEN 8 GRIS', '816.00', '1880.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(363, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III TRANSITIONS GEN 8 MARRON', '696.00', '1605.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(364, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III TRANSITIONS GEN 8 MARRON', '766.20', '1765.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(365, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE TRANSITIONS GEN 8 MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III TRANSITIONS GEN 8 MARRON', '816.00', '1880.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(366, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III TRANSITIONS GEN 8 VERDE', '696.00', '1605.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(367, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III TRANSITIONS GEN 8 VERDE', '766.20', '1765.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(368, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE TRANSITIONS GEN 8 VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III TRANSITIONS GEN 8 VERDE', '816.00', '1880.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(369, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III TRANSITIONS GEN 8 ZAFIRO', '696.00', '1605.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(370, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III TRANSITIONS GEN 8 ZAFIRO', '766.20', '1765.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(371, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'ZAFIRO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE TRANSITIONS GEN 8 ZAFIRO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III TRANSITIONS GEN 8 ZAFIRO', '816.00', '1880.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(372, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III TRANSITIONS GEN 8 AMATISTA', '696.00', '1605.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(373, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III TRANSITIONS GEN 8 AMATISTA', '766.20', '1765.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(374, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8', 'AMATISTA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE TRANSITIONS GEN 8 AMATISTA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III TRANSITIONS GEN 8 AMATISTA', '816.00', '1880.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(375, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS TRANSITIONS GEN 8 XTRACTIVE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III XTRACTIVE GRIS', '679.20', '1565.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21');
INSERT INTO `precios_lentes` (`id_precio_lente`, `modelo`, `fabricacion`, `material`, `serie`, `tratamiento`, `nombre`, `fotocromatico`, `color_fotocromatico`, `laboratorio`, `nombre_propio`, `nombre_laboratorio`, `precio_compra`, `precio_venta`, `tiempo_espera`, `id_sucursal`, `es_trio`, `estado`, `active`, `created_at`, `updated_at`) VALUES
(376, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM TRANSITIONS XTRACTIVE GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III XTRACTIVE GRIS', '749.40', '1725.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(377, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8 XTRACTIVE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE TRANSITIONS XTRACTIVE GEN 8 GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III XTRACTIVE GRIS', '799.20', '1840.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(378, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS TRANSITIONS GEN 8 VANTAGE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III VANTAGE GRIS', '768.00', '1770.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(379, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM TRANSITIONS GEN 8 VANTAGE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III VANTAGE GRIS', '838.20', '1930.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(380, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'TRANSITIONS GEN 8 VANTAGE', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE TRANSITIONS GEN 8 VANTAGE GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III VANTAGE GRIS', '888.00', '2045.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(381, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'POLARIZADO', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS POLARIZADO GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III POLARIZADO GRIS', '669.60', '1545.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(382, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'POLARIZADO', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM POLARIZADO GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III POLARIZADO GRIS', '739.80', '1705.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(383, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'POLARIZADO', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE POLARIZADO GRIS', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III POLARIZADO GRIS', '789.60', '1820.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(384, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'POLARIZADO', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS POLARIZADO MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III POLARIZADO MARRON', '669.60', '1545.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(385, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'POLARIZADO', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM POLARIZADO MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III POLARIZADO MARRON', '739.80', '1705.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(386, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'POLARIZADO', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE POLARIZADO MARRON', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III POLARIZADO MARRON', '789.60', '1820.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(387, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'ROJO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS ESPEJADO POLARIZADO ROJO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III ESPEJADO POLARIZADO ROJO', '686.40', '1580.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(388, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'ROJO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM ESPEJADO POLARIZADO ROJO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III ESPEJADO POLARIZADO ROJO', '756.60', '1745.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(389, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'ROJO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE ESPEJADO POLARIZADO ROJO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III ESPEJADO POLARIZADO ROJO', '806.40', '1855.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(390, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS ESPEJADO POLARIZADO VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III ESPEJADO POLARIZADO VERDE', '686.40', '1580.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(391, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM ESPEJADO POLARIZADO VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III ESPEJADO POLARIZADO VERDE', '756.60', '1745.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(392, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'VERDE', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE ESPEJADO POLARIZADO VERDE', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III ESPEJADO POLARIZADO VERDE', '806.40', '1855.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(393, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'AZUL', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS ESPEJADO POLARIZADO AZUL', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III ESPEJADO POLARIZADO AZUL', '686.40', '1580.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(394, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'AZUL', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM ESPEJADO POLARIZADO AZUL', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III ESPEJADO POLARIZADO AZUL', '756.60', '1745.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(395, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'AZUL', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE ESPEJADO POLARIZADO AZUL', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III ESPEJADO POLARIZADO AZUL', '806.40', '1855.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(396, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'DORADO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS ESPEJADO POLARIZADO DORADO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III ESPEJADO POLARIZADO DORADO', '686.40', '1580.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(397, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'DORADO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM ESPEJADO POLARIZADO DORADO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III ESPEJADO POLARIZADO DORADO', '756.60', '1745.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(398, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'DORADO', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE ESPEJADO POLARIZADO DORADO', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III ESPEJADO POLARIZADO DORADO', '806.40', '1855.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(399, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'ANTI RAYAS', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'VIOLETA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO ANTI RAYAS ESPEJADO POLARIZADO VIOLETA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL ANTI RAYAS ATTITUDE III ESPEJADO POLARIZADO VIOLETA', '686.40', '1580.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(400, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR PREMIUM', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'VIOLETA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR PREMIUM ESPEJADO POLARIZADO VIOLETA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL AR 16 ATTITUDE III ESPEJADO POLARIZADO VIOLETA', '756.60', '1745.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(401, 'MULTIFOCAL', 'DIGITAL', 'PRIORITY LENS 1.59 BLUE TECH', 'N/A', 'AR DELUXE', 'PROGRESIVO DEPORTIVO', 'ESPEJADO POLARIZADO', 'VIOLETA', 'LABORATORIO TRIMAX', 'MULTIFOCAL DIGITAL PRIORITY LENS 1.59 BLUE TECH PROGRESIVO DEPORTIVO AR DELUXE ESPEJADO POLARIZADO VIOLETA', 'LABORATORIO TRIMAX MULTIFOCAL DIGITAL POLICARBONATO 1.59 PROTECCION DE LUZ AZUL DEVA BLUE ATTITUDE III ESPEJADO POLARIZADO VIOLETA', '806.40', '1855.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(402, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'USO MENSUAL', 'COOPER VISION', 'MONOFOCAL LENTE CONTACTO N/A N/A N/A', 'MONOFOCAL LENTE CONTACTO EMFILCON A + UV COOPER VISION CURVA BASE 8.70 MM AVAIRA DIAMETRO 14.20 MM USO MENSUAL', '1141.00', '248.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(403, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'USO MENSUAL', 'COOPER VISION', 'MONOFOCAL LENTE CONTACTO N/A N/A N/A', 'MONOFOCAL LENTE CONTACTO EMFILCON A + UV COOPER VISION CURVA BASE 8.50 MM AVAIRA TORIC DIAMETRO 14.50 MM USO MENSUAL', '1141.00', '420.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(404, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'USO MENSUAL', 'ALCON', 'MONOFOCAL LENTE CONTACTO N/A N/A N/A', 'MONOFOCAL LENTE CONTACTO LOTRAFILCON B ALCON CURVA BASE 8.50 MM AIR OPTIX AQUA DIAMETRO 14.20 MM USO MENSUAL', '1141.00', '250.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(405, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'PRIMERA SERIE', 'N/A', 'N/A', 'N/A', 'USO MENSUAL', 'LABORATORIO TOPSA', 'MONOFOCAL LENTE CONTACTO N/A PRIMERA SERIE N/A', 'MONOFOCAL LENTE CONTACTO HIDROGEL DE SILICONA LABORATORIO TOPSA CURVA BASE 8.50 MM LICRYL TORIC DIAMETRO 14.20 MM USO MENSUAL', '1141.00', '500.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(406, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'SEGUNDA SERIE', 'N/A', 'N/A', 'N/A', 'USO MENSUAL', 'LABORATORIO TOPSA', 'MONOFOCAL LENTE CONTACTO N/A SEGUNDA SERIE N/A', 'MONOFOCAL LENTE CONTACTO HIDROGEL DE SILICONA LABORATORIO TOPSA CURVA BASE 8.50 MM LICRYL TORIC DIAMETRO 14.20 MM USO MENSUAL', '1141.00', '700.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(407, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'TERCERA SERIE', 'N/A', 'N/A', 'N/A', 'USO MENSUAL', 'LABORATORIO TOPSA', 'MONOFOCAL LENTE CONTACTO N/A TERCERA SERIE N/A', 'MONOFOCAL LENTE CONTACTO HIDROGEL DE SILICONA LABORATORIO TOPSA CURVA BASE 8.50 MM LICRYL TORIC DIAMETRO 14.20 MM USO MENSUAL', '1141.00', '980.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(408, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'USO QUINCENAL', 'JOHNSON', 'MONOFOCAL LENTE CONTACTO N/A N/A N/A', 'MONOFOCAL LENTE CONTACTO ETAFILCON A JOHNSON CURVA BASE 8.70 MM ACTIVE 2 DIAMETRO 14.00 MM USO QUINCENAL', '1141.00', '200.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(409, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'USO DIARIO', 'JOHNSON', 'MONOFOCAL LENTE CONTACTO N/A N/A N/A', 'MONOFOCAL LENTE CONTACTO ETAFILCON A JOHNSON CURVA BASE 8.50 MM 1 DAY ACUVE MOIST DIAMETRO 14.20 MM USO DIARIO', '1141.00', '250.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(410, 'MONOFOCAL', 'LENTE CONTACTO', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'USO QUINCENAL', 'JOHNSON', 'MONOFOCAL LENTE CONTACTO N/A N/A N/A', 'MONOFOCAL LENTE CONTACTO ETAFILCON A JOHNSON CURVA BASE 8.40 MM ACUVE OASYS DIAMETRO 14.00 MM USO QUINCENAL', '1141.00', '265.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(411, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'Primera serie', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 BLUE TECH PRIMERA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 AR VIONE', '39.90', '125.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(412, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'Primera serie', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 BLUE TECH PRIMERA SERIE AR DELUXE ', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 BLUE PROTECT HALO AZUL', '50.00', '150.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(413, 'MONOFOCAL', 'CONVENCIONAL', 'Priority Lens NK 1.56 Blue Tech', 'Primera serie', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH PRIMERA SERIE AR PREMIUM (HALO VERDE)', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL RESINA BLUE1.56 (HALO VERDE)', '16.80', '125.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(414, 'MONOFOCAL', 'CONVENCIONAL', 'Priority Lens NK 1.56 Blue Tech', 'Primera serie', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH PRIMERA SERIE AR DELUXE (HALO VERDE)', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL RESINA BLUE 1.56 (HALO VERDE)', '16.80', '150.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(415, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'Segunda serie', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 BLUE TECH SEGUNDA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 AR VIONE', '49.90', '150.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(416, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'Segunda serie', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 BLUE TECH SEGUNDA SERIE AR DELUXE', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 BLUE PROTECT HALO AZUL', '60.00', '170.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(417, 'MONOFOCAL', 'CONVENCIONAL', 'Priority Lens NK 1.56 Blue Tech', 'Segunda serie', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH SEGUNDA SERIE AR PREMIUM (HALO VERDE)', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL RESINA BLUE 1.56 (HALO VERDE)', '33.40', '150.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(418, 'MONOFOCAL', 'CONVENCIONAL', 'Priority Lens NK 1.56 Blue Tech', 'Segunda serie', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH SEGUNDA SERIE AR DELUXE (HALO VERDE)', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL RESINA BLUE 1.56 SEGUNDA SERIE (HALO VERDE)', '33.40', '170.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(419, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'Tercera Serie', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO INOPSA', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 BLUE TECH TERCERA SERIE AR PREMIUM', 'LABORATORIO INOPSA MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 BLUE BLOCK AR VERDE', '75.00', '0.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(420, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 BLUE TECH', 'Tercera Serie', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 BLUE TECH TERCERA SERIE AR DELUXE', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL POLICARBONATO 1.59 INDIGO AR', '140.00', '0.00', 0, 2, 1, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(421, 'MONOFOCAL', 'CONVENCIONAL', 'Priority Lens NK 1.56 Blue Tech', 'Tercera Serie', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO INOPSA', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH TERCERA SERIE AR PREMIUM', 'LABORATORIO INOPSA MONOFOCAL CONVENCIONAL NK 1.56 BLUE BLOCK AR VERDE', '40.00', '0.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(422, 'MONOFOCAL', 'CONVENCIONAL', 'Priority Lens NK 1.56 Blue Tech', 'Tercera Serie', 'AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH TERCERA SERIE AR DELUXE', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL NK 1.56 INDIGO AR', '70.00', '0.00', 0, 2, 1, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(423, 'MONOFOCAL', 'CONVENCIONAL', 'TRIVEX 1.53', 'PRIMERA SERIE', 'ANTI RAYAS', 'TRILOGY', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL TRIVEX NORMA ANZI PRIMERA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL TRILOGY ANTI RAYAS', '115.00', '288.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(424, 'MONOFOCAL', 'CONVENCIONAL', 'TRIVEX 1.53', 'PRIMERA SERIE', 'AR PREMIUM', 'TRILOGY', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL TRIVEX NORMA ANZI PRIMERA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL TRILOGY AR NOX', '140.00', '350.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(425, 'MONOFOCAL', 'CONVENCIONAL', 'TRIVEX 1.53', 'SEGUNDA SERIE', 'ANTI RAYAS', 'TRILOGY', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL TRIVEX NORMA ANZI SEGUNDA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL TRILOGY ANTI RAYAS', '115.00', '288.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(426, 'MONOFOCAL', 'CONVENCIONAL', 'TRIVEX 1.53', 'SEGUNDA SERIE', 'AR PREMIUM', 'TRILOGY', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL TRIVEX NORMA ANZI SEGUNDA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL TRILOGY AR NOX', '140.00', '350.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(427, 'MONOFOCAL', 'CONVENCIONAL', 'TRIVEX 1.53', 'TERCERA SERIE', 'ANTI RAYAS', 'TRILOGY', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL TRIVEX NORMA ANZI TERCERA SERIE ANTI RAYAS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL TRILOGY ANTI RAYAS', '135.00', '338.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(428, 'MONOFOCAL', 'CONVENCIONAL', 'TRIVEX 1.53', 'TERCERA SERIE', 'AR PREMIUM', 'TRILOGY', 'N/A', 'N/A', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL TRIVEX NORMA ANZI TERCERA SERIE AR PREMIUM', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL TRILOGY AR NOX', '153.00', '383.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(429, 'Monofocal', 'Digital', 'POLIMERO 1.60 BLUE TECH', 'n/a', 'ANTI RAYAS', 'Lenti Kids 1.60 Blue Tech', 'n/a', 'n/a', 'Laboratorio Topsa', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 BLUE TECH ANTI RAYAS', 'LABORATORIO TOPSA MONOFOCAL DIGITAL VISUAL KIDS BLUE DEFENSE DURA QUARZ', '140.00', '400.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(430, 'Monofocal', 'Digital', 'POLIMERO 1.60', 'n/a', 'ANTI RAYAS', 'Lenti Kids 1.60 Sunny', 'Polarizado', 'Gris', 'Laboratorio Topsa', 'MONOFOCAL DIGITAL NORMATIVA ANSI Z87.1 1.60 SUNNY GRIS ANTI RAYAS POLIMERO', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN GRIS VISUAL KIDS DQ', '168.00', '450.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(431, 'Monofocal', 'Digital', 'POLIMERO 1.60', 'n/a', 'AR PREMIUM', 'Lenti Kids 1.60 Sunny', 'Polarizado', 'Gris', 'Laboratorio Topsa', 'MONOFOCAL DIGITAL NORMATIVA ANSI Z87.1 1.60 SUNNY GRIS AR PREMIUM POLIMERO', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN GRIS VISUAL KIDS AR 16', '196.00', '490.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(432, 'Monofocal', 'Digital', 'POLIMERO 1.60', 'n/a', 'AR DELUXE', 'Lenti Kids 1.60 Sunny', 'Polarizado', 'Gris', 'Laboratorio Topsa', 'MONOFOCAL DIGITAL NORMATIVA ANSI Z87.1 1.60 SUNNY GRIS AR DELUXE POLIMERO', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN GRIS VISUAL KIDS AR SKY', '265.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(433, 'Monofocal', 'Digital', 'POLIMERO 1.60', 'n/a', 'ANTI RAYAS', 'Lenti Kids 1.60 Sunny', 'Polarizado', 'Marron', 'Laboratorio Topsa', 'MONOFOCAL DIGITAL NORMATIVA ANSI Z87.1 1.60 SUNNY MARRON ANTI RAYAS', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN MARRON VISUAL KIDS SIMPLE', '168.00', '450.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(434, 'Monofocal', 'Digital', 'POLIMERO 1.60', 'n/a', 'AR PREMIUM', 'Lenti Kids 1.60 Sunny', 'Polarizado', 'Marron', 'Laboratorio Topsa', 'MONOFOCAL DIGITAL NORMATIVA ANSI Z87.1 1.60 SUNNY MARRON AR PREMIUM', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN MARRON VISUAL KIDS AR 16', '196.00', '490.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(435, 'Monofocal', 'Digital', 'POLIMERO 1.60', 'n/a', 'AR DELUXE', 'Lenti Kids 1.60 Sunny', 'Polarizado', 'Marron', 'Laboratorio Topsa', 'MONOFOCAL DIGITAL NORMATIVA ANSI Z87.1 1.60 SUNNY MARRON AR DELUXE', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN MARRON VISUAL KIDS AR SKY', '265.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(436, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'Primera Serie', 'AR PREMIUM', 'Express', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL OCUPACIONAL EXPRESS 1.56 PRIMERA SERIE AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL STOCK 1.56 AR NOX', '10.00', '50.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(437, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 SAFETY', 'Primera Serie', 'ANTI RAYAS', 'Safety Lens', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL SAFETY LENS 59 PRIMERA SERIE ANTI RAYAS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 TRIDUREX', '70.00', '150.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(438, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 SAFETY', 'Primera Serie', 'AR PREMIUM', 'Safety Lens', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL SAFETY LENS 59 PRIMERA SERIE AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 AR NOX', '134.20', '275.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(439, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 SAFETY', 'Segunda Serie', 'ANTI RAYAS', 'Safety Lens', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL SAFETY LENS 59 SEGUNDA SERIE ANTI RAYAS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 TRIDUREX', '70.00', '160.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(440, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 SAFETY', 'Segunda Serie', 'AR PREMIUM', 'Safety Lens', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL SAFETY LENS 59 SEGUNDA SERIE AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 AR NOX', '134.20', '285.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(441, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 SAFETY', 'Tercera Serie', 'ANTI RAYAS', 'Safety Lens', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL SAFETY LENS 59 TERCERA SERIE ANTI RAYAS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 TRIDUREX', '70.00', '170.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(442, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 SAFETY', 'Tercera Serie', 'AR PREMIUM', 'Safety Lens', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL SAFETY LENS 59 TERCERA SERIE AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 AR NOX', '134.20', '295.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(443, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'Segunda Serie', 'AR PREMIUM', 'Express', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL OCUPACIONAL EXPRESS 1.56 SEGUNDA SERIE AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL STOCK 1.56 AR NOX', '24.00', '60.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(444, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56', 'Tercera Serie', 'AR PREMIUM', 'Express', 'n/a', 'n/a', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL OCUPACIONAL EXPRESS 1.56 TERCERA SERIE AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL STOCK 1.56 AR NOX', '32.00', '70.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(445, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'Primera Serie', 'AR PREMIUM', 'Express', 'CHROMASOL', 'Gris', 'LABORATORIO INOPS', 'MONOFOCAL CONVENCIONAL OCUPACIONAL EXPRESS 1.49 PRIMERA SERIE AR PREMIUM CHROMASOL GRIS', 'LABORATORIO INOPSA MONOFOCAL CONVENCIONAL 1.49 AR 16 DARK LINE GRIS', '48.00', '140.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(446, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'Primera Serie', 'AR PREMIUM', 'Express', 'CHROMASOL', 'MARRON', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL OCUPACIONAL EXPRESS 1.49 PRIMERA SERIE AR PREMIUM CHROMASOL MARRON', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL 1.49 AR 16 FOTOCROMATICO MARRON', '48.00', '140.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(447, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'Segunda Serie', 'AR PREMIUM', 'Express', 'CHROMASOL', 'Gris', 'LABORATORIO INOPSA', 'MONOFOCAL CONVENCIONAL OCUPACIONAL EXPRESS 1.49 SEGUNDA SERIE AR PREMIUM CHROMASOL GRIS', 'LABORATORIO INOPSA MONOFOCAL CONVENCIONAL 1.49 AR 16 DARK LINE GRIS', '60.00', '220.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(448, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.49', 'Segunda Serie', 'AR PREMIUM', 'Express', 'CHROMASOL', 'MARRON', 'LABORATORIO UNO', 'MONOFOCAL CONVENCIONAL OCUPACIONAL EXPRESS 1.49 SEGUNDA SERIE AR PREMIUM CHROMASOL MARRON', 'LABORATORIO UNO MONOFOCAL CONVENCIONAL 1.49 AR 16 FOTOCROMATICO MARRON', '60.00', '220.00', 0, 2, 0, 0, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(449, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60 BLUE TECH', 'N/A', 'ANTI RAYAS', 'NORMATIVA ANSI Z87.1', 'N/A', 'N/A', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 NORMATIVA ANSI Z87.1 ANTI RAYAS BLUE TECH', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 VISUAL KIDS DQ BLUE TECH', '140.00', '400.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(450, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'ANTI RAYAS', 'NORMATIVA ANSI Z87.1', 'CHROMASOL', 'Gris', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 CHROMASOL GRIS ANTI RAYAS', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN GRIS VISUAL KIDS DQ', '168.00', '450.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(451, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'AR PREMIUM', 'NORMATIVA ANSI Z87.1', 'CHROMASOL', 'Gris', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 CHROMASOL GRIS AR PREMIUM', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN GRIS AR 16 POLICARBONATO', '196.00', '490.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(452, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'AR DELUXE', 'NORMATIVA ANSI Z87.1', 'CHROMASOL', 'Gris', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 CHROMASOL GRIS AR DELUXE', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN GRIS VISUAL KIDS AR SKY', '265.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(453, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'ANTI RAYAS', 'NORMATIVA ANSI Z87.1', 'CHROMASOL', 'Marron', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 CHROMASOL MARRON ANTI RAYAS', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN MARRON VISUAL KIDS DQ', '168.00', '450.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(454, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'AR PREMIUM', 'NORMATIVA ANSI Z87.1', 'CHROMASOL', 'Marron', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 CHROMASOL MARRON AR PREMIUM', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN MARRON VISUAL KIDS AR 16', '196.00', '490.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(455, 'MONOFOCAL', 'DIGITAL', 'POLIMERO 1.60', 'N/A', 'AR DELUXE', 'NORMATIVA ANSI Z87.1', 'CHROMASOL', 'Marron', 'LABORATORIO TOPSA', 'MONOFOCAL DIGITAL 1.60 NORMATIVA ANSI Z87.1 CHROMASOL MARRON AR DELUXE', 'LABORATORIO TOPSA MONOFOCAL DIGITAL 1.60 SUN MARRON VISUAL KIDS AR SKY', '265.00', '665.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(456, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'PRIMERA SERIE', 'AR PREMIUM', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO INOPSA', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH PRIMERA SERIE AR PREMIUM CHROMASOL GRIS', 'LABORATORIO INOPSA MONOFOCAL CONVENCIONAL EVOLUTION GRIS NK 1.56 AR 16 BLUE BLOCK HALO AZUL', '50.00', '240.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(457, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'PRIMERA SERIE', 'AR DELUXE', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH PRIMERA SERIE AR DELUXE CHROMASOL GRIS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 AR ONDAX DIPPING GRIS', '187.00', '470.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(458, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'SEGUNDA SERIE', 'AR PREMIUM', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO INOPSA', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH SEGUNDA SERIE AR PREMIUM CHROMASOL GRIS', 'LABORATORIO INOPSA MONOFOCAL CONVENCIONAL EVOLUTION GRIS NK 1.56 AR 16 BLUE BLOCK HALO AZUL', '70.00', '270.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(459, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'SEGUNDA SERIE', 'AR DELUXE', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH SEGUNDA SERIE AR DELUXE CHROMASOL GRIS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 AR ONDAX DIPPING GRIS', '187.00', '470.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(460, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'TERCERA SERIE', 'AR PREMIUM', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH TERCERA SERIE AR PREMIUM CHROMASOL GRIS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 AR NOX DIPPING GRIS', '157.00', '400.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(461, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS NK 1.56 BLUE TECH', 'TERCERA SERIE', 'AR DELUXE', 'N/A', 'CHROMASOL', 'GRIS', 'LABORATORIO OXO', 'MONOFOCAL CONVENCIONAL PRIORITY LENS NK 1.56 BLUE TECH TERCERA SERIE AR DELUXE CHROMASOL GRIS', 'LABORATORIO OXO MONOFOCAL CONVENCIONAL NK-55 1.56 AR ONDAX DIPPING GRIS', '187.00', '470.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(462, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 6 UND.', 'AIR OPTIX PLUS HYDRAGLYDE (DE -0.50 A -12.00) (DE +0.50 A +8.00)', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. AIR OPTIX PLUS HYDRAGLYDE (DE -0.50 A -12.00) (DE +0.50 A +8.00)  C.B. 8.60 D 14.2', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. AIR OPTIX PLUS HYDRAGLYDE (DE -0.50 A -12.00) (DE +0.50 A +8.00) C.B. 8.60 D 14.2  USO MENSUAL', '141.50', '220.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(463, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 6 UND.', 'AIR OPTIX AQUA (DE +0.50 A +6.00) (DE - 025 A -10.00)', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. AIR OPTIX AQUA (DE +0.50 A +6.00) (DE - 025 A -10.00)  C.B. 8.60 D 14.2', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. AIR OPTIX AQUA (DE +0.50 A +6.00) (DE - 025 A -10.00) C.B. 8.60 D 14.2  USO MENSUAL', '129.00', '200.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(464, 'MULTIFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 6 UND.', 'AIR OPTIX AQUA MULTIFOCAL (DE PLANO A -6.00) (DE +0.25 A +4.00) HASTA ADD 2.50', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'N/A', 'LABORATORIO MOT S.A.', 'MULTIFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. AIR OPTIX AQUA MULTIFOCAL (DE PLANO A -6.00) (DE +0.25 A +4.00) HASTA ADD 2.50  C.B. 8.60 D 14.2', 'LABORATORIO MOT S.A. MULTIFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. AIR OPTIX AQUA MULTIFOCAL (DE PLANO A -6.00) (DE +0.25 A +4.00) HASTA ADD 2.50 C.B. 8.60 D 14.2  USO MENSUAL', '255.00', '490.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(465, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 6 UND.', 'AIR OPTIX AQUA - PARA ASTIGMATISMO (DE +0.50 A +3.00) (DE PLANO A -6.00) CYL (-0.75 A -2.25) EJE (10, 20, 170, 180)', 'C.B. 8.70 D 14.5', 'USO MENSUAL', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. AIR OPTIX AQUA - PARA ASTIGMATISMO (DE +0.50 A +3.00) (DE PLANO A -6.00) CYL (-0.75 A -2.25) EJE (10, 20, 170, 180)  C.B. 8.70 D 14.5', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. AIR OPTIX AQUA - PARA ASTIGMATISMO (DE +0.50 A +3.00) (DE PLANO A -6.00) CYL (-0.75 A -2.25) EJE (10, 20, 170, 180) C.B. 8.70 D 14.5  USO MENSUAL', '229.00', '470.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(466, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 2 UND.', 'AIR OPTIX COLORS (DE PLANO A -4.00)', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'GRIS', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00)  C.B. 8.60 D 14.2 USO MENSUAL GRIS', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00) C.B. 8.60 D 14.2  USO MENSUAL GRIS', '75.00', '160.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(467, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 2 UND.', 'AIR OPTIX COLORS (DE PLANO A -4.00)', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'VERDE', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00)  C.B. 8.60 D 14.2 USO MENSUAL VERDE', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00) C.B. 8.60 D 14.2  USO MENSUAL VERDE', '75.00', '120.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(468, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 2 UND.', 'AIR OPTIX COLORS (DE PLANO A -4.00)', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'HONEY', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00)  C.B. 8.60 D 14.2 USO MENSUAL HONEY', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00) C.B. 8.60 D 14.2  USO MENSUAL HONEY', '75.00', '120.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(469, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 2 UND.', 'AIR OPTIX COLORS (DE PLANO A -4.00)', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'PURE HAZEL', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00)  C.B. 8.60 D 14.2 USO MENSUAL PURE HAZEL', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00) C.B. 8.60 D 14.2  USO MENSUAL PURE HAZEL', '75.00', '120.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(470, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 2 UND.', 'AIR OPTIX COLORS (DE PLANO A -4.00)', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'BROWN', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00)  C.B. 8.60 D 14.2 USO MENSUAL BROWN', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00) C.B. 8.60 D 14.2  USO MENSUAL BROWN', '75.00', '120.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(471, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 2 UND.', 'AIR OPTIX COLORS (DE PLANO A -4.00)', 'C.B. 8.60 D 14.2', 'USO MENSUAL', 'GRIS INTENSO', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00)  C.B. 8.60 D 14.2 USO MENSUAL GRIS INTENSO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 2 UND. AIR OPTIX COLORS (DE PLANO A -4.00) C.B. 8.60 D 14.2  USO MENSUAL GRIS INTENSO', '75.00', '120.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(472, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 30 UND.', 'DAILIES AQUA COMFORT PLUS (DE -0.50 A -6.00)', 'C.B. 8.70 D 14.0', 'USO DIARIO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 30 UND. DAILIES AQUA COMFORT PLUS (DE -0.50 A -6.00)  C.B. 8.70 D 14.0 USO DIARIO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 30 UND. DAILIES AQUA COMFORT PLUS (DE -0.50 A -6.00) C.B. 8.70 D 14.0  USO DIARIO', '97.85', '195.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(473, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)', 'C.B. 8.60 D 14.5', 'USO DIARIO (poner poder)', 'VERDE', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)  C.B. 8.60 D 14.5 USO DIARIO (poner poder) VERDE', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00) C.B. 8.60 D 14.5  USO DIARIO (poner poder)', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(474, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'GRIS', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)  C.B. 8.60 D 14.5 USO DIARIO GRIS', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(475, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'AZUL', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)  C.B. 8.60 D 14.5 USO DIARIO AZUL', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(476, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'PURE HAZEL', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)  C.B. 8.60 D 14.5 USO DIARIO PURE HAZEL', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(477, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'HONEY', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)  C.B. 8.60 D 14.5 USO DIARIO HONEY', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(478, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'MARRON', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00)  C.B. 8.60 D 14.5 USO DIARIO MARRON', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (DE PLANO A -8.00) (DE PLANO A +4.00) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(479, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO (poner poder)', 'VERDE', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO (poner poder) VERDE', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO (poner poder)', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(480, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'GRIS', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO GRIS', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(481, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'AZUL', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO AZUL', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(482, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'PURE HAZEL', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO PURE HAZEL', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(483, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'HONEY', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO HONEY', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(484, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'MARRON', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO MARRON', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(485, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'VERDE ESMERALDA', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO VERDE ESMERALDA', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(486, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'GRIS INTENSO', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO GRIS INTENSO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(487, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'AZUL ZAFIRO', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO AZUL ZAFIRO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21');
INSERT INTO `precios_lentes` (`id_precio_lente`, `modelo`, `fabricacion`, `material`, `serie`, `tratamiento`, `nombre`, `fotocromatico`, `color_fotocromatico`, `laboratorio`, `nombre_propio`, `nombre_laboratorio`, `precio_compra`, `precio_venta`, `tiempo_espera`, `id_sucursal`, `es_trio`, `estado`, `active`, `created_at`, `updated_at`) VALUES
(488, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'TURQUEZA', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO TURQUEZA', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(489, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL', 'CAJA DE 2 UND.', 'FRESHLOOK COLORS BLENDS (SOLO PLANO)', 'C.B. 8.60 D 14.5', 'USO DIARIO', 'AMATISTA', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO)  C.B. 8.60 D 14.5 USO DIARIO AMATISTA', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL CAJA DE 2 UND. FRESHLOOK COLORS BLENDS (SOLO PLANO) C.B. 8.60 D 14.5  USO DIARIO', '64.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(490, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL TORICO ANUAL - PRIMERA SERIE (DE PLANO A +2.00) (DE PLANO A -5.00) CYL HASTA -2.75', 'C.B. 8.60 D 14.8', 'USO DIARIO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL TORICO ANUAL - PRIMERA SERIE (DE PLANO A +2.00) (DE PLANO A -5.00) CYL HASTA -2.75  C.B. 8.60 D 14.8 USO DIARIO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL TORICO ANUAL - PRIMERA SERIE (DE PLANO A +2.00) (DE PLANO A -5.00) CYL HASTA -2.75 C.B. 8.60 D 14.8  USO DIARIO', '98.00', '200.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(491, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL TORICO ANUAL - SEGUNDA SERIE (DE +2.25 A +5.00) (DE -5.25 A -10.00) CYL HASTA -4.00', 'C.B. 8.60 D 14.8', 'USO DIARIO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL TORICO ANUAL - SEGUNDA SERIE (DE +2.25 A +5.00) (DE -5.25 A -10.00) CYL HASTA -4.00  C.B. 8.60 D 14.8 USO DIARIO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL TORICO ANUAL - SEGUNDA SERIE (DE +2.25 A +5.00) (DE -5.25 A -10.00) CYL HASTA -4.00 C.B. 8.60 D 14.8  USO DIARIO', '138.00', '280.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(492, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL TORICO ANUAL - TERCERA SERIE (DE +5.25 A +20.00) (DE -10.25 A -20.00) CYL HASTA -8.00', 'C.B. 8.60 D 14.8', 'USO DIARIO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL TORICO ANUAL - TERCERA SERIE (DE +5.25 A +20.00) (DE -10.25 A -20.00) CYL HASTA -8.00  C.B. 8.60 D 14.8 USO DIARIO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL TORICO ANUAL - TERCERA SERIE (DE +5.25 A +20.00) (DE -10.25 A -20.00) CYL HASTA -8.00 C.B. 8.60 D 14.8  USO DIARIO', '266.00', '525.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(493, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL 55 XL ANUAL (DE PLANO A - 10.00)', 'C.B. 8.60 D 15', 'USO DIARIO PROLONGADO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55 XL ANUAL (DE PLANO A - 10.00)  C.B. 8.60 D 15 USO DIARIO PROLONGADO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55 XL ANUAL (DE PLANO A - 10.00) C.B. 8.60 D 15  USO DIARIO PROLONGADO', '36.00', '80.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(494, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL 55 XL ANUAL (DE -10.25 A -15.00)', 'C.B. 8.60 D 15', 'USO DIARIO PROLONGADO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55 XL ANUAL (DE -10.25 A -15.00)  C.B. 8.60 D 15 USO DIARIO PROLONGADO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55 XL ANUAL (DE -10.25 A -15.00) C.B. 8.60 D 15  USO DIARIO PROLONGADO', '51.00', '110.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(495, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL 55 XL ANUAL (DE -15.50 A -20.00)', 'C.B. 8.60 D 15', 'USO DIARIO PROLONGADO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55 XL ANUAL (DE -15.50 A -20.00)  C.B. 8.60 D 15 USO DIARIO PROLONGADO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55 XL ANUAL (DE -15.50 A -20.00) C.B. 8.60 D 15  USO DIARIO PROLONGADO', '69.00', '145.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(496, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL 55XL ANUAL (DE +0.25 A +6.00)', 'C.B. 8.60 D 15', 'USO DIARIO PROLONGADO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55XL ANUAL (DE +0.25 A +6.00)  C.B. 8.60 D 15 USO DIARIO PROLONGADO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55XL ANUAL (DE +0.25 A +6.00) C.B. 8.60 D 15  USO DIARIO PROLONGADO', '44.00', '100.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(497, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL 55XL ANUAL (DE +6.50 A +15.00)', 'C.B. 8.60 D 15', 'USO DIARIO PROLONGADO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55XL ANUAL (DE +6.50 A +15.00)  C.B. 8.60 D 15 USO DIARIO PROLONGADO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55XL ANUAL (DE +6.50 A +15.00) C.B. 8.60 D 15  USO DIARIO PROLONGADO', '51.00', '110.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(498, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL 55XL ANUAL (DE +15.50 A +20.00)', 'C.B. 8.60 D 15', 'USO DIARIO PROLONGADO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55XL ANUAL (DE +15.50 A +20.00)  C.B. 8.60 D 15 USO DIARIO PROLONGADO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL 55XL ANUAL (DE +15.50 A +20.00) C.B. 8.60 D 15  USO DIARIO PROLONGADO', '69.00', '145.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(499, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'UND.', 'LICRYL ESTETICO (PUPILA NEGRA)', 'C.B. 8.60 D 14.8', 'USO DIARIO', 'N/A', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL ESTETICO (PUPILA NEGRA)  C.B. 8.60 D 14.8 USO DIARIO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA UND. LICRYL ESTETICO (PUPILA NEGRA) C.B. 8.60 D 14.8  USO DIARIO', '200.00', '400.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(500, 'MONOFOCAL', 'LENTE DE CONTACTO', 'FLUORCRYSTAL U.V.', 'UND.', 'GAS PERMEABLE DK:60', 'POR DEFINIR', 'USO DIARIO', 'CELESTE CLARO', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO FLUORCRYSTAL U.V. UND. GAS PERMEABLE DK:60 USO DIARIO CELESTE CLARO', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO FLUORCRYSTAL U.V. UND. GAS PERMEABLE DK:60 USO DIARIO CELESTE CLARO', '69.00', '150.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(501, 'MONOFOCAL', 'LENTE DE CONTACTO', 'SPV', 'UND.', 'GAS PERMEABLE DK:38', 'POR DEFINIR', 'USO DIARIO', 'VIOLETA', 'LABORATORIO MOT S.A.', 'MONOFOCAL LENTE DE CONTACTO SPV UND. GAS PERMEABLE DK:38 USO DIARIO VIOLETA', 'LABORATORIO MOT S.A. MONOFOCAL LENTE DE CONTACTO SPV UND. GAS PERMEABLE DK:38 USO DIARIO VIOLETA', '130.00', '270.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(502, 'MONOFOCAL', 'LENTE DE CONTACTO', 'HIDROGEL DE SILICONA', 'CAJA DE 6 UND.', 'ACUVUE OASYS WITH HYDRACLEAR PLUS (DE -0.50 A -12.00) (DE +0.50 A +8.00)', 'C.B. 8.40 D 14.0', 'USO DIARIO', 'N/A', 'LABORATORIO LABOFTA', 'MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. ACUVUE OASYS WITH HYDRACLEAR PLUS (DE -0.50 A -12.00) (DE +0.50 A +8.00) USO DIARIO', 'LABORATORIO LABOFTA MONOFOCAL LENTE DE CONTACTO HIDROGEL DE SILICONA CAJA DE 6 UND. ACUVUE OASYS WITH HYDRACLEAR PLUS (DE -0.50 A -12.00) (DE +0.50 A +8.00) USO DIARIO', '120.00', '240.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(503, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 AIRWEAR', 'PRIMERA Y SEGUNDA SERIE', 'ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AIRWEAR PRIMERA Y SEGUNDA SERIE ANTI RAYAS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 TRIDUREX', '70.00', '180.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(504, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 AIRWEAR', 'PRIMERA Y SEGUNDA SERIE', 'AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AIRWEAR PRIMERA Y SEGUNDA SERIE AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 AR NOX', '140.00', '350.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(505, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 AIRWEAR', 'PRIMERA Y SEGUNDA SERIE', 'BLUE TECH AR DELUXE', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AIRWEAR PRIMERA Y SEGUNDA SERIE BLUE TECH AR DELUXE ', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 DEBABLUE BLUE PROTECT', '210.00', '530.00', 0, 2, 1, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(506, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 AIRWEAR', 'PRIMERA Y SEGUNDA SERIE', 'BLUE TECH ANTI RAYAS', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AIRWEAR PRIMERA Y SEGUNDA SERIE BLUE TECH ANTI RAYAS', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 TRIDUREX BLUE PROTECT', '90.00', '230.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(507, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 AIRWEAR', 'PRIMERA Y SEGUNDA SERIE', 'BLUE TECH AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 AIRWEAR PRIMERA Y SEGUNDA SERIE BLUE TECH AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR 1.59 BLUE PROTECT AR NOX', '160.00', '400.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(508, 'MONOFOCAL', 'CONVENCIONAL', 'PRIORITY LENS 1.59 AIRWEAR CRIZAL', 'PRIMERA SERIE', 'BLUE TECH AR PREMIUM', 'N/A', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL CONVENCIONAL PRIORITY LENS 1.59 CRIZAL PRIMERA SERIE BLUE TECH AR PREMIUM', 'LABORATORIO TRIMAX MONOFOCAL CONVENCIONAL AIRWEAR CRIZAL SAPPHIRE ESSENTIAL BLUE PROTECT', '186.00', '470.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(509, 'MONOFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87', 'MONOFOCAL DIGITAL AIRWEAR 1.59 ANTI RAYAS', '110.00', '196.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(510, 'MONOFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87 TRANSITIONS GEN 8 MARRON', 'MONOFOCAL DIGITAL AIRWEAR 1.59 ANTI RAYAS TRANSITIONS GEN 8 MARRON', '294.00', '505.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(511, 'MONOFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MONOFOCAL DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87 TRANSITIONS GEN GRIS', 'MONOFOCAL DIGITAL AIRWEAR 1.59 ANTI RAYAS TRANSITIONS GEN 8 GRIS', '294.00', '505.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(512, 'BIFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'BIFOCAL DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87', 'SHAMIR DUO AIRWEAR 1.59 ANTI RAYAS', '180.00', '315.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(513, 'BIFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'BIFOCAL DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87 TRANSITIONS GEN 8 MARRON', 'SHAMIR DUO AIRWEAR 1.59 ANTI RAYAS TRANSITIONS GEN 8 MARRON', '407.20', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(514, 'BIFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'BIFOCAL DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87 TRANSITIONS GEN 8 GRIS', 'SHAMIR DUO AIRWEAR 1.59 ANTI RAYAS TRANSITIONS GEN 8 GRIS', '407.20', '710.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(515, 'MULTIFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'N/A', 'N/A', 'LABORATORIO TRIMAX', 'MULTIFOCAL  DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87', 'ESSILOR IDEAL AIRWEAR 1.59 ANTI RAYAS', '294.00', '510.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(516, 'MULTIFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'TRANSITIONS GEN 8', 'MARRON', 'LABORATORIO TRIMAX', 'MULTIFOCAL  DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87 TRANSITIONS GEN 8 MARRON', 'ESSILOR IDEAL AIRWEAR 1.59 ANTI RAYAS TRANSITIONS GEN 8 MARRON', '476.30', '825.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21'),
(517, 'MULTIFOCAL', 'DIGITAL', 'AIRWEAR 1.59', 'N/A', 'ANTI RAYAS', 'SAFETY AIRWEAR 1.59 ANSI Z87', 'TRANSITIONS GEN 8', 'GRIS', 'LABORATORIO TRIMAX', 'MULTIFOCAL  DIGITAL ANTI RAYAS SAFETY AIRWEAR 1.59 ANSI Z87 TRANSITIONS GEN 8 GRIS', 'ESSILOR IDEAL AIRWEAR 1.59 ANTI RAYAS TRANSITIONS GEN 8 GRIS', '476.30', '825.00', 0, 2, 0, 1, 1, '2022-09-07 22:36:21', '2022-09-07 22:36:21');

-- --------------------------------------------------------

--
-- Table structure for table `productos`
--

CREATE TABLE `productos` (
  `id_producto` int UNSIGNED NOT NULL,
  `nombre_producto` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_producto` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `id_marca` int UNSIGNED DEFAULT NULL,
  `id_categoria` int UNSIGNED DEFAULT NULL,
  `codigo_varilla` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_sunat` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rango` tinyint(1) DEFAULT NULL COMMENT '1=Ninguno, 2=Económica, 3=Intermedia, 4=Cara',
  `id_material` int UNSIGNED DEFAULT NULL,
  `id_tipo_aro` int UNSIGNED DEFAULT NULL,
  `id_forma_montura` int UNSIGNED DEFAULT NULL,
  `tipo_rostro` json DEFAULT NULL,
  `genero` tinyint DEFAULT NULL COMMENT '1=varon, 2=dama, 3=niño, 4=niña, 5=unisex',
  `adicionales` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `descripcion` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `producto_reto` tinyint DEFAULT '0' COMMENT '1=SI 0=NO',
  `sobrelentes` tinyint DEFAULT '0' COMMENT '1=SI, 0=NO',
  `liquido` tinyint(1) DEFAULT '0' COMMENT 'SI=1, NO=0',
  `diagonal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `puente` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `varilla` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_afectacion_igv` int UNSIGNED DEFAULT NULL,
  `precio_compra` decimal(11,2) DEFAULT NULL,
  `precio_venta` decimal(11,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre_producto`, `codigo_producto`, `id_sucursal`, `id_marca`, `id_categoria`, `codigo_varilla`, `codigo_sunat`, `rango`, `id_material`, `id_tipo_aro`, `id_forma_montura`, `tipo_rostro`, `genero`, `adicionales`, `descripcion`, `producto_reto`, `sobrelentes`, `liquido`, `diagonal`, `puente`, `varilla`, `cod_afectacion_igv`, `precio_compra`, `precio_venta`, `stock`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'GUCCI A001-02GUC24', 'A001-02GUC24', 2, 1, 1, '79798789', '89798', 7, NULL, NULL, NULL, '[\"N/A\"]', 6, 'N/A', NULL, 0, 0, 0, '1', '1', '1', 10, '8888.00', '887.00', 987, 1, '2024-02-23 16:56:33', '2024-02-26 15:42:47');

-- --------------------------------------------------------

--
-- Table structure for table `productos_categorias`
--

CREATE TABLE `productos_categorias` (
  `id_producto_categoria` int UNSIGNED NOT NULL,
  `nombre_categoria` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `sunglasses` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productos_categorias`
--

INSERT INTO `productos_categorias` (`id_producto_categoria`, `nombre_categoria`, `estado`, `sunglasses`) VALUES
(1, 'AVIADOR', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `productos_forma_montura`
--

CREATE TABLE `productos_forma_montura` (
  `id_forma_montura` int UNSIGNED NOT NULL,
  `forma_montura` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rostros` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productos_forma_montura`
--

INSERT INTO `productos_forma_montura` (`id_forma_montura`, `forma_montura`, `rostros`, `estado`) VALUES
(1, 'AVIADOR', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `productos_marcas`
--

CREATE TABLE `productos_marcas` (
  `id_marca_producto` int UNSIGNED NOT NULL,
  `marca_producto` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `sincronizar` tinyint DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productos_marcas`
--

INSERT INTO `productos_marcas` (`id_marca_producto`, `marca_producto`, `estado`, `created_at`, `updated_at`, `sincronizar`) VALUES
(1, 'GUCCI', 1, '2024-02-23 16:55:09', '2024-02-23 16:55:09', 1);

-- --------------------------------------------------------

--
-- Table structure for table `productos_material`
--

CREATE TABLE `productos_material` (
  `id_material` int UNSIGNED NOT NULL,
  `nombre_material` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productos_material`
--

INSERT INTO `productos_material` (`id_material`, `nombre_material`, `estado`) VALUES
(1, 'ACETATO', 1);

-- --------------------------------------------------------

--
-- Table structure for table `productos_tipo_aro`
--

CREATE TABLE `productos_tipo_aro` (
  `id_tipo_aro` int UNSIGNED NOT NULL,
  `tipo_aro` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productos_tipo_aro`
--

INSERT INTO `productos_tipo_aro` (`id_tipo_aro`, `tipo_aro`, `estado`) VALUES
(1, 'REDONDO', 1);

-- --------------------------------------------------------

--
-- Table structure for table `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int UNSIGNED NOT NULL,
  `id_tipo_doc` bigint UNSIGNED NOT NULL,
  `nombre` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_doc` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encargado` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_cuenta` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cci_bancario` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_proveedor` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` int DEFAULT '1',
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `active` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `title`, `description`, `status`, `active`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'web', 'Superadmin', NULL, 1, 1, NULL, '2023-07-13 12:30:04');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1);

-- --------------------------------------------------------

--
-- Table structure for table `rubros_trabajo`
--

CREATE TABLE `rubros_trabajo` (
  `id_rubro_trabajo` int UNSIGNED NOT NULL,
  `rubro_trabajo` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int UNSIGNED NOT NULL,
  `nombre_servicio` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_compra` decimal(11,2) DEFAULT NULL,
  `precio_venta` decimal(11,2) DEFAULT NULL,
  `cod_afectacion_igv` int UNSIGNED DEFAULT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_productos_sucursales`
--

CREATE TABLE `stock_productos_sucursales` (
  `id` bigint UNSIGNED NOT NULL,
  `id_producto` bigint UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED NOT NULL,
  `ubicacion` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=Almacen,\r\n2=Tienda',
  `stock` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `stock_productos_sucursales`
--

INSERT INTO `stock_productos_sucursales` (`id`, `id_producto`, `id_sucursal`, `ubicacion`, `stock`) VALUES
(1, 1, 2, 1, 990),
(2, 1, 2, 2, -3);

-- --------------------------------------------------------

--
-- Table structure for table `sucursales`
--

CREATE TABLE `sucursales` (
  `id_sucursal` int UNSIGNED NOT NULL,
  `nombre_sucursal` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_sucursal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nro_ruc` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_domicilio_fiscal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `direccion_fiscal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `direccion_comercial` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `departamento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `provincia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `distrito` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `direccion_web` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `nro_cuenta_bancario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `cci_bancario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `telefono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `url_api` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_api` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_logo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `mantenimiento_productos` tinyint DEFAULT NULL,
  `mantenimiento_lentes` tinyint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sucursales`
--

INSERT INTO `sucursales` (`id_sucursal`, `nombre_sucursal`, `codigo_sucursal`, `nro_ruc`, `razon_social`, `cod_domicilio_fiscal`, `direccion_fiscal`, `direccion_comercial`, `email`, `departamento`, `provincia`, `distrito`, `direccion_web`, `nro_cuenta_bancario`, `cci_bancario`, `telefono`, `url_api`, `token_api`, `theme`, `url_logo`, `status`, `mantenimiento_productos`, `mantenimiento_lentes`, `created_at`, `updated_at`) VALUES
(2, 'GAMESA', 'G', '20600628837', 'GUILLEN TAMAYO', '-', '-', '-', '-', '-', '-', 'AREQUIPA', '-', '-', '-', '-', 'https://demo.consultoriadigitalperu.net/', 'rb0vSXqIo2L0x8uAFDm2gAfxgnljeVZrdAYijswos1tDpEutAs', 'dark', 'image', 1, 0, 0, NULL, '2023-07-25 15:24:38'),
(4, 'YANAHUARA', 'Y', '-', 'GUILLEN TAMAYO', '-', '-', '-', '-', '-', '-', 'YANAHUARA', '-', '-', '-', '-', '-', '-', NULL, '-', 1, NULL, NULL, '2023-07-14 13:35:29', '2023-07-25 15:24:44'),
(5, 'GAFITAS', 'I', '-', 'GUILLEN TAMAYO', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', NULL, '-', 1, NULL, NULL, '2023-07-14 13:44:27', '2023-07-25 15:24:50');

-- --------------------------------------------------------

--
-- Table structure for table `tipos_comprobantes`
--

CREATE TABLE `tipos_comprobantes` (
  `id_tipo_comprobantes` int UNSIGNED NOT NULL,
  `codigo_sunat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_tipo_documento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tipos_comprobantes`
--

INSERT INTO `tipos_comprobantes` (`id_tipo_comprobantes`, `codigo_sunat`, `nombre_tipo_documento`) VALUES
(1, '01', 'FACTURA'),
(2, '03', 'BOLETA'),
(3, NULL, 'NOTA DE VENTA'),
(4, NULL, 'COTIZACIÓN'),
(5, NULL, 'GUÍA DE REMISIÓN'),
(6, '07', 'NOTA DE CREDITO'),
(7, '08', 'NOTA DE DÉBITO'),
(8, NULL, 'COMPRAS');

-- --------------------------------------------------------

--
-- Table structure for table `tipos_documentos`
--

CREATE TABLE `tipos_documentos` (
  `id_tipo_documento` int UNSIGNED NOT NULL,
  `codigo_sunat` int DEFAULT NULL,
  `nombre_tipo_documento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tipos_documentos`
--

INSERT INTO `tipos_documentos` (`id_tipo_documento`, `codigo_sunat`, `nombre_tipo_documento`) VALUES
(1, 1, 'DNI'),
(2, 6, 'RUC'),
(3, 7, 'PASAPORTE'),
(4, 4, 'CARNET DE EXTRANJERÍA');

-- --------------------------------------------------------

--
-- Table structure for table `tipos_nota`
--

CREATE TABLE `tipos_nota` (
  `id_tipo_nota` int UNSIGNED NOT NULL,
  `codigo_sunat` varchar(10) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `id_tipo_comprobantes` int UNSIGNED NOT NULL COMMENT '6 => NOTA CRÉDITO, 7=> NOTA DEBÍTO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `tipos_nota`
--

INSERT INTO `tipos_nota` (`id_tipo_nota`, `codigo_sunat`, `descripcion`, `id_tipo_comprobantes`) VALUES
(1, '01', 'Anulación de la operación', 6),
(2, '02', 'Anulación por error en el RUC', 6),
(3, '03', 'Corrección por error en la descripción', 6),
(4, '04', 'Descuento global', 6),
(5, '05', 'Descuento por ítem', 6),
(6, '06', 'Devolución total', 6),
(7, '07', 'Devolución por item', 6),
(8, '08', 'Bonificación', 6),
(9, '09', 'Disminución en el valor', 6),
(10, '10', 'Otros conceptos', 6),
(11, '11', 'Ajustes de operaciones de exportación', 6),
(12, '12', 'Ajustes afectos al IVAP', 6),
(13, '01', 'Intereses por mora', 7),
(14, '02', 'Aumento en el valor', 7),
(15, '03', 'Penalidades/otros conceptos', 7),
(16, '10', 'Ajustes de operaciones de exportación', 7),
(17, '11', 'Ajustes afetos al IVAP', 7);

-- --------------------------------------------------------

--
-- Table structure for table `traslado_productos_sucursales`
--

CREATE TABLE `traslado_productos_sucursales` (
  `id` bigint UNSIGNED NOT NULL,
  `id_sucursal_origen` int UNSIGNED NOT NULL,
  `id_sucursal_destino` int UNSIGNED NOT NULL,
  `id_producto` int UNSIGNED NOT NULL,
  `cantidad` int DEFAULT NULL,
  `fecha_traslado` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `traslado_productos_ubicacion`
--

CREATE TABLE `traslado_productos_ubicacion` (
  `id` bigint UNSIGNED NOT NULL,
  `ubicacion_origen` tinyint(1) NOT NULL COMMENT 'almacen=1, tienda=2',
  `ubicacion_destino` tinyint(1) NOT NULL COMMENT 'almacen=1, tienda=2',
  `id_producto` int UNSIGNED NOT NULL,
  `cantidad` int DEFAULT NULL,
  `fecha_traslado` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ubigeo_departamentos`
--

CREATE TABLE `ubigeo_departamentos` (
  `id_departamento` int UNSIGNED NOT NULL,
  `nombre_departamento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ubigeo_departamentos`
--

INSERT INTO `ubigeo_departamentos` (`id_departamento`, `nombre_departamento`) VALUES
(1, 'Amazonas'),
(2, 'Áncash'),
(3, 'Apurímac'),
(4, 'Arequipa'),
(5, 'Ayacucho'),
(6, 'Cajamarca'),
(7, 'Callao'),
(8, 'Cusco'),
(9, 'Huancavelica'),
(10, 'Huánuco'),
(11, 'Ica'),
(12, 'Junín'),
(13, 'La Libertad'),
(14, 'Lambayeque'),
(15, 'Lima'),
(16, 'Loreto'),
(17, 'Madre de Dios'),
(18, 'Moquegua'),
(19, 'Pasco'),
(20, 'Piura'),
(21, 'Puno'),
(22, 'San Martín'),
(23, 'Tacna'),
(24, 'Tumbes'),
(25, 'Ucayali');

-- --------------------------------------------------------

--
-- Table structure for table `ubigeo_distritos`
--

CREATE TABLE `ubigeo_distritos` (
  `id_distrito` int UNSIGNED NOT NULL,
  `nombre_distrito` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_provincia` int UNSIGNED DEFAULT NULL,
  `id_departamento` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ubigeo_distritos`
--

INSERT INTO `ubigeo_distritos` (`id_distrito`, `nombre_distrito`, `id_provincia`, `id_departamento`) VALUES
(10101, 'Chachapoyas', 101, 1),
(10102, 'Asunción', 101, 1),
(10103, 'Balsas', 101, 1),
(10104, 'Cheto', 101, 1),
(10105, 'Chiliquin', 101, 1),
(10106, 'Chuquibamba', 101, 1),
(10107, 'Granada', 101, 1),
(10108, 'Huancas', 101, 1),
(10109, 'La Jalca', 101, 1),
(10110, 'Leimebamba', 101, 1),
(10111, 'Levanto', 101, 1),
(10112, 'Magdalena', 101, 1),
(10113, 'Mariscal Castilla', 101, 1),
(10114, 'Molinopampa', 101, 1),
(10115, 'Montevideo', 101, 1),
(10116, 'Olleros', 101, 1),
(10117, 'Quinjalca', 101, 1),
(10118, 'San Francisco de Daguas', 101, 1),
(10119, 'San Isidro de Maino', 101, 1),
(10120, 'Soloco', 101, 1),
(10121, 'Sonche', 101, 1),
(10201, 'Bagua', 102, 1),
(10202, 'Aramango', 102, 1),
(10203, 'Copallin', 102, 1),
(10204, 'El Parco', 102, 1),
(10205, 'Imaza', 102, 1),
(10206, 'La Peca', 102, 1),
(10301, 'Jumbilla', 103, 1),
(10302, 'Chisquilla', 103, 1),
(10303, 'Churuja', 103, 1),
(10304, 'Corosha', 103, 1),
(10305, 'Cuispes', 103, 1),
(10306, 'Florida', 103, 1),
(10307, 'Jazan', 103, 1),
(10308, 'Recta', 103, 1),
(10309, 'San Carlos', 103, 1),
(10310, 'Shipasbamba', 103, 1),
(10311, 'Valera', 103, 1),
(10312, 'Yambrasbamba', 103, 1),
(10401, 'Nieva', 104, 1),
(10402, 'El Cenepa', 104, 1),
(10403, 'Río Santiago', 104, 1),
(10501, 'Lamud', 105, 1),
(10502, 'Camporredondo', 105, 1),
(10503, 'Cocabamba', 105, 1),
(10504, 'Colcamar', 105, 1),
(10505, 'Conila', 105, 1),
(10506, 'Inguilpata', 105, 1),
(10507, 'Longuita', 105, 1),
(10508, 'Lonya Chico', 105, 1),
(10509, 'Luya', 105, 1),
(10510, 'Luya Viejo', 105, 1),
(10511, 'María', 105, 1),
(10512, 'Ocalli', 105, 1),
(10513, 'Ocumal', 105, 1),
(10514, 'Pisuquia', 105, 1),
(10515, 'Providencia', 105, 1),
(10516, 'San Cristóbal', 105, 1),
(10517, 'San Francisco de Yeso', 105, 1),
(10518, 'San Jerónimo', 105, 1),
(10519, 'San Juan de Lopecancha', 105, 1),
(10520, 'Santa Catalina', 105, 1),
(10521, 'Santo Tomas', 105, 1),
(10522, 'Tingo', 105, 1),
(10523, 'Trita', 105, 1),
(10601, 'San Nicolás', 106, 1),
(10602, 'Chirimoto', 106, 1),
(10603, 'Cochamal', 106, 1),
(10604, 'Huambo', 106, 1),
(10605, 'Limabamba', 106, 1),
(10606, 'Longar', 106, 1),
(10607, 'Mariscal Benavides', 106, 1),
(10608, 'Milpuc', 106, 1),
(10609, 'Omia', 106, 1),
(10610, 'Santa Rosa', 106, 1),
(10611, 'Totora', 106, 1),
(10612, 'Vista Alegre', 106, 1),
(10701, 'Bagua Grande', 107, 1),
(10702, 'Cajaruro', 107, 1),
(10703, 'Cumba', 107, 1),
(10704, 'El Milagro', 107, 1),
(10705, 'Jamalca', 107, 1),
(10706, 'Lonya Grande', 107, 1),
(10707, 'Yamon', 107, 1),
(20101, 'Huaraz', 201, 2),
(20102, 'Cochabamba', 201, 2),
(20103, 'Colcabamba', 201, 2),
(20104, 'Huanchay', 201, 2),
(20105, 'Independencia', 201, 2),
(20106, 'Jangas', 201, 2),
(20107, 'La Libertad', 201, 2),
(20108, 'Olleros', 201, 2),
(20109, 'Pampas Grande', 201, 2),
(20110, 'Pariacoto', 201, 2),
(20111, 'Pira', 201, 2),
(20112, 'Tarica', 201, 2),
(20201, 'Aija', 202, 2),
(20202, 'Coris', 202, 2),
(20203, 'Huacllan', 202, 2),
(20204, 'La Merced', 202, 2),
(20205, 'Succha', 202, 2),
(20301, 'Llamellin', 203, 2),
(20302, 'Aczo', 203, 2),
(20303, 'Chaccho', 203, 2),
(20304, 'Chingas', 203, 2),
(20305, 'Mirgas', 203, 2),
(20306, 'San Juan de Rontoy', 203, 2),
(20401, 'Chacas', 204, 2),
(20402, 'Acochaca', 204, 2),
(20501, 'Chiquian', 205, 2),
(20502, 'Abelardo Pardo Lezameta', 205, 2),
(20503, 'Antonio Raymondi', 205, 2),
(20504, 'Aquia', 205, 2),
(20505, 'Cajacay', 205, 2),
(20506, 'Canis', 205, 2),
(20507, 'Colquioc', 205, 2),
(20508, 'Huallanca', 205, 2),
(20509, 'Huasta', 205, 2),
(20510, 'Huayllacayan', 205, 2),
(20511, 'La Primavera', 205, 2),
(20512, 'Mangas', 205, 2),
(20513, 'Pacllon', 205, 2),
(20514, 'San Miguel de Corpanqui', 205, 2),
(20515, 'Ticllos', 205, 2),
(20601, 'Carhuaz', 206, 2),
(20602, 'Acopampa', 206, 2),
(20603, 'Amashca', 206, 2),
(20604, 'Anta', 206, 2),
(20605, 'Ataquero', 206, 2),
(20606, 'Marcara', 206, 2),
(20607, 'Pariahuanca', 206, 2),
(20608, 'San Miguel de Aco', 206, 2),
(20609, 'Shilla', 206, 2),
(20610, 'Tinco', 206, 2),
(20611, 'Yungar', 206, 2),
(20701, 'San Luis', 207, 2),
(20702, 'San Nicolás', 207, 2),
(20703, 'Yauya', 207, 2),
(20801, 'Casma', 208, 2),
(20802, 'Buena Vista Alta', 208, 2),
(20803, 'Comandante Noel', 208, 2),
(20804, 'Yautan', 208, 2),
(20901, 'Corongo', 209, 2),
(20902, 'Aco', 209, 2),
(20903, 'Bambas', 209, 2),
(20904, 'Cusca', 209, 2),
(20905, 'La Pampa', 209, 2),
(20906, 'Yanac', 209, 2),
(20907, 'Yupan', 209, 2),
(21001, 'Huari', 210, 2),
(21002, 'Anra', 210, 2),
(21003, 'Cajay', 210, 2),
(21004, 'Chavin de Huantar', 210, 2),
(21005, 'Huacachi', 210, 2),
(21006, 'Huacchis', 210, 2),
(21007, 'Huachis', 210, 2),
(21008, 'Huantar', 210, 2),
(21009, 'Masin', 210, 2),
(21010, 'Paucas', 210, 2),
(21011, 'Ponto', 210, 2),
(21012, 'Rahuapampa', 210, 2),
(21013, 'Rapayan', 210, 2),
(21014, 'San Marcos', 210, 2),
(21015, 'San Pedro de Chana', 210, 2),
(21016, 'Uco', 210, 2),
(21101, 'Huarmey', 211, 2),
(21102, 'Cochapeti', 211, 2),
(21103, 'Culebras', 211, 2),
(21104, 'Huayan', 211, 2),
(21105, 'Malvas', 211, 2),
(21201, 'Caraz', 212, 2),
(21202, 'Huallanca', 212, 2),
(21203, 'Huata', 212, 2),
(21204, 'Huaylas', 212, 2),
(21205, 'Mato', 212, 2),
(21206, 'Pamparomas', 212, 2),
(21207, 'Pueblo Libre', 212, 2),
(21208, 'Santa Cruz', 212, 2),
(21209, 'Santo Toribio', 212, 2),
(21210, 'Yuracmarca', 212, 2),
(21301, 'Piscobamba', 213, 2),
(21302, 'Casca', 213, 2),
(21303, 'Eleazar Guzmán Barron', 213, 2),
(21304, 'Fidel Olivas Escudero', 213, 2),
(21305, 'Llama', 213, 2),
(21306, 'Llumpa', 213, 2),
(21307, 'Lucma', 213, 2),
(21308, 'Musga', 213, 2),
(21401, 'Ocros', 214, 2),
(21402, 'Acas', 214, 2),
(21403, 'Cajamarquilla', 214, 2),
(21404, 'Carhuapampa', 214, 2),
(21405, 'Cochas', 214, 2),
(21406, 'Congas', 214, 2),
(21407, 'Llipa', 214, 2),
(21408, 'San Cristóbal de Rajan', 214, 2),
(21409, 'San Pedro', 214, 2),
(21410, 'Santiago de Chilcas', 214, 2),
(21501, 'Cabana', 215, 2),
(21502, 'Bolognesi', 215, 2),
(21503, 'Conchucos', 215, 2),
(21504, 'Huacaschuque', 215, 2),
(21505, 'Huandoval', 215, 2),
(21506, 'Lacabamba', 215, 2),
(21507, 'Llapo', 215, 2),
(21508, 'Pallasca', 215, 2),
(21509, 'Pampas', 215, 2),
(21510, 'Santa Rosa', 215, 2),
(21511, 'Tauca', 215, 2),
(21601, 'Pomabamba', 216, 2),
(21602, 'Huayllan', 216, 2),
(21603, 'Parobamba', 216, 2),
(21604, 'Quinuabamba', 216, 2),
(21701, 'Recuay', 217, 2),
(21702, 'Catac', 217, 2),
(21703, 'Cotaparaco', 217, 2),
(21704, 'Huayllapampa', 217, 2),
(21705, 'Llacllin', 217, 2),
(21706, 'Marca', 217, 2),
(21707, 'Pampas Chico', 217, 2),
(21708, 'Pararin', 217, 2),
(21709, 'Tapacocha', 217, 2),
(21710, 'Ticapampa', 217, 2),
(21801, 'Chimbote', 218, 2),
(21802, 'Cáceres del Perú', 218, 2),
(21803, 'Coishco', 218, 2),
(21804, 'Macate', 218, 2),
(21805, 'Moro', 218, 2),
(21806, 'Nepeña', 218, 2),
(21807, 'Samanco', 218, 2),
(21808, 'Santa', 218, 2),
(21809, 'Nuevo Chimbote', 218, 2),
(21901, 'Sihuas', 219, 2),
(21902, 'Acobamba', 219, 2),
(21903, 'Alfonso Ugarte', 219, 2),
(21904, 'Cashapampa', 219, 2),
(21905, 'Chingalpo', 219, 2),
(21906, 'Huayllabamba', 219, 2),
(21907, 'Quiches', 219, 2),
(21908, 'Ragash', 219, 2),
(21909, 'San Juan', 219, 2),
(21910, 'Sicsibamba', 219, 2),
(22001, 'Yungay', 220, 2),
(22002, 'Cascapara', 220, 2),
(22003, 'Mancos', 220, 2),
(22004, 'Matacoto', 220, 2),
(22005, 'Quillo', 220, 2),
(22006, 'Ranrahirca', 220, 2),
(22007, 'Shupluy', 220, 2),
(22008, 'Yanama', 220, 2),
(30101, 'Abancay', 301, 3),
(30102, 'Chacoche', 301, 3),
(30103, 'Circa', 301, 3),
(30104, 'Curahuasi', 301, 3),
(30105, 'Huanipaca', 301, 3),
(30106, 'Lambrama', 301, 3),
(30107, 'Pichirhua', 301, 3),
(30108, 'San Pedro de Cachora', 301, 3),
(30109, 'Tamburco', 301, 3),
(30201, 'Andahuaylas', 302, 3),
(30202, 'Andarapa', 302, 3),
(30203, 'Chiara', 302, 3),
(30204, 'Huancarama', 302, 3),
(30205, 'Huancaray', 302, 3),
(30206, 'Huayana', 302, 3),
(30207, 'Kishuara', 302, 3),
(30208, 'Pacobamba', 302, 3),
(30209, 'Pacucha', 302, 3),
(30210, 'Pampachiri', 302, 3),
(30211, 'Pomacocha', 302, 3),
(30212, 'San Antonio de Cachi', 302, 3),
(30213, 'San Jerónimo', 302, 3),
(30214, 'San Miguel de Chaccrampa', 302, 3),
(30215, 'Santa María de Chicmo', 302, 3),
(30216, 'Talavera', 302, 3),
(30217, 'Tumay Huaraca', 302, 3),
(30218, 'Turpo', 302, 3),
(30219, 'Kaquiabamba', 302, 3),
(30220, 'José María Arguedas', 302, 3),
(30301, 'Antabamba', 303, 3),
(30302, 'El Oro', 303, 3),
(30303, 'Huaquirca', 303, 3),
(30304, 'Juan Espinoza Medrano', 303, 3),
(30305, 'Oropesa', 303, 3),
(30306, 'Pachaconas', 303, 3),
(30307, 'Sabaino', 303, 3),
(30401, 'Chalhuanca', 304, 3),
(30402, 'Capaya', 304, 3),
(30403, 'Caraybamba', 304, 3),
(30404, 'Chapimarca', 304, 3),
(30405, 'Colcabamba', 304, 3),
(30406, 'Cotaruse', 304, 3),
(30407, 'Ihuayllo', 304, 3),
(30408, 'Justo Apu Sahuaraura', 304, 3),
(30409, 'Lucre', 304, 3),
(30410, 'Pocohuanca', 304, 3),
(30411, 'San Juan de Chacña', 304, 3),
(30412, 'Sañayca', 304, 3),
(30413, 'Soraya', 304, 3),
(30414, 'Tapairihua', 304, 3),
(30415, 'Tintay', 304, 3),
(30416, 'Toraya', 304, 3),
(30417, 'Yanaca', 304, 3),
(30501, 'Tambobamba', 305, 3),
(30502, 'Cotabambas', 305, 3),
(30503, 'Coyllurqui', 305, 3),
(30504, 'Haquira', 305, 3),
(30505, 'Mara', 305, 3),
(30506, 'Challhuahuacho', 305, 3),
(30601, 'Chincheros', 306, 3),
(30602, 'Anco_Huallo', 306, 3),
(30603, 'Cocharcas', 306, 3),
(30604, 'Huaccana', 306, 3),
(30605, 'Ocobamba', 306, 3),
(30606, 'Ongoy', 306, 3),
(30607, 'Uranmarca', 306, 3),
(30608, 'Ranracancha', 306, 3),
(30609, 'Rocchacc', 306, 3),
(30610, 'El Porvenir', 306, 3),
(30611, 'Los Chankas', 306, 3),
(30701, 'Chuquibambilla', 307, 3),
(30702, 'Curpahuasi', 307, 3),
(30703, 'Gamarra', 307, 3),
(30704, 'Huayllati', 307, 3),
(30705, 'Mamara', 307, 3),
(30706, 'Micaela Bastidas', 307, 3),
(30707, 'Pataypampa', 307, 3),
(30708, 'Progreso', 307, 3),
(30709, 'San Antonio', 307, 3),
(30710, 'Santa Rosa', 307, 3),
(30711, 'Turpay', 307, 3),
(30712, 'Vilcabamba', 307, 3),
(30713, 'Virundo', 307, 3),
(30714, 'Curasco', 307, 3),
(40101, 'Arequipa', 401, 4),
(40102, 'Alto Selva Alegre', 401, 4),
(40103, 'Cayma', 401, 4),
(40104, 'Cerro Colorado', 401, 4),
(40105, 'Characato', 401, 4),
(40106, 'Chiguata', 401, 4),
(40107, 'Jacobo Hunter', 401, 4),
(40108, 'La Joya', 401, 4),
(40109, 'Mariano Melgar', 401, 4),
(40110, 'Miraflores', 401, 4),
(40111, 'Mollebaya', 401, 4),
(40112, 'Paucarpata', 401, 4),
(40113, 'Pocsi', 401, 4),
(40114, 'Polobaya', 401, 4),
(40115, 'Quequeña', 401, 4),
(40116, 'Sabandia', 401, 4),
(40117, 'Sachaca', 401, 4),
(40118, 'San Juan de Siguas', 401, 4),
(40119, 'San Juan de Tarucani', 401, 4),
(40120, 'Santa Isabel de Siguas', 401, 4),
(40121, 'Santa Rita de Siguas', 401, 4),
(40122, 'Socabaya', 401, 4),
(40123, 'Tiabaya', 401, 4),
(40124, 'Uchumayo', 401, 4),
(40125, 'Vitor', 401, 4),
(40126, 'Yanahuara', 401, 4),
(40127, 'Yarabamba', 401, 4),
(40128, 'Yura', 401, 4),
(40129, 'José Luis Bustamante Y Rivero', 401, 4),
(40201, 'Camaná', 402, 4),
(40202, 'José María Quimper', 402, 4),
(40203, 'Mariano Nicolás Valcárcel', 402, 4),
(40204, 'Mariscal Cáceres', 402, 4),
(40205, 'Nicolás de Pierola', 402, 4),
(40206, 'Ocoña', 402, 4),
(40207, 'Quilca', 402, 4),
(40208, 'Samuel Pastor', 402, 4),
(40301, 'Caravelí', 403, 4),
(40302, 'Acarí', 403, 4),
(40303, 'Atico', 403, 4),
(40304, 'Atiquipa', 403, 4),
(40305, 'Bella Unión', 403, 4),
(40306, 'Cahuacho', 403, 4),
(40307, 'Chala', 403, 4),
(40308, 'Chaparra', 403, 4),
(40309, 'Huanuhuanu', 403, 4),
(40310, 'Jaqui', 403, 4),
(40311, 'Lomas', 403, 4),
(40312, 'Quicacha', 403, 4),
(40313, 'Yauca', 403, 4),
(40401, 'Aplao', 404, 4),
(40402, 'Andagua', 404, 4),
(40403, 'Ayo', 404, 4),
(40404, 'Chachas', 404, 4),
(40405, 'Chilcaymarca', 404, 4),
(40406, 'Choco', 404, 4),
(40407, 'Huancarqui', 404, 4),
(40408, 'Machaguay', 404, 4),
(40409, 'Orcopampa', 404, 4),
(40410, 'Pampacolca', 404, 4),
(40411, 'Tipan', 404, 4),
(40412, 'Uñon', 404, 4),
(40413, 'Uraca', 404, 4),
(40414, 'Viraco', 404, 4),
(40501, 'Chivay', 405, 4),
(40502, 'Achoma', 405, 4),
(40503, 'Cabanaconde', 405, 4),
(40504, 'Callalli', 405, 4),
(40505, 'Caylloma', 405, 4),
(40506, 'Coporaque', 405, 4),
(40507, 'Huambo', 405, 4),
(40508, 'Huanca', 405, 4),
(40509, 'Ichupampa', 405, 4),
(40510, 'Lari', 405, 4),
(40511, 'Lluta', 405, 4),
(40512, 'Maca', 405, 4),
(40513, 'Madrigal', 405, 4),
(40514, 'San Antonio de Chuca', 405, 4),
(40515, 'Sibayo', 405, 4),
(40516, 'Tapay', 405, 4),
(40517, 'Tisco', 405, 4),
(40518, 'Tuti', 405, 4),
(40519, 'Yanque', 405, 4),
(40520, 'Majes', 405, 4),
(40601, 'Chuquibamba', 406, 4),
(40602, 'Andaray', 406, 4),
(40603, 'Cayarani', 406, 4),
(40604, 'Chichas', 406, 4),
(40605, 'Iray', 406, 4),
(40606, 'Río Grande', 406, 4),
(40607, 'Salamanca', 406, 4),
(40608, 'Yanaquihua', 406, 4),
(40701, 'Mollendo', 407, 4),
(40702, 'Cocachacra', 407, 4),
(40703, 'Dean Valdivia', 407, 4),
(40704, 'Islay', 407, 4),
(40705, 'Mejia', 407, 4),
(40706, 'Punta de Bombón', 407, 4),
(40801, 'Cotahuasi', 408, 4),
(40802, 'Alca', 408, 4),
(40803, 'Charcana', 408, 4),
(40804, 'Huaynacotas', 408, 4),
(40805, 'Pampamarca', 408, 4),
(40806, 'Puyca', 408, 4),
(40807, 'Quechualla', 408, 4),
(40808, 'Sayla', 408, 4),
(40809, 'Tauria', 408, 4),
(40810, 'Tomepampa', 408, 4),
(40811, 'Toro', 408, 4),
(50101, 'Ayacucho', 501, 5),
(50102, 'Acocro', 501, 5),
(50103, 'Acos Vinchos', 501, 5),
(50104, 'Carmen Alto', 501, 5),
(50105, 'Chiara', 501, 5),
(50106, 'Ocros', 501, 5),
(50107, 'Pacaycasa', 501, 5),
(50108, 'Quinua', 501, 5),
(50109, 'San José de Ticllas', 501, 5),
(50110, 'San Juan Bautista', 501, 5),
(50111, 'Santiago de Pischa', 501, 5),
(50112, 'Socos', 501, 5),
(50113, 'Tambillo', 501, 5),
(50114, 'Vinchos', 501, 5),
(50115, 'Jesús Nazareno', 501, 5),
(50116, 'Andrés Avelino Cáceres Dorregaray', 501, 5),
(50201, 'Cangallo', 502, 5),
(50202, 'Chuschi', 502, 5),
(50203, 'Los Morochucos', 502, 5),
(50204, 'María Parado de Bellido', 502, 5),
(50205, 'Paras', 502, 5),
(50206, 'Totos', 502, 5),
(50301, 'Sancos', 503, 5),
(50302, 'Carapo', 503, 5),
(50303, 'Sacsamarca', 503, 5),
(50304, 'Santiago de Lucanamarca', 503, 5),
(50401, 'Huanta', 504, 5),
(50402, 'Ayahuanco', 504, 5),
(50403, 'Huamanguilla', 504, 5),
(50404, 'Iguain', 504, 5),
(50405, 'Luricocha', 504, 5),
(50406, 'Santillana', 504, 5),
(50407, 'Sivia', 504, 5),
(50408, 'Llochegua', 504, 5),
(50409, 'Canayre', 504, 5),
(50410, 'Uchuraccay', 504, 5),
(50411, 'Pucacolpa', 504, 5),
(50412, 'Chaca', 504, 5),
(50501, 'San Miguel', 505, 5),
(50502, 'Anco', 505, 5),
(50503, 'Ayna', 505, 5),
(50504, 'Chilcas', 505, 5),
(50505, 'Chungui', 505, 5),
(50506, 'Luis Carranza', 505, 5),
(50507, 'Santa Rosa', 505, 5),
(50508, 'Tambo', 505, 5),
(50509, 'Samugari', 505, 5),
(50510, 'Anchihuay', 505, 5),
(50511, 'Oronccoy', 505, 5),
(50601, 'Puquio', 506, 5),
(50602, 'Aucara', 506, 5),
(50603, 'Cabana', 506, 5),
(50604, 'Carmen Salcedo', 506, 5),
(50605, 'Chaviña', 506, 5),
(50606, 'Chipao', 506, 5),
(50607, 'Huac-Huas', 506, 5),
(50608, 'Laramate', 506, 5),
(50609, 'Leoncio Prado', 506, 5),
(50610, 'Llauta', 506, 5),
(50611, 'Lucanas', 506, 5),
(50612, 'Ocaña', 506, 5),
(50613, 'Otoca', 506, 5),
(50614, 'Saisa', 506, 5),
(50615, 'San Cristóbal', 506, 5),
(50616, 'San Juan', 506, 5),
(50617, 'San Pedro', 506, 5),
(50618, 'San Pedro de Palco', 506, 5),
(50619, 'Sancos', 506, 5),
(50620, 'Santa Ana de Huaycahuacho', 506, 5),
(50621, 'Santa Lucia', 506, 5),
(50701, 'Coracora', 507, 5),
(50702, 'Chumpi', 507, 5),
(50703, 'Coronel Castañeda', 507, 5),
(50704, 'Pacapausa', 507, 5),
(50705, 'Pullo', 507, 5),
(50706, 'Puyusca', 507, 5),
(50707, 'San Francisco de Ravacayco', 507, 5),
(50708, 'Upahuacho', 507, 5),
(50801, 'Pausa', 508, 5),
(50802, 'Colta', 508, 5),
(50803, 'Corculla', 508, 5),
(50804, 'Lampa', 508, 5),
(50805, 'Marcabamba', 508, 5),
(50806, 'Oyolo', 508, 5),
(50807, 'Pararca', 508, 5),
(50808, 'San Javier de Alpabamba', 508, 5),
(50809, 'San José de Ushua', 508, 5),
(50810, 'Sara Sara', 508, 5),
(50901, 'Querobamba', 509, 5),
(50902, 'Belén', 509, 5),
(50903, 'Chalcos', 509, 5),
(50904, 'Chilcayoc', 509, 5),
(50905, 'Huacaña', 509, 5),
(50906, 'Morcolla', 509, 5),
(50907, 'Paico', 509, 5),
(50908, 'San Pedro de Larcay', 509, 5),
(50909, 'San Salvador de Quije', 509, 5),
(50910, 'Santiago de Paucaray', 509, 5),
(50911, 'Soras', 509, 5),
(51001, 'Huancapi', 510, 5),
(51002, 'Alcamenca', 510, 5),
(51003, 'Apongo', 510, 5),
(51004, 'Asquipata', 510, 5),
(51005, 'Canaria', 510, 5),
(51006, 'Cayara', 510, 5),
(51007, 'Colca', 510, 5),
(51008, 'Huamanquiquia', 510, 5),
(51009, 'Huancaraylla', 510, 5),
(51010, 'Hualla', 510, 5),
(51011, 'Sarhua', 510, 5),
(51012, 'Vilcanchos', 510, 5),
(51101, 'Vilcas Huaman', 511, 5),
(51102, 'Accomarca', 511, 5),
(51103, 'Carhuanca', 511, 5),
(51104, 'Concepción', 511, 5),
(51105, 'Huambalpa', 511, 5),
(51106, 'Independencia', 511, 5),
(51107, 'Saurama', 511, 5),
(51108, 'Vischongo', 511, 5),
(60101, 'Cajamarca', 601, 6),
(60102, 'Asunción', 601, 6),
(60103, 'Chetilla', 601, 6),
(60104, 'Cospan', 601, 6),
(60105, 'Encañada', 601, 6),
(60106, 'Jesús', 601, 6),
(60107, 'Llacanora', 601, 6),
(60108, 'Los Baños del Inca', 601, 6),
(60109, 'Magdalena', 601, 6),
(60110, 'Matara', 601, 6),
(60111, 'Namora', 601, 6),
(60112, 'San Juan', 601, 6),
(60201, 'Cajabamba', 602, 6),
(60202, 'Cachachi', 602, 6),
(60203, 'Condebamba', 602, 6),
(60204, 'Sitacocha', 602, 6),
(60301, 'Celendín', 603, 6),
(60302, 'Chumuch', 603, 6),
(60303, 'Cortegana', 603, 6),
(60304, 'Huasmin', 603, 6),
(60305, 'Jorge Chávez', 603, 6),
(60306, 'José Gálvez', 603, 6),
(60307, 'Miguel Iglesias', 603, 6),
(60308, 'Oxamarca', 603, 6),
(60309, 'Sorochuco', 603, 6),
(60310, 'Sucre', 603, 6),
(60311, 'Utco', 603, 6),
(60312, 'La Libertad de Pallan', 603, 6),
(60401, 'Chota', 604, 6),
(60402, 'Anguia', 604, 6),
(60403, 'Chadin', 604, 6),
(60404, 'Chiguirip', 604, 6),
(60405, 'Chimban', 604, 6),
(60406, 'Choropampa', 604, 6),
(60407, 'Cochabamba', 604, 6),
(60408, 'Conchan', 604, 6),
(60409, 'Huambos', 604, 6),
(60410, 'Lajas', 604, 6),
(60411, 'Llama', 604, 6),
(60412, 'Miracosta', 604, 6),
(60413, 'Paccha', 604, 6),
(60414, 'Pion', 604, 6),
(60415, 'Querocoto', 604, 6),
(60416, 'San Juan de Licupis', 604, 6),
(60417, 'Tacabamba', 604, 6),
(60418, 'Tocmoche', 604, 6),
(60419, 'Chalamarca', 604, 6),
(60501, 'Contumaza', 605, 6),
(60502, 'Chilete', 605, 6),
(60503, 'Cupisnique', 605, 6),
(60504, 'Guzmango', 605, 6),
(60505, 'San Benito', 605, 6),
(60506, 'Santa Cruz de Toledo', 605, 6),
(60507, 'Tantarica', 605, 6),
(60508, 'Yonan', 605, 6),
(60601, 'Cutervo', 606, 6),
(60602, 'Callayuc', 606, 6),
(60603, 'Choros', 606, 6),
(60604, 'Cujillo', 606, 6),
(60605, 'La Ramada', 606, 6),
(60606, 'Pimpingos', 606, 6),
(60607, 'Querocotillo', 606, 6),
(60608, 'San Andrés de Cutervo', 606, 6),
(60609, 'San Juan de Cutervo', 606, 6),
(60610, 'San Luis de Lucma', 606, 6),
(60611, 'Santa Cruz', 606, 6),
(60612, 'Santo Domingo de la Capilla', 606, 6),
(60613, 'Santo Tomas', 606, 6),
(60614, 'Socota', 606, 6),
(60615, 'Toribio Casanova', 606, 6),
(60701, 'Bambamarca', 607, 6),
(60702, 'Chugur', 607, 6),
(60703, 'Hualgayoc', 607, 6),
(60801, 'Jaén', 608, 6),
(60802, 'Bellavista', 608, 6),
(60803, 'Chontali', 608, 6),
(60804, 'Colasay', 608, 6),
(60805, 'Huabal', 608, 6),
(60806, 'Las Pirias', 608, 6),
(60807, 'Pomahuaca', 608, 6),
(60808, 'Pucara', 608, 6),
(60809, 'Sallique', 608, 6),
(60810, 'San Felipe', 608, 6),
(60811, 'San José del Alto', 608, 6),
(60812, 'Santa Rosa', 608, 6),
(60901, 'San Ignacio', 609, 6),
(60902, 'Chirinos', 609, 6),
(60903, 'Huarango', 609, 6),
(60904, 'La Coipa', 609, 6),
(60905, 'Namballe', 609, 6),
(60906, 'San José de Lourdes', 609, 6),
(60907, 'Tabaconas', 609, 6),
(61001, 'Pedro Gálvez', 610, 6),
(61002, 'Chancay', 610, 6),
(61003, 'Eduardo Villanueva', 610, 6),
(61004, 'Gregorio Pita', 610, 6),
(61005, 'Ichocan', 610, 6),
(61006, 'José Manuel Quiroz', 610, 6),
(61007, 'José Sabogal', 610, 6),
(61101, 'San Miguel', 611, 6),
(61102, 'Bolívar', 611, 6),
(61103, 'Calquis', 611, 6),
(61104, 'Catilluc', 611, 6),
(61105, 'El Prado', 611, 6),
(61106, 'La Florida', 611, 6),
(61107, 'Llapa', 611, 6),
(61108, 'Nanchoc', 611, 6),
(61109, 'Niepos', 611, 6),
(61110, 'San Gregorio', 611, 6),
(61111, 'San Silvestre de Cochan', 611, 6),
(61112, 'Tongod', 611, 6),
(61113, 'Unión Agua Blanca', 611, 6),
(61201, 'San Pablo', 612, 6),
(61202, 'San Bernardino', 612, 6),
(61203, 'San Luis', 612, 6),
(61204, 'Tumbaden', 612, 6),
(61301, 'Santa Cruz', 613, 6),
(61302, 'Andabamba', 613, 6),
(61303, 'Catache', 613, 6),
(61304, 'Chancaybaños', 613, 6),
(61305, 'La Esperanza', 613, 6),
(61306, 'Ninabamba', 613, 6),
(61307, 'Pulan', 613, 6),
(61308, 'Saucepampa', 613, 6),
(61309, 'Sexi', 613, 6),
(61310, 'Uticyacu', 613, 6),
(61311, 'Yauyucan', 613, 6),
(70101, 'Callao', 701, 7),
(70102, 'Bellavista', 701, 7),
(70103, 'Carmen de la Legua Reynoso', 701, 7),
(70104, 'La Perla', 701, 7),
(70105, 'La Punta', 701, 7),
(70106, 'Ventanilla', 701, 7),
(70107, 'Mi Perú', 701, 7),
(80101, 'Cusco', 801, 8),
(80102, 'Ccorca', 801, 8),
(80103, 'Poroy', 801, 8),
(80104, 'San Jerónimo', 801, 8),
(80105, 'San Sebastian', 801, 8),
(80106, 'Santiago', 801, 8),
(80107, 'Saylla', 801, 8),
(80108, 'Wanchaq', 801, 8),
(80201, 'Acomayo', 802, 8),
(80202, 'Acopia', 802, 8),
(80203, 'Acos', 802, 8),
(80204, 'Mosoc Llacta', 802, 8),
(80205, 'Pomacanchi', 802, 8),
(80206, 'Rondocan', 802, 8),
(80207, 'Sangarara', 802, 8),
(80301, 'Anta', 803, 8),
(80302, 'Ancahuasi', 803, 8),
(80303, 'Cachimayo', 803, 8),
(80304, 'Chinchaypujio', 803, 8),
(80305, 'Huarocondo', 803, 8),
(80306, 'Limatambo', 803, 8),
(80307, 'Mollepata', 803, 8),
(80308, 'Pucyura', 803, 8),
(80309, 'Zurite', 803, 8),
(80401, 'Calca', 804, 8),
(80402, 'Coya', 804, 8),
(80403, 'Lamay', 804, 8),
(80404, 'Lares', 804, 8),
(80405, 'Pisac', 804, 8),
(80406, 'San Salvador', 804, 8),
(80407, 'Taray', 804, 8),
(80408, 'Yanatile', 804, 8),
(80501, 'Yanaoca', 805, 8),
(80502, 'Checca', 805, 8),
(80503, 'Kunturkanki', 805, 8),
(80504, 'Langui', 805, 8),
(80505, 'Layo', 805, 8),
(80506, 'Pampamarca', 805, 8),
(80507, 'Quehue', 805, 8),
(80508, 'Tupac Amaru', 805, 8),
(80601, 'Sicuani', 806, 8),
(80602, 'Checacupe', 806, 8),
(80603, 'Combapata', 806, 8),
(80604, 'Marangani', 806, 8),
(80605, 'Pitumarca', 806, 8),
(80606, 'San Pablo', 806, 8),
(80607, 'San Pedro', 806, 8),
(80608, 'Tinta', 806, 8),
(80701, 'Santo Tomas', 807, 8),
(80702, 'Capacmarca', 807, 8),
(80703, 'Chamaca', 807, 8),
(80704, 'Colquemarca', 807, 8),
(80705, 'Livitaca', 807, 8),
(80706, 'Llusco', 807, 8),
(80707, 'Quiñota', 807, 8),
(80708, 'Velille', 807, 8),
(80801, 'Espinar', 808, 8),
(80802, 'Condoroma', 808, 8),
(80803, 'Coporaque', 808, 8),
(80804, 'Ocoruro', 808, 8),
(80805, 'Pallpata', 808, 8),
(80806, 'Pichigua', 808, 8),
(80807, 'Suyckutambo', 808, 8),
(80808, 'Alto Pichigua', 808, 8),
(80901, 'Santa Ana', 809, 8),
(80902, 'Echarate', 809, 8),
(80903, 'Huayopata', 809, 8),
(80904, 'Maranura', 809, 8),
(80905, 'Ocobamba', 809, 8),
(80906, 'Quellouno', 809, 8),
(80907, 'Kimbiri', 809, 8),
(80908, 'Santa Teresa', 809, 8),
(80909, 'Vilcabamba', 809, 8),
(80910, 'Pichari', 809, 8),
(80911, 'Inkawasi', 809, 8),
(80912, 'Villa Virgen', 809, 8),
(80913, 'Villa Kintiarina', 809, 8),
(80914, 'Megantoni', 809, 8),
(81001, 'Paruro', 810, 8),
(81002, 'Accha', 810, 8),
(81003, 'Ccapi', 810, 8),
(81004, 'Colcha', 810, 8),
(81005, 'Huanoquite', 810, 8),
(81006, 'Omachaç', 810, 8),
(81007, 'Paccaritambo', 810, 8),
(81008, 'Pillpinto', 810, 8),
(81009, 'Yaurisque', 810, 8),
(81101, 'Paucartambo', 811, 8),
(81102, 'Caicay', 811, 8),
(81103, 'Challabamba', 811, 8),
(81104, 'Colquepata', 811, 8),
(81105, 'Huancarani', 811, 8),
(81106, 'Kosñipata', 811, 8),
(81201, 'Urcos', 812, 8),
(81202, 'Andahuaylillas', 812, 8),
(81203, 'Camanti', 812, 8),
(81204, 'Ccarhuayo', 812, 8),
(81205, 'Ccatca', 812, 8),
(81206, 'Cusipata', 812, 8),
(81207, 'Huaro', 812, 8),
(81208, 'Lucre', 812, 8),
(81209, 'Marcapata', 812, 8),
(81210, 'Ocongate', 812, 8),
(81211, 'Oropesa', 812, 8),
(81212, 'Quiquijana', 812, 8),
(81301, 'Urubamba', 813, 8),
(81302, 'Chinchero', 813, 8),
(81303, 'Huayllabamba', 813, 8),
(81304, 'Machupicchu', 813, 8),
(81305, 'Maras', 813, 8),
(81306, 'Ollantaytambo', 813, 8),
(81307, 'Yucay', 813, 8),
(90101, 'Huancavelica', 901, 9),
(90102, 'Acobambilla', 901, 9),
(90103, 'Acoria', 901, 9),
(90104, 'Conayca', 901, 9),
(90105, 'Cuenca', 901, 9),
(90106, 'Huachocolpa', 901, 9),
(90107, 'Huayllahuara', 901, 9),
(90108, 'Izcuchaca', 901, 9),
(90109, 'Laria', 901, 9),
(90110, 'Manta', 901, 9),
(90111, 'Mariscal Cáceres', 901, 9),
(90112, 'Moya', 901, 9),
(90113, 'Nuevo Occoro', 901, 9),
(90114, 'Palca', 901, 9),
(90115, 'Pilchaca', 901, 9),
(90116, 'Vilca', 901, 9),
(90117, 'Yauli', 901, 9),
(90118, 'Ascensión', 901, 9),
(90119, 'Huando', 901, 9),
(90201, 'Acobamba', 902, 9),
(90202, 'Andabamba', 902, 9),
(90203, 'Anta', 902, 9),
(90204, 'Caja', 902, 9),
(90205, 'Marcas', 902, 9),
(90206, 'Paucara', 902, 9),
(90207, 'Pomacocha', 902, 9),
(90208, 'Rosario', 902, 9),
(90301, 'Lircay', 903, 9),
(90302, 'Anchonga', 903, 9),
(90303, 'Callanmarca', 903, 9),
(90304, 'Ccochaccasa', 903, 9),
(90305, 'Chincho', 903, 9),
(90306, 'Congalla', 903, 9),
(90307, 'Huanca-Huanca', 903, 9),
(90308, 'Huayllay Grande', 903, 9),
(90309, 'Julcamarca', 903, 9),
(90310, 'San Antonio de Antaparco', 903, 9),
(90311, 'Santo Tomas de Pata', 903, 9),
(90312, 'Secclla', 903, 9),
(90401, 'Castrovirreyna', 904, 9),
(90402, 'Arma', 904, 9),
(90403, 'Aurahua', 904, 9),
(90404, 'Capillas', 904, 9),
(90405, 'Chupamarca', 904, 9),
(90406, 'Cocas', 904, 9),
(90407, 'Huachos', 904, 9),
(90408, 'Huamatambo', 904, 9),
(90409, 'Mollepampa', 904, 9),
(90410, 'San Juan', 904, 9),
(90411, 'Santa Ana', 904, 9),
(90412, 'Tantara', 904, 9),
(90413, 'Ticrapo', 904, 9),
(90501, 'Churcampa', 905, 9),
(90502, 'Anco', 905, 9),
(90503, 'Chinchihuasi', 905, 9),
(90504, 'El Carmen', 905, 9),
(90505, 'La Merced', 905, 9),
(90506, 'Locroja', 905, 9),
(90507, 'Paucarbamba', 905, 9),
(90508, 'San Miguel de Mayocc', 905, 9),
(90509, 'San Pedro de Coris', 905, 9),
(90510, 'Pachamarca', 905, 9),
(90511, 'Cosme', 905, 9),
(90601, 'Huaytara', 906, 9),
(90602, 'Ayavi', 906, 9),
(90603, 'Córdova', 906, 9),
(90604, 'Huayacundo Arma', 906, 9),
(90605, 'Laramarca', 906, 9),
(90606, 'Ocoyo', 906, 9),
(90607, 'Pilpichaca', 906, 9),
(90608, 'Querco', 906, 9),
(90609, 'Quito-Arma', 906, 9),
(90610, 'San Antonio de Cusicancha', 906, 9),
(90611, 'San Francisco de Sangayaico', 906, 9),
(90612, 'San Isidro', 906, 9),
(90613, 'Santiago de Chocorvos', 906, 9),
(90614, 'Santiago de Quirahuara', 906, 9),
(90615, 'Santo Domingo de Capillas', 906, 9),
(90616, 'Tambo', 906, 9),
(90701, 'Pampas', 907, 9),
(90702, 'Acostambo', 907, 9),
(90703, 'Acraquia', 907, 9),
(90704, 'Ahuaycha', 907, 9),
(90705, 'Colcabamba', 907, 9),
(90706, 'Daniel Hernández', 907, 9),
(90707, 'Huachocolpa', 907, 9),
(90709, 'Huaribamba', 907, 9),
(90710, 'Ñahuimpuquio', 907, 9),
(90711, 'Pazos', 907, 9),
(90713, 'Quishuar', 907, 9),
(90714, 'Salcabamba', 907, 9),
(90715, 'Salcahuasi', 907, 9),
(90716, 'San Marcos de Rocchac', 907, 9),
(90717, 'Surcubamba', 907, 9),
(90718, 'Tintay Puncu', 907, 9),
(90719, 'Quichuas', 907, 9),
(90720, 'Andaymarca', 907, 9),
(90721, 'Roble', 907, 9),
(90722, 'Pichos', 907, 9),
(90723, 'Santiago de Tucuma', 907, 9),
(100101, 'Huanuco', 1001, 10),
(100102, 'Amarilis', 1001, 10),
(100103, 'Chinchao', 1001, 10),
(100104, 'Churubamba', 1001, 10),
(100105, 'Margos', 1001, 10),
(100106, 'Quisqui (Kichki)', 1001, 10),
(100107, 'San Francisco de Cayran', 1001, 10),
(100108, 'San Pedro de Chaulan', 1001, 10),
(100109, 'Santa María del Valle', 1001, 10),
(100110, 'Yarumayo', 1001, 10),
(100111, 'Pillco Marca', 1001, 10),
(100112, 'Yacus', 1001, 10),
(100113, 'San Pablo de Pillao', 1001, 10),
(100201, 'Ambo', 1002, 10),
(100202, 'Cayna', 1002, 10),
(100203, 'Colpas', 1002, 10),
(100204, 'Conchamarca', 1002, 10),
(100205, 'Huacar', 1002, 10),
(100206, 'San Francisco', 1002, 10),
(100207, 'San Rafael', 1002, 10),
(100208, 'Tomay Kichwa', 1002, 10),
(100301, 'La Unión', 1003, 10),
(100307, 'Chuquis', 1003, 10),
(100311, 'Marías', 1003, 10),
(100313, 'Pachas', 1003, 10),
(100316, 'Quivilla', 1003, 10),
(100317, 'Ripan', 1003, 10),
(100321, 'Shunqui', 1003, 10),
(100322, 'Sillapata', 1003, 10),
(100323, 'Yanas', 1003, 10),
(100401, 'Huacaybamba', 1004, 10),
(100402, 'Canchabamba', 1004, 10),
(100403, 'Cochabamba', 1004, 10),
(100404, 'Pinra', 1004, 10),
(100501, 'Llata', 1005, 10),
(100502, 'Arancay', 1005, 10),
(100503, 'Chavín de Pariarca', 1005, 10),
(100504, 'Jacas Grande', 1005, 10),
(100505, 'Jircan', 1005, 10),
(100506, 'Miraflores', 1005, 10),
(100507, 'Monzón', 1005, 10),
(100508, 'Punchao', 1005, 10),
(100509, 'Puños', 1005, 10),
(100510, 'Singa', 1005, 10),
(100511, 'Tantamayo', 1005, 10),
(100601, 'Rupa-Rupa', 1006, 10),
(100602, 'Daniel Alomía Robles', 1006, 10),
(100603, 'Hermílio Valdizan', 1006, 10),
(100604, 'José Crespo y Castillo', 1006, 10),
(100605, 'Luyando', 1006, 10),
(100606, 'Mariano Damaso Beraun', 1006, 10),
(100607, 'Pucayacu', 1006, 10),
(100608, 'Castillo Grande', 1006, 10),
(100609, 'Pueblo Nuevo', 1006, 10),
(100610, 'Santo Domingo de Anda', 1006, 10),
(100701, 'Huacrachuco', 1007, 10),
(100702, 'Cholon', 1007, 10),
(100703, 'San Buenaventura', 1007, 10),
(100704, 'La Morada', 1007, 10),
(100705, 'Santa Rosa de Alto Yanajanca', 1007, 10),
(100801, 'Panao', 1008, 10),
(100802, 'Chaglla', 1008, 10),
(100803, 'Molino', 1008, 10),
(100804, 'Umari', 1008, 10),
(100901, 'Puerto Inca', 1009, 10),
(100902, 'Codo del Pozuzo', 1009, 10),
(100903, 'Honoria', 1009, 10),
(100904, 'Tournavista', 1009, 10),
(100905, 'Yuyapichis', 1009, 10),
(101001, 'Jesús', 1010, 10),
(101002, 'Baños', 1010, 10),
(101003, 'Jivia', 1010, 10),
(101004, 'Queropalca', 1010, 10),
(101005, 'Rondos', 1010, 10),
(101006, 'San Francisco de Asís', 1010, 10),
(101007, 'San Miguel de Cauri', 1010, 10),
(101101, 'Chavinillo', 1011, 10),
(101102, 'Cahuac', 1011, 10),
(101103, 'Chacabamba', 1011, 10),
(101104, 'Aparicio Pomares', 1011, 10),
(101105, 'Jacas Chico', 1011, 10),
(101106, 'Obas', 1011, 10),
(101107, 'Pampamarca', 1011, 10),
(101108, 'Choras', 1011, 10),
(110101, 'Ica', 1101, 11),
(110102, 'La Tinguiña', 1101, 11),
(110103, 'Los Aquijes', 1101, 11),
(110104, 'Ocucaje', 1101, 11),
(110105, 'Pachacutec', 1101, 11),
(110106, 'Parcona', 1101, 11),
(110107, 'Pueblo Nuevo', 1101, 11),
(110108, 'Salas', 1101, 11),
(110109, 'San José de Los Molinos', 1101, 11),
(110110, 'San Juan Bautista', 1101, 11),
(110111, 'Santiago', 1101, 11),
(110112, 'Subtanjalla', 1101, 11),
(110113, 'Tate', 1101, 11),
(110114, 'Yauca del Rosario', 1101, 11),
(110201, 'Chincha Alta', 1102, 11),
(110202, 'Alto Laran', 1102, 11),
(110203, 'Chavin', 1102, 11),
(110204, 'Chincha Baja', 1102, 11),
(110205, 'El Carmen', 1102, 11),
(110206, 'Grocio Prado', 1102, 11),
(110207, 'Pueblo Nuevo', 1102, 11),
(110208, 'San Juan de Yanac', 1102, 11),
(110209, 'San Pedro de Huacarpana', 1102, 11),
(110210, 'Sunampe', 1102, 11),
(110211, 'Tambo de Mora', 1102, 11),
(110301, 'Nasca', 1103, 11),
(110302, 'Changuillo', 1103, 11),
(110303, 'El Ingenio', 1103, 11),
(110304, 'Marcona', 1103, 11),
(110305, 'Vista Alegre', 1103, 11),
(110401, 'Palpa', 1104, 11),
(110402, 'Llipata', 1104, 11),
(110403, 'Río Grande', 1104, 11),
(110404, 'Santa Cruz', 1104, 11),
(110405, 'Tibillo', 1104, 11),
(110501, 'Pisco', 1105, 11),
(110502, 'Huancano', 1105, 11),
(110503, 'Humay', 1105, 11),
(110504, 'Independencia', 1105, 11),
(110505, 'Paracas', 1105, 11),
(110506, 'San Andrés', 1105, 11),
(110507, 'San Clemente', 1105, 11),
(110508, 'Tupac Amaru Inca', 1105, 11),
(120101, 'Huancayo', 1201, 12),
(120104, 'Carhuacallanga', 1201, 12),
(120105, 'Chacapampa', 1201, 12),
(120106, 'Chicche', 1201, 12),
(120107, 'Chilca', 1201, 12),
(120108, 'Chongos Alto', 1201, 12),
(120111, 'Chupuro', 1201, 12),
(120112, 'Colca', 1201, 12),
(120113, 'Cullhuas', 1201, 12),
(120114, 'El Tambo', 1201, 12),
(120116, 'Huacrapuquio', 1201, 12),
(120117, 'Hualhuas', 1201, 12),
(120119, 'Huancan', 1201, 12),
(120120, 'Huasicancha', 1201, 12),
(120121, 'Huayucachi', 1201, 12),
(120122, 'Ingenio', 1201, 12),
(120124, 'Pariahuanca', 1201, 12),
(120125, 'Pilcomayo', 1201, 12),
(120126, 'Pucara', 1201, 12),
(120127, 'Quichuay', 1201, 12),
(120128, 'Quilcas', 1201, 12),
(120129, 'San Agustín', 1201, 12),
(120130, 'San Jerónimo de Tunan', 1201, 12),
(120132, 'Saño', 1201, 12),
(120133, 'Sapallanga', 1201, 12),
(120134, 'Sicaya', 1201, 12),
(120135, 'Santo Domingo de Acobamba', 1201, 12),
(120136, 'Viques', 1201, 12),
(120201, 'Concepción', 1202, 12),
(120202, 'Aco', 1202, 12),
(120203, 'Andamarca', 1202, 12),
(120204, 'Chambara', 1202, 12),
(120205, 'Cochas', 1202, 12),
(120206, 'Comas', 1202, 12),
(120207, 'Heroínas Toledo', 1202, 12),
(120208, 'Manzanares', 1202, 12),
(120209, 'Mariscal Castilla', 1202, 12),
(120210, 'Matahuasi', 1202, 12),
(120211, 'Mito', 1202, 12),
(120212, 'Nueve de Julio', 1202, 12),
(120213, 'Orcotuna', 1202, 12),
(120214, 'San José de Quero', 1202, 12),
(120215, 'Santa Rosa de Ocopa', 1202, 12),
(120301, 'Chanchamayo', 1203, 12),
(120302, 'Perene', 1203, 12),
(120303, 'Pichanaqui', 1203, 12),
(120304, 'San Luis de Shuaro', 1203, 12),
(120305, 'San Ramón', 1203, 12),
(120306, 'Vitoc', 1203, 12),
(120401, 'Jauja', 1204, 12),
(120402, 'Acolla', 1204, 12),
(120403, 'Apata', 1204, 12),
(120404, 'Ataura', 1204, 12),
(120405, 'Canchayllo', 1204, 12),
(120406, 'Curicaca', 1204, 12),
(120407, 'El Mantaro', 1204, 12),
(120408, 'Huamali', 1204, 12),
(120409, 'Huaripampa', 1204, 12),
(120410, 'Huertas', 1204, 12),
(120411, 'Janjaillo', 1204, 12),
(120412, 'Julcán', 1204, 12),
(120413, 'Leonor Ordóñez', 1204, 12),
(120414, 'Llocllapampa', 1204, 12),
(120415, 'Marco', 1204, 12),
(120416, 'Masma', 1204, 12),
(120417, 'Masma Chicche', 1204, 12),
(120418, 'Molinos', 1204, 12),
(120419, 'Monobamba', 1204, 12),
(120420, 'Muqui', 1204, 12),
(120421, 'Muquiyauyo', 1204, 12),
(120422, 'Paca', 1204, 12),
(120423, 'Paccha', 1204, 12),
(120424, 'Pancan', 1204, 12),
(120425, 'Parco', 1204, 12),
(120426, 'Pomacancha', 1204, 12),
(120427, 'Ricran', 1204, 12),
(120428, 'San Lorenzo', 1204, 12),
(120429, 'San Pedro de Chunan', 1204, 12),
(120430, 'Sausa', 1204, 12),
(120431, 'Sincos', 1204, 12),
(120432, 'Tunan Marca', 1204, 12),
(120433, 'Yauli', 1204, 12),
(120434, 'Yauyos', 1204, 12),
(120501, 'Junin', 1205, 12),
(120502, 'Carhuamayo', 1205, 12),
(120503, 'Ondores', 1205, 12),
(120504, 'Ulcumayo', 1205, 12),
(120601, 'Satipo', 1206, 12),
(120602, 'Coviriali', 1206, 12),
(120603, 'Llaylla', 1206, 12),
(120604, 'Mazamari', 1206, 12),
(120605, 'Pampa Hermosa', 1206, 12),
(120606, 'Pangoa', 1206, 12),
(120607, 'Río Negro', 1206, 12),
(120608, 'Río Tambo', 1206, 12),
(120609, 'Vizcatan del Ene', 1206, 12),
(120701, 'Tarma', 1207, 12),
(120702, 'Acobamba', 1207, 12),
(120703, 'Huaricolca', 1207, 12),
(120704, 'Huasahuasi', 1207, 12),
(120705, 'La Unión', 1207, 12),
(120706, 'Palca', 1207, 12),
(120707, 'Palcamayo', 1207, 12),
(120708, 'San Pedro de Cajas', 1207, 12),
(120709, 'Tapo', 1207, 12),
(120801, 'La Oroya', 1208, 12),
(120802, 'Chacapalpa', 1208, 12),
(120803, 'Huay-Huay', 1208, 12),
(120804, 'Marcapomacocha', 1208, 12),
(120805, 'Morococha', 1208, 12),
(120806, 'Paccha', 1208, 12),
(120807, 'Santa Bárbara de Carhuacayan', 1208, 12),
(120808, 'Santa Rosa de Sacco', 1208, 12),
(120809, 'Suitucancha', 1208, 12),
(120810, 'Yauli', 1208, 12),
(120901, 'Chupaca', 1209, 12),
(120902, 'Ahuac', 1209, 12),
(120903, 'Chongos Bajo', 1209, 12),
(120904, 'Huachac', 1209, 12),
(120905, 'Huamancaca Chico', 1209, 12),
(120906, 'San Juan de Iscos', 1209, 12),
(120907, 'San Juan de Jarpa', 1209, 12),
(120908, 'Tres de Diciembre', 1209, 12),
(120909, 'Yanacancha', 1209, 12),
(130101, 'Trujillo', 1301, 13),
(130102, 'El Porvenir', 1301, 13),
(130103, 'Florencia de Mora', 1301, 13),
(130104, 'Huanchaco', 1301, 13),
(130105, 'La Esperanza', 1301, 13),
(130106, 'Laredo', 1301, 13),
(130107, 'Moche', 1301, 13),
(130108, 'Poroto', 1301, 13),
(130109, 'Salaverry', 1301, 13),
(130110, 'Simbal', 1301, 13),
(130111, 'Victor Larco Herrera', 1301, 13),
(130201, 'Ascope', 1302, 13),
(130202, 'Chicama', 1302, 13),
(130203, 'Chocope', 1302, 13),
(130204, 'Magdalena de Cao', 1302, 13),
(130205, 'Paijan', 1302, 13),
(130206, 'Rázuri', 1302, 13),
(130207, 'Santiago de Cao', 1302, 13),
(130208, 'Casa Grande', 1302, 13),
(130301, 'Bolívar', 1303, 13),
(130302, 'Bambamarca', 1303, 13),
(130303, 'Condormarca', 1303, 13),
(130304, 'Longotea', 1303, 13),
(130305, 'Uchumarca', 1303, 13),
(130306, 'Ucuncha', 1303, 13),
(130401, 'Chepen', 1304, 13),
(130402, 'Pacanga', 1304, 13),
(130403, 'Pueblo Nuevo', 1304, 13),
(130501, 'Julcan', 1305, 13),
(130502, 'Calamarca', 1305, 13),
(130503, 'Carabamba', 1305, 13),
(130504, 'Huaso', 1305, 13),
(130601, 'Otuzco', 1306, 13),
(130602, 'Agallpampa', 1306, 13),
(130604, 'Charat', 1306, 13),
(130605, 'Huaranchal', 1306, 13),
(130606, 'La Cuesta', 1306, 13),
(130608, 'Mache', 1306, 13),
(130610, 'Paranday', 1306, 13),
(130611, 'Salpo', 1306, 13),
(130613, 'Sinsicap', 1306, 13),
(130614, 'Usquil', 1306, 13),
(130701, 'San Pedro de Lloc', 1307, 13),
(130702, 'Guadalupe', 1307, 13),
(130703, 'Jequetepeque', 1307, 13),
(130704, 'Pacasmayo', 1307, 13),
(130705, 'San José', 1307, 13),
(130801, 'Tayabamba', 1308, 13),
(130802, 'Buldibuyo', 1308, 13),
(130803, 'Chillia', 1308, 13),
(130804, 'Huancaspata', 1308, 13),
(130805, 'Huaylillas', 1308, 13),
(130806, 'Huayo', 1308, 13),
(130807, 'Ongon', 1308, 13),
(130808, 'Parcoy', 1308, 13),
(130809, 'Pataz', 1308, 13),
(130810, 'Pias', 1308, 13),
(130811, 'Santiago de Challas', 1308, 13),
(130812, 'Taurija', 1308, 13),
(130813, 'Urpay', 1308, 13),
(130901, 'Huamachuco', 1309, 13),
(130902, 'Chugay', 1309, 13),
(130903, 'Cochorco', 1309, 13),
(130904, 'Curgos', 1309, 13),
(130905, 'Marcabal', 1309, 13),
(130906, 'Sanagoran', 1309, 13),
(130907, 'Sarin', 1309, 13),
(130908, 'Sartimbamba', 1309, 13),
(131001, 'Santiago de Chuco', 1310, 13),
(131002, 'Angasmarca', 1310, 13),
(131003, 'Cachicadan', 1310, 13),
(131004, 'Mollebamba', 1310, 13),
(131005, 'Mollepata', 1310, 13),
(131006, 'Quiruvilca', 1310, 13),
(131007, 'Santa Cruz de Chuca', 1310, 13),
(131008, 'Sitabamba', 1310, 13),
(131101, 'Cascas', 1311, 13),
(131102, 'Lucma', 1311, 13),
(131103, 'Marmot', 1311, 13),
(131104, 'Sayapullo', 1311, 13),
(131201, 'Viru', 1312, 13),
(131202, 'Chao', 1312, 13),
(131203, 'Guadalupito', 1312, 13),
(140101, 'Chiclayo', 1401, 14),
(140102, 'Chongoyape', 1401, 14),
(140103, 'Eten', 1401, 14),
(140104, 'Eten Puerto', 1401, 14),
(140105, 'José Leonardo Ortiz', 1401, 14),
(140106, 'La Victoria', 1401, 14),
(140107, 'Lagunas', 1401, 14),
(140108, 'Monsefu', 1401, 14),
(140109, 'Nueva Arica', 1401, 14),
(140110, 'Oyotun', 1401, 14),
(140111, 'Picsi', 1401, 14),
(140112, 'Pimentel', 1401, 14),
(140113, 'Reque', 1401, 14),
(140114, 'Santa Rosa', 1401, 14),
(140115, 'Saña', 1401, 14),
(140116, 'Cayalti', 1401, 14),
(140117, 'Patapo', 1401, 14),
(140118, 'Pomalca', 1401, 14),
(140119, 'Pucala', 1401, 14),
(140120, 'Tuman', 1401, 14),
(140201, 'Ferreñafe', 1402, 14),
(140202, 'Cañaris', 1402, 14),
(140203, 'Incahuasi', 1402, 14),
(140204, 'Manuel Antonio Mesones Muro', 1402, 14),
(140205, 'Pitipo', 1402, 14),
(140206, 'Pueblo Nuevo', 1402, 14),
(140301, 'Lambayeque', 1403, 14),
(140302, 'Chochope', 1403, 14),
(140303, 'Illimo', 1403, 14),
(140304, 'Jayanca', 1403, 14),
(140305, 'Mochumi', 1403, 14),
(140306, 'Morrope', 1403, 14),
(140307, 'Motupe', 1403, 14),
(140308, 'Olmos', 1403, 14),
(140309, 'Pacora', 1403, 14),
(140310, 'Salas', 1403, 14),
(140311, 'San José', 1403, 14),
(140312, 'Tucume', 1403, 14),
(150101, 'Lima', 1501, 15),
(150102, 'Ancón', 1501, 15),
(150103, 'Ate', 1501, 15),
(150104, 'Barranco', 1501, 15),
(150105, 'Breña', 1501, 15),
(150106, 'Carabayllo', 1501, 15),
(150107, 'Chaclacayo', 1501, 15),
(150108, 'Chorrillos', 1501, 15),
(150109, 'Cieneguilla', 1501, 15),
(150110, 'Comas', 1501, 15),
(150111, 'El Agustino', 1501, 15),
(150112, 'Independencia', 1501, 15),
(150113, 'Jesús María', 1501, 15),
(150114, 'La Molina', 1501, 15),
(150115, 'La Victoria', 1501, 15),
(150116, 'Lince', 1501, 15),
(150117, 'Los Olivos', 1501, 15),
(150118, 'Lurigancho', 1501, 15),
(150119, 'Lurin', 1501, 15),
(150120, 'Magdalena del Mar', 1501, 15),
(150121, 'Pueblo Libre', 1501, 15),
(150122, 'Miraflores', 1501, 15),
(150123, 'Pachacamac', 1501, 15),
(150124, 'Pucusana', 1501, 15),
(150125, 'Puente Piedra', 1501, 15),
(150126, 'Punta Hermosa', 1501, 15),
(150127, 'Punta Negra', 1501, 15),
(150128, 'Rímac', 1501, 15),
(150129, 'San Bartolo', 1501, 15),
(150130, 'San Borja', 1501, 15),
(150131, 'San Isidro', 1501, 15),
(150132, 'San Juan de Lurigancho', 1501, 15),
(150133, 'San Juan de Miraflores', 1501, 15),
(150134, 'San Luis', 1501, 15),
(150135, 'San Martín de Porres', 1501, 15),
(150136, 'San Miguel', 1501, 15),
(150137, 'Santa Anita', 1501, 15),
(150138, 'Santa María del Mar', 1501, 15),
(150139, 'Santa Rosa', 1501, 15),
(150140, 'Santiago de Surco', 1501, 15),
(150141, 'Surquillo', 1501, 15),
(150142, 'Villa El Salvador', 1501, 15),
(150143, 'Villa María del Triunfo', 1501, 15),
(150201, 'Barranca', 1502, 15),
(150202, 'Paramonga', 1502, 15),
(150203, 'Pativilca', 1502, 15),
(150204, 'Supe', 1502, 15),
(150205, 'Supe Puerto', 1502, 15),
(150301, 'Cajatambo', 1503, 15),
(150302, 'Copa', 1503, 15),
(150303, 'Gorgor', 1503, 15),
(150304, 'Huancapon', 1503, 15),
(150305, 'Manas', 1503, 15),
(150401, 'Canta', 1504, 15),
(150402, 'Arahuay', 1504, 15),
(150403, 'Huamantanga', 1504, 15),
(150404, 'Huaros', 1504, 15),
(150405, 'Lachaqui', 1504, 15),
(150406, 'San Buenaventura', 1504, 15),
(150407, 'Santa Rosa de Quives', 1504, 15),
(150501, 'San Vicente de Cañete', 1505, 15),
(150502, 'Asia', 1505, 15),
(150503, 'Calango', 1505, 15),
(150504, 'Cerro Azul', 1505, 15),
(150505, 'Chilca', 1505, 15),
(150506, 'Coayllo', 1505, 15),
(150507, 'Imperial', 1505, 15),
(150508, 'Lunahuana', 1505, 15),
(150509, 'Mala', 1505, 15),
(150510, 'Nuevo Imperial', 1505, 15),
(150511, 'Pacaran', 1505, 15),
(150512, 'Quilmana', 1505, 15),
(150513, 'San Antonio', 1505, 15),
(150514, 'San Luis', 1505, 15),
(150515, 'Santa Cruz de Flores', 1505, 15),
(150516, 'Zúñiga', 1505, 15),
(150601, 'Huaral', 1506, 15),
(150602, 'Atavillos Alto', 1506, 15),
(150603, 'Atavillos Bajo', 1506, 15),
(150604, 'Aucallama', 1506, 15),
(150605, 'Chancay', 1506, 15),
(150606, 'Ihuari', 1506, 15),
(150607, 'Lampian', 1506, 15),
(150608, 'Pacaraos', 1506, 15),
(150609, 'San Miguel de Acos', 1506, 15),
(150610, 'Santa Cruz de Andamarca', 1506, 15),
(150611, 'Sumbilca', 1506, 15),
(150612, 'Veintisiete de Noviembre', 1506, 15),
(150701, 'Matucana', 1507, 15),
(150702, 'Antioquia', 1507, 15),
(150703, 'Callahuanca', 1507, 15),
(150704, 'Carampoma', 1507, 15),
(150705, 'Chicla', 1507, 15),
(150706, 'Cuenca', 1507, 15),
(150707, 'Huachupampa', 1507, 15),
(150708, 'Huanza', 1507, 15),
(150709, 'Huarochiri', 1507, 15),
(150710, 'Lahuaytambo', 1507, 15),
(150711, 'Langa', 1507, 15),
(150712, 'Laraos', 1507, 15),
(150713, 'Mariatana', 1507, 15),
(150714, 'Ricardo Palma', 1507, 15),
(150715, 'San Andrés de Tupicocha', 1507, 15),
(150716, 'San Antonio', 1507, 15),
(150717, 'San Bartolomé', 1507, 15),
(150718, 'San Damian', 1507, 15),
(150719, 'San Juan de Iris', 1507, 15),
(150720, 'San Juan de Tantaranche', 1507, 15),
(150721, 'San Lorenzo de Quinti', 1507, 15),
(150722, 'San Mateo', 1507, 15),
(150723, 'San Mateo de Otao', 1507, 15),
(150724, 'San Pedro de Casta', 1507, 15),
(150725, 'San Pedro de Huancayre', 1507, 15),
(150726, 'Sangallaya', 1507, 15),
(150727, 'Santa Cruz de Cocachacra', 1507, 15),
(150728, 'Santa Eulalia', 1507, 15),
(150729, 'Santiago de Anchucaya', 1507, 15),
(150730, 'Santiago de Tuna', 1507, 15),
(150731, 'Santo Domingo de Los Olleros', 1507, 15),
(150732, 'Surco', 1507, 15),
(150801, 'Huacho', 1508, 15),
(150802, 'Ambar', 1508, 15),
(150803, 'Caleta de Carquin', 1508, 15),
(150804, 'Checras', 1508, 15),
(150805, 'Hualmay', 1508, 15),
(150806, 'Huaura', 1508, 15),
(150807, 'Leoncio Prado', 1508, 15),
(150808, 'Paccho', 1508, 15),
(150809, 'Santa Leonor', 1508, 15),
(150810, 'Santa María', 1508, 15),
(150811, 'Sayan', 1508, 15),
(150812, 'Vegueta', 1508, 15),
(150901, 'Oyon', 1509, 15),
(150902, 'Andajes', 1509, 15),
(150903, 'Caujul', 1509, 15),
(150904, 'Cochamarca', 1509, 15),
(150905, 'Navan', 1509, 15),
(150906, 'Pachangara', 1509, 15),
(151001, 'Yauyos', 1510, 15),
(151002, 'Alis', 1510, 15),
(151003, 'Allauca', 1510, 15),
(151004, 'Ayaviri', 1510, 15),
(151005, 'Azángaro', 1510, 15),
(151006, 'Cacra', 1510, 15),
(151007, 'Carania', 1510, 15),
(151008, 'Catahuasi', 1510, 15),
(151009, 'Chocos', 1510, 15),
(151010, 'Cochas', 1510, 15),
(151011, 'Colonia', 1510, 15),
(151012, 'Hongos', 1510, 15),
(151013, 'Huampara', 1510, 15),
(151014, 'Huancaya', 1510, 15),
(151015, 'Huangascar', 1510, 15),
(151016, 'Huantan', 1510, 15),
(151017, 'Huañec', 1510, 15),
(151018, 'Laraos', 1510, 15),
(151019, 'Lincha', 1510, 15),
(151020, 'Madean', 1510, 15),
(151021, 'Miraflores', 1510, 15),
(151022, 'Omas', 1510, 15),
(151023, 'Putinza', 1510, 15),
(151024, 'Quinches', 1510, 15),
(151025, 'Quinocay', 1510, 15),
(151026, 'San Joaquín', 1510, 15),
(151027, 'San Pedro de Pilas', 1510, 15),
(151028, 'Tanta', 1510, 15),
(151029, 'Tauripampa', 1510, 15),
(151030, 'Tomas', 1510, 15),
(151031, 'Tupe', 1510, 15),
(151032, 'Viñac', 1510, 15),
(151033, 'Vitis', 1510, 15),
(160101, 'Iquitos', 1601, 16),
(160102, 'Alto Nanay', 1601, 16),
(160103, 'Fernando Lores', 1601, 16),
(160104, 'Indiana', 1601, 16),
(160105, 'Las Amazonas', 1601, 16),
(160106, 'Mazan', 1601, 16),
(160107, 'Napo', 1601, 16),
(160108, 'Punchana', 1601, 16),
(160110, 'Torres Causana', 1601, 16),
(160112, 'Belén', 1601, 16),
(160113, 'San Juan Bautista', 1601, 16),
(160201, 'Yurimaguas', 1602, 16),
(160202, 'Balsapuerto', 1602, 16),
(160205, 'Jeberos', 1602, 16),
(160206, 'Lagunas', 1602, 16),
(160210, 'Santa Cruz', 1602, 16),
(160211, 'Teniente Cesar López Rojas', 1602, 16),
(160301, 'Nauta', 1603, 16),
(160302, 'Parinari', 1603, 16),
(160303, 'Tigre', 1603, 16),
(160304, 'Trompeteros', 1603, 16),
(160305, 'Urarinas', 1603, 16),
(160401, 'Ramón Castilla', 1604, 16),
(160402, 'Pebas', 1604, 16),
(160403, 'Yavari', 1604, 16),
(160404, 'San Pablo', 1604, 16),
(160501, 'Requena', 1605, 16),
(160502, 'Alto Tapiche', 1605, 16),
(160503, 'Capelo', 1605, 16),
(160504, 'Emilio San Martín', 1605, 16),
(160505, 'Maquia', 1605, 16),
(160506, 'Puinahua', 1605, 16),
(160507, 'Saquena', 1605, 16),
(160508, 'Soplin', 1605, 16),
(160509, 'Tapiche', 1605, 16),
(160510, 'Jenaro Herrera', 1605, 16),
(160511, 'Yaquerana', 1605, 16),
(160601, 'Contamana', 1606, 16),
(160602, 'Inahuaya', 1606, 16),
(160603, 'Padre Márquez', 1606, 16),
(160604, 'Pampa Hermosa', 1606, 16),
(160605, 'Sarayacu', 1606, 16),
(160606, 'Vargas Guerra', 1606, 16),
(160701, 'Barranca', 1607, 16),
(160702, 'Cahuapanas', 1607, 16),
(160703, 'Manseriche', 1607, 16),
(160704, 'Morona', 1607, 16),
(160705, 'Pastaza', 1607, 16),
(160706, 'Andoas', 1607, 16),
(160801, 'Putumayo', 1608, 16),
(160802, 'Rosa Panduro', 1608, 16),
(160803, 'Teniente Manuel Clavero', 1608, 16),
(160804, 'Yaguas', 1608, 16),
(170101, 'Tambopata', 1701, 17),
(170102, 'Inambari', 1701, 17),
(170103, 'Las Piedras', 1701, 17),
(170104, 'Laberinto', 1701, 17),
(170201, 'Manu', 1702, 17),
(170202, 'Fitzcarrald', 1702, 17),
(170203, 'Madre de Dios', 1702, 17),
(170204, 'Huepetuhe', 1702, 17),
(170301, 'Iñapari', 1703, 17),
(170302, 'Iberia', 1703, 17),
(170303, 'Tahuamanu', 1703, 17),
(180101, 'Moquegua', 1801, 18),
(180102, 'Carumas', 1801, 18),
(180103, 'Cuchumbaya', 1801, 18),
(180104, 'Samegua', 1801, 18),
(180105, 'San Cristóbal', 1801, 18),
(180106, 'Torata', 1801, 18),
(180201, 'Omate', 1802, 18),
(180202, 'Chojata', 1802, 18),
(180203, 'Coalaque', 1802, 18),
(180204, 'Ichuña', 1802, 18),
(180205, 'La Capilla', 1802, 18),
(180206, 'Lloque', 1802, 18),
(180207, 'Matalaque', 1802, 18),
(180208, 'Puquina', 1802, 18),
(180209, 'Quinistaquillas', 1802, 18),
(180210, 'Ubinas', 1802, 18),
(180211, 'Yunga', 1802, 18),
(180301, 'Ilo', 1803, 18),
(180302, 'El Algarrobal', 1803, 18),
(180303, 'Pacocha', 1803, 18),
(190101, 'Chaupimarca', 1901, 19),
(190102, 'Huachon', 1901, 19),
(190103, 'Huariaca', 1901, 19),
(190104, 'Huayllay', 1901, 19),
(190105, 'Ninacaca', 1901, 19),
(190106, 'Pallanchacra', 1901, 19),
(190107, 'Paucartambo', 1901, 19),
(190108, 'San Francisco de Asís de Yarusyacan', 1901, 19),
(190109, 'Simon Bolívar', 1901, 19),
(190110, 'Ticlacayan', 1901, 19),
(190111, 'Tinyahuarco', 1901, 19),
(190112, 'Vicco', 1901, 19),
(190113, 'Yanacancha', 1901, 19),
(190201, 'Yanahuanca', 1902, 19),
(190202, 'Chacayan', 1902, 19),
(190203, 'Goyllarisquizga', 1902, 19),
(190204, 'Paucar', 1902, 19),
(190205, 'San Pedro de Pillao', 1902, 19),
(190206, 'Santa Ana de Tusi', 1902, 19),
(190207, 'Tapuc', 1902, 19),
(190208, 'Vilcabamba', 1902, 19),
(190301, 'Oxapampa', 1903, 19),
(190302, 'Chontabamba', 1903, 19),
(190303, 'Huancabamba', 1903, 19),
(190304, 'Palcazu', 1903, 19),
(190305, 'Pozuzo', 1903, 19),
(190306, 'Puerto Bermúdez', 1903, 19),
(190307, 'Villa Rica', 1903, 19),
(190308, 'Constitución', 1903, 19),
(200101, 'Piura', 2001, 20),
(200104, 'Castilla', 2001, 20),
(200105, 'Catacaos', 2001, 20),
(200107, 'Cura Mori', 2001, 20),
(200108, 'El Tallan', 2001, 20),
(200109, 'La Arena', 2001, 20),
(200110, 'La Unión', 2001, 20),
(200111, 'Las Lomas', 2001, 20),
(200114, 'Tambo Grande', 2001, 20),
(200115, 'Veintiseis de Octubre', 2001, 20),
(200201, 'Ayabaca', 2002, 20),
(200202, 'Frias', 2002, 20),
(200203, 'Jilili', 2002, 20),
(200204, 'Lagunas', 2002, 20),
(200205, 'Montero', 2002, 20),
(200206, 'Pacaipampa', 2002, 20),
(200207, 'Paimas', 2002, 20),
(200208, 'Sapillica', 2002, 20),
(200209, 'Sicchez', 2002, 20),
(200210, 'Suyo', 2002, 20),
(200301, 'Huancabamba', 2003, 20),
(200302, 'Canchaque', 2003, 20),
(200303, 'El Carmen de la Frontera', 2003, 20),
(200304, 'Huarmaca', 2003, 20),
(200305, 'Lalaquiz', 2003, 20),
(200306, 'San Miguel de El Faique', 2003, 20),
(200307, 'Sondor', 2003, 20),
(200308, 'Sondorillo', 2003, 20),
(200401, 'Chulucanas', 2004, 20),
(200402, 'Buenos Aires', 2004, 20),
(200403, 'Chalaco', 2004, 20),
(200404, 'La Matanza', 2004, 20),
(200405, 'Morropon', 2004, 20),
(200406, 'Salitral', 2004, 20),
(200407, 'San Juan de Bigote', 2004, 20),
(200408, 'Santa Catalina de Mossa', 2004, 20),
(200409, 'Santo Domingo', 2004, 20),
(200410, 'Yamango', 2004, 20),
(200501, 'Paita', 2005, 20),
(200502, 'Amotape', 2005, 20),
(200503, 'Arenal', 2005, 20),
(200504, 'Colan', 2005, 20),
(200505, 'La Huaca', 2005, 20),
(200506, 'Tamarindo', 2005, 20),
(200507, 'Vichayal', 2005, 20),
(200601, 'Sullana', 2006, 20),
(200602, 'Bellavista', 2006, 20),
(200603, 'Ignacio Escudero', 2006, 20),
(200604, 'Lancones', 2006, 20),
(200605, 'Marcavelica', 2006, 20),
(200606, 'Miguel Checa', 2006, 20),
(200607, 'Querecotillo', 2006, 20),
(200608, 'Salitral', 2006, 20),
(200701, 'Pariñas', 2007, 20),
(200702, 'El Alto', 2007, 20),
(200703, 'La Brea', 2007, 20),
(200704, 'Lobitos', 2007, 20),
(200705, 'Los Organos', 2007, 20),
(200706, 'Mancora', 2007, 20),
(200801, 'Sechura', 2008, 20),
(200802, 'Bellavista de la Unión', 2008, 20),
(200803, 'Bernal', 2008, 20),
(200804, 'Cristo Nos Valga', 2008, 20),
(200805, 'Vice', 2008, 20),
(200806, 'Rinconada Llicuar', 2008, 20),
(210101, 'Puno', 2101, 21),
(210102, 'Acora', 2101, 21),
(210103, 'Amantani', 2101, 21),
(210104, 'Atuncolla', 2101, 21),
(210105, 'Capachica', 2101, 21),
(210106, 'Chucuito', 2101, 21),
(210107, 'Coata', 2101, 21),
(210108, 'Huata', 2101, 21),
(210109, 'Mañazo', 2101, 21),
(210110, 'Paucarcolla', 2101, 21),
(210111, 'Pichacani', 2101, 21),
(210112, 'Plateria', 2101, 21),
(210113, 'San Antonio', 2101, 21),
(210114, 'Tiquillaca', 2101, 21),
(210115, 'Vilque', 2101, 21),
(210201, 'Azángaro', 2102, 21),
(210202, 'Achaya', 2102, 21),
(210203, 'Arapa', 2102, 21),
(210204, 'Asillo', 2102, 21),
(210205, 'Caminaca', 2102, 21),
(210206, 'Chupa', 2102, 21),
(210207, 'José Domingo Choquehuanca', 2102, 21),
(210208, 'Muñani', 2102, 21),
(210209, 'Potoni', 2102, 21),
(210210, 'Saman', 2102, 21),
(210211, 'San Anton', 2102, 21),
(210212, 'San José', 2102, 21),
(210213, 'San Juan de Salinas', 2102, 21),
(210214, 'Santiago de Pupuja', 2102, 21),
(210215, 'Tirapata', 2102, 21),
(210301, 'Macusani', 2103, 21),
(210302, 'Ajoyani', 2103, 21),
(210303, 'Ayapata', 2103, 21),
(210304, 'Coasa', 2103, 21),
(210305, 'Corani', 2103, 21),
(210306, 'Crucero', 2103, 21),
(210307, 'Ituata', 2103, 21),
(210308, 'Ollachea', 2103, 21),
(210309, 'San Gaban', 2103, 21),
(210310, 'Usicayos', 2103, 21),
(210401, 'Juli', 2104, 21),
(210402, 'Desaguadero', 2104, 21),
(210403, 'Huacullani', 2104, 21),
(210404, 'Kelluyo', 2104, 21),
(210405, 'Pisacoma', 2104, 21),
(210406, 'Pomata', 2104, 21),
(210407, 'Zepita', 2104, 21),
(210501, 'Ilave', 2105, 21),
(210502, 'Capazo', 2105, 21),
(210503, 'Pilcuyo', 2105, 21),
(210504, 'Santa Rosa', 2105, 21),
(210505, 'Conduriri', 2105, 21),
(210601, 'Huancane', 2106, 21);
INSERT INTO `ubigeo_distritos` (`id_distrito`, `nombre_distrito`, `id_provincia`, `id_departamento`) VALUES
(210602, 'Cojata', 2106, 21),
(210603, 'Huatasani', 2106, 21),
(210604, 'Inchupalla', 2106, 21),
(210605, 'Pusi', 2106, 21),
(210606, 'Rosaspata', 2106, 21),
(210607, 'Taraco', 2106, 21),
(210608, 'Vilque Chico', 2106, 21),
(210701, 'Lampa', 2107, 21),
(210702, 'Cabanilla', 2107, 21),
(210703, 'Calapuja', 2107, 21),
(210704, 'Nicasio', 2107, 21),
(210705, 'Ocuviri', 2107, 21),
(210706, 'Palca', 2107, 21),
(210707, 'Paratia', 2107, 21),
(210708, 'Pucara', 2107, 21),
(210709, 'Santa Lucia', 2107, 21),
(210710, 'Vilavila', 2107, 21),
(210801, 'Ayaviri', 2108, 21),
(210802, 'Antauta', 2108, 21),
(210803, 'Cupi', 2108, 21),
(210804, 'Llalli', 2108, 21),
(210805, 'Macari', 2108, 21),
(210806, 'Nuñoa', 2108, 21),
(210807, 'Orurillo', 2108, 21),
(210808, 'Santa Rosa', 2108, 21),
(210809, 'Umachiri', 2108, 21),
(210901, 'Moho', 2109, 21),
(210902, 'Conima', 2109, 21),
(210903, 'Huayrapata', 2109, 21),
(210904, 'Tilali', 2109, 21),
(211001, 'Putina', 2110, 21),
(211002, 'Ananea', 2110, 21),
(211003, 'Pedro Vilca Apaza', 2110, 21),
(211004, 'Quilcapuncu', 2110, 21),
(211005, 'Sina', 2110, 21),
(211101, 'Juliaca', 2111, 21),
(211102, 'Cabana', 2111, 21),
(211103, 'Cabanillas', 2111, 21),
(211104, 'Caracoto', 2111, 21),
(211105, 'San Miguel', 2111, 21),
(211201, 'Sandia', 2112, 21),
(211202, 'Cuyocuyo', 2112, 21),
(211203, 'Limbani', 2112, 21),
(211204, 'Patambuco', 2112, 21),
(211205, 'Phara', 2112, 21),
(211206, 'Quiaca', 2112, 21),
(211207, 'San Juan del Oro', 2112, 21),
(211208, 'Yanahuaya', 2112, 21),
(211209, 'Alto Inambari', 2112, 21),
(211210, 'San Pedro de Putina Punco', 2112, 21),
(211301, 'Yunguyo', 2113, 21),
(211302, 'Anapia', 2113, 21),
(211303, 'Copani', 2113, 21),
(211304, 'Cuturapi', 2113, 21),
(211305, 'Ollaraya', 2113, 21),
(211306, 'Tinicachi', 2113, 21),
(211307, 'Unicachi', 2113, 21),
(220101, 'Moyobamba', 2201, 22),
(220102, 'Calzada', 2201, 22),
(220103, 'Habana', 2201, 22),
(220104, 'Jepelacio', 2201, 22),
(220105, 'Soritor', 2201, 22),
(220106, 'Yantalo', 2201, 22),
(220201, 'Bellavista', 2202, 22),
(220202, 'Alto Biavo', 2202, 22),
(220203, 'Bajo Biavo', 2202, 22),
(220204, 'Huallaga', 2202, 22),
(220205, 'San Pablo', 2202, 22),
(220206, 'San Rafael', 2202, 22),
(220301, 'San José de Sisa', 2203, 22),
(220302, 'Agua Blanca', 2203, 22),
(220303, 'San Martín', 2203, 22),
(220304, 'Santa Rosa', 2203, 22),
(220305, 'Shatoja', 2203, 22),
(220401, 'Saposoa', 2204, 22),
(220402, 'Alto Saposoa', 2204, 22),
(220403, 'El Eslabón', 2204, 22),
(220404, 'Piscoyacu', 2204, 22),
(220405, 'Sacanche', 2204, 22),
(220406, 'Tingo de Saposoa', 2204, 22),
(220501, 'Lamas', 2205, 22),
(220502, 'Alonso de Alvarado', 2205, 22),
(220503, 'Barranquita', 2205, 22),
(220504, 'Caynarachi', 2205, 22),
(220505, 'Cuñumbuqui', 2205, 22),
(220506, 'Pinto Recodo', 2205, 22),
(220507, 'Rumisapa', 2205, 22),
(220508, 'San Roque de Cumbaza', 2205, 22),
(220509, 'Shanao', 2205, 22),
(220510, 'Tabalosos', 2205, 22),
(220511, 'Zapatero', 2205, 22),
(220601, 'Juanjuí', 2206, 22),
(220602, 'Campanilla', 2206, 22),
(220603, 'Huicungo', 2206, 22),
(220604, 'Pachiza', 2206, 22),
(220605, 'Pajarillo', 2206, 22),
(220701, 'Picota', 2207, 22),
(220702, 'Buenos Aires', 2207, 22),
(220703, 'Caspisapa', 2207, 22),
(220704, 'Pilluana', 2207, 22),
(220705, 'Pucacaca', 2207, 22),
(220706, 'San Cristóbal', 2207, 22),
(220707, 'San Hilarión', 2207, 22),
(220708, 'Shamboyacu', 2207, 22),
(220709, 'Tingo de Ponasa', 2207, 22),
(220710, 'Tres Unidos', 2207, 22),
(220801, 'Rioja', 2208, 22),
(220802, 'Awajun', 2208, 22),
(220803, 'Elías Soplin Vargas', 2208, 22),
(220804, 'Nueva Cajamarca', 2208, 22),
(220805, 'Pardo Miguel', 2208, 22),
(220806, 'Posic', 2208, 22),
(220807, 'San Fernando', 2208, 22),
(220808, 'Yorongos', 2208, 22),
(220809, 'Yuracyacu', 2208, 22),
(220901, 'Tarapoto', 2209, 22),
(220902, 'Alberto Leveau', 2209, 22),
(220903, 'Cacatachi', 2209, 22),
(220904, 'Chazuta', 2209, 22),
(220905, 'Chipurana', 2209, 22),
(220906, 'El Porvenir', 2209, 22),
(220907, 'Huimbayoc', 2209, 22),
(220908, 'Juan Guerra', 2209, 22),
(220909, 'La Banda de Shilcayo', 2209, 22),
(220910, 'Morales', 2209, 22),
(220911, 'Papaplaya', 2209, 22),
(220912, 'San Antonio', 2209, 22),
(220913, 'Sauce', 2209, 22),
(220914, 'Shapaja', 2209, 22),
(221001, 'Tocache', 2210, 22),
(221002, 'Nuevo Progreso', 2210, 22),
(221003, 'Polvora', 2210, 22),
(221004, 'Shunte', 2210, 22),
(221005, 'Uchiza', 2210, 22),
(230101, 'Tacna', 2301, 23),
(230102, 'Alto de la Alianza', 2301, 23),
(230103, 'Calana', 2301, 23),
(230104, 'Ciudad Nueva', 2301, 23),
(230105, 'Inclan', 2301, 23),
(230106, 'Pachia', 2301, 23),
(230107, 'Palca', 2301, 23),
(230108, 'Pocollay', 2301, 23),
(230109, 'Sama', 2301, 23),
(230110, 'Coronel Gregorio Albarracín Lanchipa', 2301, 23),
(230111, 'La Yarada los Palos', 2301, 23),
(230201, 'Candarave', 2302, 23),
(230202, 'Cairani', 2302, 23),
(230203, 'Camilaca', 2302, 23),
(230204, 'Curibaya', 2302, 23),
(230205, 'Huanuara', 2302, 23),
(230206, 'Quilahuani', 2302, 23),
(230301, 'Locumba', 2303, 23),
(230302, 'Ilabaya', 2303, 23),
(230303, 'Ite', 2303, 23),
(230401, 'Tarata', 2304, 23),
(230402, 'Héroes Albarracín', 2304, 23),
(230403, 'Estique', 2304, 23),
(230404, 'Estique-Pampa', 2304, 23),
(230405, 'Sitajara', 2304, 23),
(230406, 'Susapaya', 2304, 23),
(230407, 'Tarucachi', 2304, 23),
(230408, 'Ticaco', 2304, 23),
(240101, 'Tumbes', 2401, 24),
(240102, 'Corrales', 2401, 24),
(240103, 'La Cruz', 2401, 24),
(240104, 'Pampas de Hospital', 2401, 24),
(240105, 'San Jacinto', 2401, 24),
(240106, 'San Juan de la Virgen', 2401, 24),
(240201, 'Zorritos', 2402, 24),
(240202, 'Casitas', 2402, 24),
(240203, 'Canoas de Punta Sal', 2402, 24),
(240301, 'Zarumilla', 2403, 24),
(240302, 'Aguas Verdes', 2403, 24),
(240303, 'Matapalo', 2403, 24),
(240304, 'Papayal', 2403, 24),
(250101, 'Calleria', 2501, 25),
(250102, 'Campoverde', 2501, 25),
(250103, 'Iparia', 2501, 25),
(250104, 'Masisea', 2501, 25),
(250105, 'Yarinacocha', 2501, 25),
(250106, 'Nueva Requena', 2501, 25),
(250107, 'Manantay', 2501, 25),
(250201, 'Raymondi', 2502, 25),
(250202, 'Sepahua', 2502, 25),
(250203, 'Tahuania', 2502, 25),
(250204, 'Yurua', 2502, 25),
(250301, 'Padre Abad', 2503, 25),
(250302, 'Irazola', 2503, 25),
(250303, 'Curimana', 2503, 25),
(250304, 'Neshuya', 2503, 25),
(250305, 'Alexander Von Humboldt', 2503, 25),
(250401, 'Purus', 2504, 25);

-- --------------------------------------------------------

--
-- Table structure for table `ubigeo_provincias`
--

CREATE TABLE `ubigeo_provincias` (
  `id_provincia` int UNSIGNED NOT NULL,
  `nombre_provincia` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_departamento` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ubigeo_provincias`
--

INSERT INTO `ubigeo_provincias` (`id_provincia`, `nombre_provincia`, `id_departamento`) VALUES
(101, 'Chachapoyas', 1),
(102, 'Bagua', 1),
(103, 'Bongará', 1),
(104, 'Condorcanqui', 1),
(105, 'Luya', 1),
(106, 'Rodríguez de Mendoza', 1),
(107, 'Utcubamba', 1),
(201, 'Huaraz', 2),
(202, 'Aija', 2),
(203, 'Antonio Raymondi', 2),
(204, 'Asunción', 2),
(205, 'Bolognesi', 2),
(206, 'Carhuaz', 2),
(207, 'Carlos Fermín Fitzcarrald', 2),
(208, 'Casma', 2),
(209, 'Corongo', 2),
(210, 'Huari', 2),
(211, 'Huarmey', 2),
(212, 'Huaylas', 2),
(213, 'Mariscal Luzuriaga', 2),
(214, 'Ocros', 2),
(215, 'Pallasca', 2),
(216, 'Pomabamba', 2),
(217, 'Recuay', 2),
(218, 'Santa', 2),
(219, 'Sihuas', 2),
(220, 'Yungay', 2),
(301, 'Abancay', 3),
(302, 'Andahuaylas', 3),
(303, 'Antabamba', 3),
(304, 'Aymaraes', 3),
(305, 'Cotabambas', 3),
(306, 'Chincheros', 3),
(307, 'Grau', 3),
(401, 'Arequipa', 4),
(402, 'Camaná', 4),
(403, 'Caravelí', 4),
(404, 'Castilla', 4),
(405, 'Caylloma', 4),
(406, 'Condesuyos', 4),
(407, 'Islay', 4),
(408, 'La Uniòn', 4),
(501, 'Huamanga', 5),
(502, 'Cangallo', 5),
(503, 'Huanca Sancos', 5),
(504, 'Huanta', 5),
(505, 'La Mar', 5),
(506, 'Lucanas', 5),
(507, 'Parinacochas', 5),
(508, 'Pàucar del Sara Sara', 5),
(509, 'Sucre', 5),
(510, 'Víctor Fajardo', 5),
(511, 'Vilcas Huamán', 5),
(601, 'Cajamarca', 6),
(602, 'Cajabamba', 6),
(603, 'Celendín', 6),
(604, 'Chota', 6),
(605, 'Contumazá', 6),
(606, 'Cutervo', 6),
(607, 'Hualgayoc', 6),
(608, 'Jaén', 6),
(609, 'San Ignacio', 6),
(610, 'San Marcos', 6),
(611, 'San Miguel', 6),
(612, 'San Pablo', 6),
(613, 'Santa Cruz', 6),
(701, 'Prov. Const. del Callao', 7),
(801, 'Cusco', 8),
(802, 'Acomayo', 8),
(803, 'Anta', 8),
(804, 'Calca', 8),
(805, 'Canas', 8),
(806, 'Canchis', 8),
(807, 'Chumbivilcas', 8),
(808, 'Espinar', 8),
(809, 'La Convención', 8),
(810, 'Paruro', 8),
(811, 'Paucartambo', 8),
(812, 'Quispicanchi', 8),
(813, 'Urubamba', 8),
(901, 'Huancavelica', 9),
(902, 'Acobamba', 9),
(903, 'Angaraes', 9),
(904, 'Castrovirreyna', 9),
(905, 'Churcampa', 9),
(906, 'Huaytará', 9),
(907, 'Tayacaja', 9),
(1001, 'Huánuco', 10),
(1002, 'Ambo', 10),
(1003, 'Dos de Mayo', 10),
(1004, 'Huacaybamba', 10),
(1005, 'Huamalíes', 10),
(1006, 'Leoncio Prado', 10),
(1007, 'Marañón', 10),
(1008, 'Pachitea', 10),
(1009, 'Puerto Inca', 10),
(1010, 'Lauricocha ', 10),
(1011, 'Yarowilca ', 10),
(1101, 'Ica ', 11),
(1102, 'Chincha ', 11),
(1103, 'Nasca ', 11),
(1104, 'Palpa ', 11),
(1105, 'Pisco ', 11),
(1201, 'Huancayo ', 12),
(1202, 'Concepción ', 12),
(1203, 'Chanchamayo ', 12),
(1204, 'Jauja ', 12),
(1205, 'Junín ', 12),
(1206, 'Satipo ', 12),
(1207, 'Tarma ', 12),
(1208, 'Yauli ', 12),
(1209, 'Chupaca ', 12),
(1301, 'Trujillo ', 13),
(1302, 'Ascope ', 13),
(1303, 'Bolívar ', 13),
(1304, 'Chepén ', 13),
(1305, 'Julcán ', 13),
(1306, 'Otuzco ', 13),
(1307, 'Pacasmayo ', 13),
(1308, 'Pataz ', 13),
(1309, 'Sánchez Carrión ', 13),
(1310, 'Santiago de Chuco ', 13),
(1311, 'Gran Chimú ', 13),
(1312, 'Virú ', 13),
(1401, 'Chiclayo ', 14),
(1402, 'Ferreñafe ', 14),
(1403, 'Lambayeque ', 14),
(1501, 'Lima ', 15),
(1502, 'Barranca ', 15),
(1503, 'Cajatambo ', 15),
(1504, 'Canta ', 15),
(1505, 'Cañete ', 15),
(1506, 'Huaral ', 15),
(1507, 'Huarochirí ', 15),
(1508, 'Huaura ', 15),
(1509, 'Oyón ', 15),
(1510, 'Yauyos ', 15),
(1601, 'Maynas ', 16),
(1602, 'Alto Amazonas ', 16),
(1603, 'Loreto ', 16),
(1604, 'Mariscal Ramón Castilla ', 16),
(1605, 'Requena ', 16),
(1606, 'Ucayali ', 16),
(1607, 'Datem del Marañón ', 16),
(1608, 'Putumayo', 16),
(1701, 'Tambopata ', 17),
(1702, 'Manu ', 17),
(1703, 'Tahuamanu ', 17),
(1801, 'Mariscal Nieto ', 18),
(1802, 'General Sánchez Cerro ', 18),
(1803, 'Ilo ', 18),
(1901, 'Pasco ', 19),
(1902, 'Daniel Alcides Carrión ', 19),
(1903, 'Oxapampa ', 19),
(2001, 'Piura ', 20),
(2002, 'Ayabaca ', 20),
(2003, 'Huancabamba ', 20),
(2004, 'Morropón ', 20),
(2005, 'Paita ', 20),
(2006, 'Sullana ', 20),
(2007, 'Talara ', 20),
(2008, 'Sechura ', 20),
(2101, 'Puno ', 21),
(2102, 'Azángaro ', 21),
(2103, 'Carabaya ', 21),
(2104, 'Chucuito ', 21),
(2105, 'El Collao ', 21),
(2106, 'Huancané ', 21),
(2107, 'Lampa ', 21),
(2108, 'Melgar ', 21),
(2109, 'Moho ', 21),
(2110, 'San Antonio de Putina ', 21),
(2111, 'San Román ', 21),
(2112, 'Sandia ', 21),
(2113, 'Yunguyo ', 21),
(2201, 'Moyobamba ', 22),
(2202, 'Bellavista ', 22),
(2203, 'El Dorado ', 22),
(2204, 'Huallaga ', 22),
(2205, 'Lamas ', 22),
(2206, 'Mariscal Cáceres ', 22),
(2207, 'Picota ', 22),
(2208, 'Rioja ', 22),
(2209, 'San Martín ', 22),
(2210, 'Tocache ', 22),
(2301, 'Tacna ', 23),
(2302, 'Candarave ', 23),
(2303, 'Jorge Basadre ', 23),
(2304, 'Tarata ', 23),
(2401, 'Tumbes ', 24),
(2402, 'Contralmirante Villar ', 24),
(2403, 'Zarumilla ', 24),
(2501, 'Coronel Portillo ', 25),
(2502, 'Atalaya ', 25),
(2503, 'Padre Abad ', 25),
(2504, 'Purús', 25);

-- --------------------------------------------------------

--
-- Table structure for table `unidades_medida`
--

CREATE TABLE `unidades_medida` (
  `id_unidad_medida` int UNSIGNED NOT NULL,
  `nombre_unidad_medida` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_sunat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unidades_medida`
--

INSERT INTO `unidades_medida` (`id_unidad_medida`, `nombre_unidad_medida`, `codigo_sunat`) VALUES
(1, 'UND', 'NIU'),
(2, 'PAR', 'PR'),
(3, 'SERVICIO', 'ZZ');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `id_role` bigint UNSIGNED NOT NULL,
  `id_sucursal` int UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `id_role`, `id_sucursal`, `name`, `email`, `email_verified_at`, `password`, `estado`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 1, 2, 'admin@gmail.com', 'admin@gmail.com', NULL, '$2y$10$N7jnQemyVnN/b3jZpd0Lz.Cym4Drpb793Q6SmQncT2EO0L0VLzV6S', 1, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `afectacion_igv`
--
ALTER TABLE `afectacion_igv`
  ADD PRIMARY KEY (`cod_afectacion`);

--
-- Indexes for table `almacen_movimientos`
--
ALTER TABLE `almacen_movimientos`
  ADD PRIMARY KEY (`id_almacen_movimientos`),
  ADD KEY `FK_almacen_movimientos_tipo_idx` (`id_tipo_movimiento`),
  ADD KEY `FK_almacen_movimientos_producto_idx` (`id_producto`),
  ADD KEY `FK_almacen_movimientos_sucursal_idx` (`id_sucursal`);

--
-- Indexes for table `almacen_movimientos_tipos`
--
ALTER TABLE `almacen_movimientos_tipos`
  ADD PRIMARY KEY (`id_tipo_movimiento`);

--
-- Indexes for table `anamnesis`
--
ALTER TABLE `anamnesis`
  ADD PRIMARY KEY (`id_anamnesis`),
  ADD KEY `FK_cliente_anamnesis_idx` (`id_cliente`),
  ADD KEY `FK_sucursal_anamnesis_idx` (`id_sucursal`),
  ADD KEY `FK_clinica_anamnesis_idx` (`id_clinica`),
  ADD KEY `FK_doctor_anamnesis_idx` (`id_doctor`),
  ADD KEY `FK_empresa_convenio_anamnesis_idx` (`id_empresa_convenio`);

--
-- Indexes for table `anamnesis_estados_historico`
--
ALTER TABLE `anamnesis_estados_historico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_anamnesis_estados_historico_id_anamnesis_idx` (`anamnesis_id`),
  ADD KEY `FK_anamnesis_estados_historico_id_user_idx` (`user_id`);

--
-- Indexes for table `caja`
--
ALTER TABLE `caja`
  ADD PRIMARY KEY (`id_caja`);

--
-- Indexes for table `caja_cuadre`
--
ALTER TABLE `caja_cuadre`
  ADD PRIMARY KEY (`id_cuadre`),
  ADD KEY `id_caja` (`id_caja`),
  ADD KEY `id_estado` (`id_estado`);

--
-- Indexes for table `caja_cuadre_estado`
--
ALTER TABLE `caja_cuadre_estado`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indexes for table `caja_turnos`
--
ALTER TABLE `caja_turnos`
  ADD PRIMARY KEY (`id_caja_turno`);

--
-- Indexes for table `calendario_feriados`
--
ALTER TABLE `calendario_feriados`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `campanas`
--
ALTER TABLE `campanas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `FK_codigo_doc_cliente_idx` (`cod_tipo_doc`),
  ADD KEY `FK_ruburos_cliente_idx` (`id_rubro_trabajo`),
  ADD KEY `FK_ocupacion_cliente_idx` (`id_ocupacion`),
  ADD KEY `FK_distrito_cliente_idx` (`id_distrito`),
  ADD KEY `FK_provincia_cliente_idx` (`id_provincia`),
  ADD KEY `FK_departamento_cliente_idx` (`id_departamento`);

--
-- Indexes for table `clinicas`
--
ALTER TABLE `clinicas`
  ADD PRIMARY KEY (`id_clinica`);

--
-- Indexes for table `clinicas_sucursales`
--
ALTER TABLE `clinicas_sucursales`
  ADD PRIMARY KEY (`id_clini_suc`),
  ADD KEY `FK_sucursal_clinica_idx` (`id_sucursal`),
  ADD KEY `FK_sucuresal_idclinica_idx` (`id_clinica`);

--
-- Indexes for table `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `FK_compras_proveedor_idx` (`id_proveedor`),
  ADD KEY `FK_compras_origen_dinero_idx` (`id_origen_dinero`),
  ADD KEY `FK_compras_sucursal_idx` (`id_sucursal`),
  ADD KEY `fk_compras_user_idx` (`user_id`),
  ADD KEY `id_serie` (`id_serie`);

--
-- Indexes for table `compras_detalle`
--
ALTER TABLE `compras_detalle`
  ADD PRIMARY KEY (`id_compra_detalle`);

--
-- Indexes for table `comprobantes`
--
ALTER TABLE `comprobantes`
  ADD PRIMARY KEY (`id_comprobante`),
  ADD KEY `FK_cliente_comprobante_idx` (`id_cliente`),
  ADD KEY `FK_sucursal_comprobante_idx` (`id_sucursal`),
  ADD KEY `FK_tipo_comprobante_idx` (`id_tipo_comprobante`),
  ADD KEY `FK_documento_comprobante_idx` (`id_tipo_documento`),
  ADD KEY `FK_usuario_comprobante_idx` (`id_usuario`),
  ADD KEY `FK_estado_comprobante_idx` (`id_estado_comprobante`),
  ADD KEY `FK_medio_pago_comprobante_idx` (`id_medio_pago`),
  ADD KEY `FK_serie_comprobante_idx` (`id_serie`),
  ADD KEY `FK_caja_comprobante_idx` (`id_caja`),
  ADD KEY `id_orden_lab` (`id_orden_lab`),
  ADD KEY `id_eps_discount` (`id_eps_discount`),
  ADD KEY `fk_comprobantes_id_comprobante_eps` (`id_comprobante_eps`);

--
-- Indexes for table `comprobantes_detalles`
--
ALTER TABLE `comprobantes_detalles`
  ADD PRIMARY KEY (`id_comprobante_detalle`),
  ADD KEY `FK_comprobante_comprobante_detalle_idx` (`id_comprobante`),
  ADD KEY `comprobantes_detalles_id_unidad_medida_foreign` (`id_unidad_medida`),
  ADD KEY `id_precio_lente` (`id_precio_lente`),
  ADD KEY `id_servicio` (`id_servicio`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indexes for table `comprobantes_deudas`
--
ALTER TABLE `comprobantes_deudas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_comprobante` (`id_comprobante`);

--
-- Indexes for table `comprobantes_estados`
--
ALTER TABLE `comprobantes_estados`
  ADD PRIMARY KEY (`id_estado_comprobante`);

--
-- Indexes for table `comprobantes_pagos`
--
ALTER TABLE `comprobantes_pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_comprobante` (`id_comprobante`),
  ADD KEY `id_caja` (`id_caja`),
  ADD KEY `id_metodo_pago` (`id_metodo_pago`),
  ADD KEY `fk_user` (`id_user`);

--
-- Indexes for table `comprobantes_series`
--
ALTER TABLE `comprobantes_series`
  ADD PRIMARY KEY (`id_serie`),
  ADD KEY `FK_sucursal_serie_idx` (`id_sucursal`),
  ADD KEY `FK_tipo_comprobante_serie_idx` (`id_tipo_comprobante`);

--
-- Indexes for table `conformidad_montura`
--
ALTER TABLE `conformidad_montura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_conformidad_montura_id_anamnesis_idx` (`id_anamnesis`);

--
-- Indexes for table `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD PRIMARY KEY (`id_cotizacion`),
  ADD KEY `cotizaciones_id_serie_foreign` (`id_serie`),
  ADD KEY `cotizaciones_id_anamnesis_foreign` (`id_anamnesis`);

--
-- Indexes for table `cotizaciones_detalle`
--
ALTER TABLE `cotizaciones_detalle`
  ADD PRIMARY KEY (`id_cotizacion_detalle`),
  ADD KEY `cotizaciones_detalle_id_precio_lente_foreign` (`id_precio_lente`),
  ADD KEY `cotizaciones_detalle_id_cotizacion_foreign` (`id_cotizacion`),
  ADD KEY `FK_COTIZACIONES_PRODUCTO` (`id_producto`);

--
-- Indexes for table `cupones`
--
ALTER TABLE `cupones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_comprobante_origen` (`id_comprobante_origen`);

--
-- Indexes for table `deuda_compra_cuotas`
--
ALTER TABLE `deuda_compra_cuotas`
  ADD PRIMARY KEY (`id_cuota`);

--
-- Indexes for table `deuda_compra_pagos`
--
ALTER TABLE `deuda_compra_pagos`
  ADD PRIMARY KEY (`id_pago_deuda`),
  ADD KEY `FK_pago_deuda_origen_dinero_idx` (`id_origen_dinero`),
  ADD KEY `fk_pago_deuda_sucursal_idx` (`user_id`);

--
-- Indexes for table `doctores`
--
ALTER TABLE `doctores`
  ADD PRIMARY KEY (`id_doctor`);

--
-- Indexes for table `doctores_sucursales`
--
ALTER TABLE `doctores_sucursales`
  ADD PRIMARY KEY (`id_empresa_sucursal`),
  ADD KEY `FK_sucursal_doctor_idx` (`id_doctor`),
  ADD KEY `FK_sucursal_idsucursal_idx` (`id_sucursal`);

--
-- Indexes for table `egresos`
--
ALTER TABLE `egresos`
  ADD PRIMARY KEY (`id_egreso`),
  ADD KEY `FK_caja_egreso_idx` (`id_caja`),
  ADD KEY `id_medio_pago` (`id_medio_pago`),
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `empresas_convenio`
--
ALTER TABLE `empresas_convenio`
  ADD PRIMARY KEY (`id_empresa_convenio`);

--
-- Indexes for table `encuestas_satisfaccion`
--
ALTER TABLE `encuestas_satisfaccion`
  ADD PRIMARY KEY (`id_encuesta`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_sucursal` (`id_sucursal`),
  ADD KEY `id_comprobante` (`id_comprobante`),
  ADD KEY `id_anamnesis` (`id_anamnesis`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `encuesta_etapas`
--
ALTER TABLE `encuesta_etapas`
  ADD PRIMARY KEY (`id_etapa_encuesta`),
  ADD UNIQUE KEY `etapa` (`etapa`);

--
-- Indexes for table `encuesta_preguntas`
--
ALTER TABLE `encuesta_preguntas`
  ADD PRIMARY KEY (`id_encuesta_pregunta`),
  ADD KEY `id_etapa_encuesta` (`id_etapa_encuesta`);

--
-- Indexes for table `encuesta_respuestas`
--
ALTER TABLE `encuesta_respuestas`
  ADD PRIMARY KEY (`id_encuesta_respuesta`),
  ADD KEY `id_encuesta` (`id_encuesta`),
  ADD KEY `id_encuesta_pregunta` (`id_encuesta_pregunta`);

--
-- Indexes for table `eps`
--
ALTER TABLE `eps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `eps_descuentos`
--
ALTER TABLE `eps_descuentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eps_id` (`eps_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `guia_remision`
--
ALTER TABLE `guia_remision`
  ADD PRIMARY KEY (`id_guia_remision`),
  ADD KEY `id_serie` (`id_serie`),
  ADD KEY `id_sucursal` (`id_sucursal`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_motivo_traslado` (`id_motivo_traslado`),
  ADD KEY `id_unidad_medida` (`id_unidad_medida`),
  ADD KEY `id_departamento_partida` (`id_departamento_partida`),
  ADD KEY `id_provincia_partida` (`id_provincia_partida`),
  ADD KEY `id_distrito_partida` (`id_distrito_partida`),
  ADD KEY `id_departamento_llegada` (`id_departamento_llegada`),
  ADD KEY `id_provincia_llegada` (`id_provincia_llegada`),
  ADD KEY `id_distrito_llegada` (`id_distrito_llegada`);

--
-- Indexes for table `medio_pago`
--
ALTER TABLE `medio_pago`
  ADD PRIMARY KEY (`id_medio_pago`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `motivo_traslado`
--
ALTER TABLE `motivo_traslado`
  ADD PRIMARY KEY (`id_motivo_traslado`);

--
-- Indexes for table `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`id_nota`),
  ADD KEY `id_serie` (`id_serie`),
  ADD KEY `id_comprobante` (`id_comprobante`),
  ADD KEY `id_tipo_nota` (`id_tipo_nota`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_sucursal` (`id_sucursal`),
  ADD KEY `id_tipo_comprobantes` (`id_tipo_comprobantes`),
  ADD KEY `id_estado_comprobante` (`id_estado_comprobante`);

--
-- Indexes for table `nota_detalle`
--
ALTER TABLE `nota_detalle`
  ADD PRIMARY KEY (`id_nota_detalle`),
  ADD KEY `id_nota` (`id_nota`),
  ADD KEY `id_precio_lente` (`id_precio_lente`),
  ADD KEY `id_servicio` (`id_servicio`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_unidad_medida` (`id_unidad_medida`);

--
-- Indexes for table `ocupaciones`
--
ALTER TABLE `ocupaciones`
  ADD PRIMARY KEY (`id_ocupacion`);

--
-- Indexes for table `orden_laboratorio`
--
ALTER TABLE `orden_laboratorio`
  ADD PRIMARY KEY (`id_orden_laboratorio`),
  ADD KEY `FK_estado_orden_laboratorio_idx` (`id_estado_orden_laboratorio`),
  ADD KEY `FK_anamnesis_orden_laboratorio_idx` (`id_anamnesis`),
  ADD KEY `FK_montura_orden_laboratorio_idx` (`id_montura`),
  ADD KEY `FK_cliente_orden_laboratorio_idx` (`id_cliente`),
  ADD KEY `FK_sucursal_orden_laboratorio_idx` (`id_sucursal`),
  ADD KEY `FK_usuario_orden_laboratorio_idx` (`id_usuario`),
  ADD KEY `FK_precio_lentes_orden_laboratorio_idx` (`id_precio_lentes`);

--
-- Indexes for table `orden_laboratorio_estados`
--
ALTER TABLE `orden_laboratorio_estados`
  ADD PRIMARY KEY (`id_estado_orden_laboratorio`);

--
-- Indexes for table `orden_laboratorio_historial_estados`
--
ALTER TABLE `orden_laboratorio_historial_estados`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `id_orden` (`id_orden`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indexes for table `origen_dinero`
--
ALTER TABLE `origen_dinero`
  ADD PRIMARY KEY (`id_origen_dinero`),
  ADD KEY `FK_origen_dinero_sucursal_idx` (`id_sucursal`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `precios_lentes`
--
ALTER TABLE `precios_lentes`
  ADD PRIMARY KEY (`id_precio_lente`),
  ADD KEY `FK_sucursal_preciolente_idx` (`id_sucursal`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `FK_producto_marcaid_idx` (`id_marca`),
  ADD KEY `FK_producto_categoriaid_idx` (`id_categoria`),
  ADD KEY `FK_producto_materialid_idx` (`id_material`),
  ADD KEY `FK_producto_tipoaroid_idx` (`id_tipo_aro`),
  ADD KEY `FK_producto_formamontura_idx` (`id_forma_montura`),
  ADD KEY `FK_producto_afectacionigv_idx` (`cod_afectacion_igv`),
  ADD KEY `FK_producto_sucursalid_idx` (`id_sucursal`);

--
-- Indexes for table `productos_categorias`
--
ALTER TABLE `productos_categorias`
  ADD PRIMARY KEY (`id_producto_categoria`);

--
-- Indexes for table `productos_forma_montura`
--
ALTER TABLE `productos_forma_montura`
  ADD PRIMARY KEY (`id_forma_montura`);

--
-- Indexes for table `productos_marcas`
--
ALTER TABLE `productos_marcas`
  ADD PRIMARY KEY (`id_marca_producto`);

--
-- Indexes for table `productos_material`
--
ALTER TABLE `productos_material`
  ADD PRIMARY KEY (`id_material`);

--
-- Indexes for table `productos_tipo_aro`
--
ALTER TABLE `productos_tipo_aro`
  ADD PRIMARY KEY (`id_tipo_aro`);

--
-- Indexes for table `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`),
  ADD KEY `FK_id_tipo_doc_cliente_idx` (`id_tipo_doc`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `rubros_trabajo`
--
ALTER TABLE `rubros_trabajo`
  ADD PRIMARY KEY (`id_rubro_trabajo`);

--
-- Indexes for table `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `FK_servicio_id_sucursal_idx` (`id_sucursal`),
  ADD KEY `FK_cod_igv_servicio_idx` (`cod_afectacion_igv`);

--
-- Indexes for table `stock_productos_sucursales`
--
ALTER TABLE `stock_productos_sucursales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sucursales`
--
ALTER TABLE `sucursales`
  ADD PRIMARY KEY (`id_sucursal`);

--
-- Indexes for table `tipos_comprobantes`
--
ALTER TABLE `tipos_comprobantes`
  ADD PRIMARY KEY (`id_tipo_comprobantes`);

--
-- Indexes for table `tipos_documentos`
--
ALTER TABLE `tipos_documentos`
  ADD PRIMARY KEY (`id_tipo_documento`);

--
-- Indexes for table `tipos_nota`
--
ALTER TABLE `tipos_nota`
  ADD PRIMARY KEY (`id_tipo_nota`),
  ADD KEY `id_tipo_comprobantes` (`id_tipo_comprobantes`);

--
-- Indexes for table `traslado_productos_sucursales`
--
ALTER TABLE `traslado_productos_sucursales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `traslado_productos_ubicacion`
--
ALTER TABLE `traslado_productos_ubicacion`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ubigeo_departamentos`
--
ALTER TABLE `ubigeo_departamentos`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indexes for table `ubigeo_distritos`
--
ALTER TABLE `ubigeo_distritos`
  ADD PRIMARY KEY (`id_distrito`),
  ADD KEY `FK_id_departamento_distrito_idx` (`id_departamento`),
  ADD KEY `FK_id_provincia_distrito_idx` (`id_provincia`);

--
-- Indexes for table `ubigeo_provincias`
--
ALTER TABLE `ubigeo_provincias`
  ADD PRIMARY KEY (`id_provincia`),
  ADD KEY `FK_id_departamento_provincia_idx` (`id_departamento`);

--
-- Indexes for table `unidades_medida`
--
ALTER TABLE `unidades_medida`
  ADD PRIMARY KEY (`id_unidad_medida`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `FK_user_id_sucursal_idx` (`id_sucursal`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `afectacion_igv`
--
ALTER TABLE `afectacion_igv`
  MODIFY `cod_afectacion` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `almacen_movimientos`
--
ALTER TABLE `almacen_movimientos`
  MODIFY `id_almacen_movimientos` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `almacen_movimientos_tipos`
--
ALTER TABLE `almacen_movimientos_tipos`
  MODIFY `id_tipo_movimiento` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `anamnesis`
--
ALTER TABLE `anamnesis`
  MODIFY `id_anamnesis` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `anamnesis_estados_historico`
--
ALTER TABLE `anamnesis_estados_historico`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `caja`
--
ALTER TABLE `caja`
  MODIFY `id_caja` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `caja_cuadre`
--
ALTER TABLE `caja_cuadre`
  MODIFY `id_cuadre` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `caja_cuadre_estado`
--
ALTER TABLE `caja_cuadre_estado`
  MODIFY `id_estado` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `caja_turnos`
--
ALTER TABLE `caja_turnos`
  MODIFY `id_caja_turno` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `calendario_feriados`
--
ALTER TABLE `calendario_feriados`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `clinicas`
--
ALTER TABLE `clinicas`
  MODIFY `id_clinica` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `clinicas_sucursales`
--
ALTER TABLE `clinicas_sucursales`
  MODIFY `id_clini_suc` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `compras_detalle`
--
ALTER TABLE `compras_detalle`
  MODIFY `id_compra_detalle` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comprobantes`
--
ALTER TABLE `comprobantes`
  MODIFY `id_comprobante` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comprobantes_detalles`
--
ALTER TABLE `comprobantes_detalles`
  MODIFY `id_comprobante_detalle` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `comprobantes_deudas`
--
ALTER TABLE `comprobantes_deudas`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comprobantes_estados`
--
ALTER TABLE `comprobantes_estados`
  MODIFY `id_estado_comprobante` tinyint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `comprobantes_pagos`
--
ALTER TABLE `comprobantes_pagos`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comprobantes_series`
--
ALTER TABLE `comprobantes_series`
  MODIFY `id_serie` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `conformidad_montura`
--
ALTER TABLE `conformidad_montura`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id_cotizacion` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cotizaciones_detalle`
--
ALTER TABLE `cotizaciones_detalle`
  MODIFY `id_cotizacion_detalle` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cupones`
--
ALTER TABLE `cupones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `deuda_compra_cuotas`
--
ALTER TABLE `deuda_compra_cuotas`
  MODIFY `id_cuota` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deuda_compra_pagos`
--
ALTER TABLE `deuda_compra_pagos`
  MODIFY `id_pago_deuda` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctores`
--
ALTER TABLE `doctores`
  MODIFY `id_doctor` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `doctores_sucursales`
--
ALTER TABLE `doctores_sucursales`
  MODIFY `id_empresa_sucursal` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `egresos`
--
ALTER TABLE `egresos`
  MODIFY `id_egreso` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empresas_convenio`
--
ALTER TABLE `empresas_convenio`
  MODIFY `id_empresa_convenio` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `encuestas_satisfaccion`
--
ALTER TABLE `encuestas_satisfaccion`
  MODIFY `id_encuesta` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `encuesta_etapas`
--
ALTER TABLE `encuesta_etapas`
  MODIFY `id_etapa_encuesta` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `encuesta_preguntas`
--
ALTER TABLE `encuesta_preguntas`
  MODIFY `id_encuesta_pregunta` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `encuesta_respuestas`
--
ALTER TABLE `encuesta_respuestas`
  MODIFY `id_encuesta_respuesta` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eps`
--
ALTER TABLE `eps`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `eps_descuentos`
--
ALTER TABLE `eps_descuentos`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guia_remision`
--
ALTER TABLE `guia_remision`
  MODIFY `id_guia_remision` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medio_pago`
--
ALTER TABLE `medio_pago`
  MODIFY `id_medio_pago` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `motivo_traslado`
--
ALTER TABLE `motivo_traslado`
  MODIFY `id_motivo_traslado` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `notas`
--
ALTER TABLE `notas`
  MODIFY `id_nota` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nota_detalle`
--
ALTER TABLE `nota_detalle`
  MODIFY `id_nota_detalle` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ocupaciones`
--
ALTER TABLE `ocupaciones`
  MODIFY `id_ocupacion` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `orden_laboratorio`
--
ALTER TABLE `orden_laboratorio`
  MODIFY `id_orden_laboratorio` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orden_laboratorio_estados`
--
ALTER TABLE `orden_laboratorio_estados`
  MODIFY `id_estado_orden_laboratorio` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orden_laboratorio_historial_estados`
--
ALTER TABLE `orden_laboratorio_historial_estados`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `origen_dinero`
--
ALTER TABLE `origen_dinero`
  MODIFY `id_origen_dinero` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `precios_lentes`
--
ALTER TABLE `precios_lentes`
  MODIFY `id_precio_lente` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=518;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `productos_categorias`
--
ALTER TABLE `productos_categorias`
  MODIFY `id_producto_categoria` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `productos_forma_montura`
--
ALTER TABLE `productos_forma_montura`
  MODIFY `id_forma_montura` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `productos_marcas`
--
ALTER TABLE `productos_marcas`
  MODIFY `id_marca_producto` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `productos_material`
--
ALTER TABLE `productos_material`
  MODIFY `id_material` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `productos_tipo_aro`
--
ALTER TABLE `productos_tipo_aro`
  MODIFY `id_tipo_aro` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rubros_trabajo`
--
ALTER TABLE `rubros_trabajo`
  MODIFY `id_rubro_trabajo` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_productos_sucursales`
--
ALTER TABLE `stock_productos_sucursales`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sucursales`
--
ALTER TABLE `sucursales`
  MODIFY `id_sucursal` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tipos_comprobantes`
--
ALTER TABLE `tipos_comprobantes`
  MODIFY `id_tipo_comprobantes` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tipos_documentos`
--
ALTER TABLE `tipos_documentos`
  MODIFY `id_tipo_documento` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tipos_nota`
--
ALTER TABLE `tipos_nota`
  MODIFY `id_tipo_nota` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `traslado_productos_sucursales`
--
ALTER TABLE `traslado_productos_sucursales`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `traslado_productos_ubicacion`
--
ALTER TABLE `traslado_productos_ubicacion`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ubigeo_departamentos`
--
ALTER TABLE `ubigeo_departamentos`
  MODIFY `id_departamento` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `ubigeo_distritos`
--
ALTER TABLE `ubigeo_distritos`
  MODIFY `id_distrito` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250402;

--
-- AUTO_INCREMENT for table `ubigeo_provincias`
--
ALTER TABLE `ubigeo_provincias`
  MODIFY `id_provincia` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2505;

--
-- AUTO_INCREMENT for table `unidades_medida`
--
ALTER TABLE `unidades_medida`
  MODIFY `id_unidad_medida` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `almacen_movimientos`
--
ALTER TABLE `almacen_movimientos`
  ADD CONSTRAINT `FK_almacen_movimientos_producto_idx` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  ADD CONSTRAINT `FK_almacen_movimientos_sucursal_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`),
  ADD CONSTRAINT `FK_almacen_movimientos_tipo_idx` FOREIGN KEY (`id_tipo_movimiento`) REFERENCES `almacen_movimientos_tipos` (`id_tipo_movimiento`);

--
-- Constraints for table `anamnesis`
--
ALTER TABLE `anamnesis`
  ADD CONSTRAINT `FK_cliente_anamnesis_idx` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `FK_clinica_anamnesis_idx` FOREIGN KEY (`id_clinica`) REFERENCES `clinicas` (`id_clinica`),
  ADD CONSTRAINT `FK_doctor_anamnesis_idx` FOREIGN KEY (`id_doctor`) REFERENCES `doctores` (`id_doctor`),
  ADD CONSTRAINT `FK_empresa_convenio_anamnesis_idx` FOREIGN KEY (`id_empresa_convenio`) REFERENCES `empresas_convenio` (`id_empresa_convenio`),
  ADD CONSTRAINT `FK_sucursal_anamnesis_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);

--
-- Constraints for table `anamnesis_estados_historico`
--
ALTER TABLE `anamnesis_estados_historico`
  ADD CONSTRAINT `FK_anamnesis_estados_historico_id_anamnesis_idx` FOREIGN KEY (`anamnesis_id`) REFERENCES `anamnesis` (`id_anamnesis`),
  ADD CONSTRAINT `FK_anamnesis_estados_historico_id_user_idx` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `caja_cuadre`
--
ALTER TABLE `caja_cuadre`
  ADD CONSTRAINT `caja_cuadre_ibfk_1` FOREIGN KEY (`id_caja`) REFERENCES `caja` (`id_caja`),
  ADD CONSTRAINT `caja_cuadre_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `caja_cuadre_estado` (`id_estado`);

--
-- Constraints for table `campanas`
--
ALTER TABLE `campanas`
  ADD CONSTRAINT `campanas_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `FK_codigo_doc_cliente_idx` FOREIGN KEY (`cod_tipo_doc`) REFERENCES `tipos_documentos` (`id_tipo_documento`),
  ADD CONSTRAINT `FK_departamento_cliente_idx` FOREIGN KEY (`id_departamento`) REFERENCES `ubigeo_departamentos` (`id_departamento`),
  ADD CONSTRAINT `FK_distrito_cliente_idx` FOREIGN KEY (`id_distrito`) REFERENCES `ubigeo_distritos` (`id_distrito`),
  ADD CONSTRAINT `FK_ocupacion_cliente_idx` FOREIGN KEY (`id_ocupacion`) REFERENCES `ocupaciones` (`id_ocupacion`),
  ADD CONSTRAINT `FK_provincia_cliente_idx` FOREIGN KEY (`id_provincia`) REFERENCES `ubigeo_provincias` (`id_provincia`),
  ADD CONSTRAINT `FK_ruburos_cliente_idx` FOREIGN KEY (`id_rubro_trabajo`) REFERENCES `rubros_trabajo` (`id_rubro_trabajo`);

--
-- Constraints for table `clinicas_sucursales`
--
ALTER TABLE `clinicas_sucursales`
  ADD CONSTRAINT `FK_sucuresal_idclinica_idx` FOREIGN KEY (`id_clinica`) REFERENCES `clinicas` (`id_clinica`),
  ADD CONSTRAINT `FK_sucursal_clinica_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);

--
-- Constraints for table `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`id_serie`) REFERENCES `comprobantes_series` (`id_serie`),
  ADD CONSTRAINT `FK_compras_origen_dinero_idx` FOREIGN KEY (`id_origen_dinero`) REFERENCES `origen_dinero` (`id_origen_dinero`),
  ADD CONSTRAINT `FK_compras_proveedor_idx` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`),
  ADD CONSTRAINT `FK_compras_sucursal_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);

--
-- Constraints for table `comprobantes`
--
ALTER TABLE `comprobantes`
  ADD CONSTRAINT `comprobantes_ibfk_1` FOREIGN KEY (`id_orden_lab`) REFERENCES `orden_laboratorio` (`id_orden_laboratorio`),
  ADD CONSTRAINT `comprobantes_ibfk_2` FOREIGN KEY (`id_eps_discount`) REFERENCES `eps_descuentos` (`id`),
  ADD CONSTRAINT `FK_caja_comprobante_idx` FOREIGN KEY (`id_caja`) REFERENCES `caja` (`id_caja`),
  ADD CONSTRAINT `FK_cliente_comprobante_idx` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `fk_comprobantes_id_comprobante_eps` FOREIGN KEY (`id_comprobante_eps`) REFERENCES `comprobantes` (`id_comprobante`),
  ADD CONSTRAINT `FK_documento_comprobante_idx` FOREIGN KEY (`id_tipo_documento`) REFERENCES `tipos_documentos` (`id_tipo_documento`),
  ADD CONSTRAINT `FK_estado_comprobante_idx` FOREIGN KEY (`id_estado_comprobante`) REFERENCES `comprobantes_estados` (`id_estado_comprobante`),
  ADD CONSTRAINT `FK_medio_pago_comprobante_idx` FOREIGN KEY (`id_medio_pago`) REFERENCES `medio_pago` (`id_medio_pago`),
  ADD CONSTRAINT `FK_serie_comprobante_idx` FOREIGN KEY (`id_serie`) REFERENCES `comprobantes_series` (`id_serie`),
  ADD CONSTRAINT `FK_sucursal_comprobante_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`),
  ADD CONSTRAINT `FK_tipo_comprobante_idx` FOREIGN KEY (`id_tipo_comprobante`) REFERENCES `tipos_comprobantes` (`id_tipo_comprobantes`),
  ADD CONSTRAINT `FK_usuario_comprobante_idx` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`);

--
-- Constraints for table `comprobantes_detalles`
--
ALTER TABLE `comprobantes_detalles`
  ADD CONSTRAINT `comprobantes_detalles_ibfk_1` FOREIGN KEY (`id_precio_lente`) REFERENCES `precios_lentes` (`id_precio_lente`),
  ADD CONSTRAINT `comprobantes_detalles_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`),
  ADD CONSTRAINT `comprobantes_detalles_ibfk_3` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  ADD CONSTRAINT `comprobantes_detalles_id_unidad_medida_foreign` FOREIGN KEY (`id_unidad_medida`) REFERENCES `unidades_medida` (`id_unidad_medida`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_comprobante_comprobante_detalle_idx` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobantes` (`id_comprobante`);

--
-- Constraints for table `comprobantes_deudas`
--
ALTER TABLE `comprobantes_deudas`
  ADD CONSTRAINT `comprobantes_deudas_ibfk_1` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobantes` (`id_comprobante`);

--
-- Constraints for table `comprobantes_pagos`
--
ALTER TABLE `comprobantes_pagos`
  ADD CONSTRAINT `comprobantes_pagos_ibfk_1` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobantes` (`id_comprobante`),
  ADD CONSTRAINT `comprobantes_pagos_ibfk_2` FOREIGN KEY (`id_caja`) REFERENCES `caja` (`id_caja`),
  ADD CONSTRAINT `comprobantes_pagos_ibfk_3` FOREIGN KEY (`id_metodo_pago`) REFERENCES `medio_pago` (`id_medio_pago`),
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `comprobantes_series`
--
ALTER TABLE `comprobantes_series`
  ADD CONSTRAINT `FK_sucursal_serie_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);

--
-- Constraints for table `conformidad_montura`
--
ALTER TABLE `conformidad_montura`
  ADD CONSTRAINT `FK_conformidad_montura_id_anamnesis_idx` FOREIGN KEY (`id_anamnesis`) REFERENCES `anamnesis` (`id_anamnesis`);

--
-- Constraints for table `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD CONSTRAINT `cotizaciones_id_anamnesis_foreign` FOREIGN KEY (`id_anamnesis`) REFERENCES `anamnesis` (`id_anamnesis`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cotizaciones_id_serie_foreign` FOREIGN KEY (`id_serie`) REFERENCES `comprobantes_series` (`id_serie`) ON UPDATE CASCADE;

--
-- Constraints for table `cotizaciones_detalle`
--
ALTER TABLE `cotizaciones_detalle`
  ADD CONSTRAINT `cotizaciones_detalle_id_precio_lente_foreign` FOREIGN KEY (`id_precio_lente`) REFERENCES `precios_lentes` (`id_precio_lente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_COTIZACIONES_PRODUCTO` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Constraints for table `cupones`
--
ALTER TABLE `cupones`
  ADD CONSTRAINT `cupones_ibfk_1` FOREIGN KEY (`id_comprobante_origen`) REFERENCES `comprobantes` (`id_comprobante`),
  ADD CONSTRAINT `cupones_ibfk_2` FOREIGN KEY (`id_comprobante_origen`) REFERENCES `comprobantes` (`id_comprobante`);

--
-- Constraints for table `deuda_compra_pagos`
--
ALTER TABLE `deuda_compra_pagos`
  ADD CONSTRAINT `deuda_compra_pagos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `deuda_compra_pagos_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_pago_deuda_origen_dinero_idx` FOREIGN KEY (`id_origen_dinero`) REFERENCES `origen_dinero` (`id_origen_dinero`);

--
-- Constraints for table `doctores_sucursales`
--
ALTER TABLE `doctores_sucursales`
  ADD CONSTRAINT `FK_sucursal_doctor_idx` FOREIGN KEY (`id_doctor`) REFERENCES `doctores` (`id_doctor`),
  ADD CONSTRAINT `FK_sucursal_idsucursal_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);

--
-- Constraints for table `egresos`
--
ALTER TABLE `egresos`
  ADD CONSTRAINT `egresos_ibfk_1` FOREIGN KEY (`id_medio_pago`) REFERENCES `medio_pago` (`id_medio_pago`),
  ADD CONSTRAINT `egresos_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`),
  ADD CONSTRAINT `egresos_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_caja_egreso_idx` FOREIGN KEY (`id_caja`) REFERENCES `caja` (`id_caja`);

--
-- Constraints for table `encuestas_satisfaccion`
--
ALTER TABLE `encuestas_satisfaccion`
  ADD CONSTRAINT `encuestas_satisfaccion_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `encuestas_satisfaccion_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`),
  ADD CONSTRAINT `encuestas_satisfaccion_ibfk_3` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobantes` (`id_comprobante`),
  ADD CONSTRAINT `encuestas_satisfaccion_ibfk_4` FOREIGN KEY (`id_anamnesis`) REFERENCES `anamnesis` (`id_anamnesis`),
  ADD CONSTRAINT `encuestas_satisfaccion_ibfk_5` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `encuesta_preguntas`
--
ALTER TABLE `encuesta_preguntas`
  ADD CONSTRAINT `encuesta_preguntas_ibfk_1` FOREIGN KEY (`id_etapa_encuesta`) REFERENCES `encuesta_etapas` (`id_etapa_encuesta`);

--
-- Constraints for table `encuesta_respuestas`
--
ALTER TABLE `encuesta_respuestas`
  ADD CONSTRAINT `encuesta_respuestas_ibfk_1` FOREIGN KEY (`id_encuesta`) REFERENCES `encuestas_satisfaccion` (`id_encuesta`),
  ADD CONSTRAINT `encuesta_respuestas_ibfk_2` FOREIGN KEY (`id_encuesta_pregunta`) REFERENCES `encuesta_preguntas` (`id_encuesta_pregunta`);

--
-- Constraints for table `eps_descuentos`
--
ALTER TABLE `eps_descuentos`
  ADD CONSTRAINT `eps_descuentos_ibfk_1` FOREIGN KEY (`eps_id`) REFERENCES `eps` (`id`);

--
-- Constraints for table `guia_remision`
--
ALTER TABLE `guia_remision`
  ADD CONSTRAINT `guia_remision_ibfk_1` FOREIGN KEY (`id_serie`) REFERENCES `comprobantes_series` (`id_serie`),
  ADD CONSTRAINT `guia_remision_ibfk_10` FOREIGN KEY (`id_provincia_llegada`) REFERENCES `ubigeo_provincias` (`id_provincia`),
  ADD CONSTRAINT `guia_remision_ibfk_11` FOREIGN KEY (`id_distrito_llegada`) REFERENCES `ubigeo_distritos` (`id_distrito`),
  ADD CONSTRAINT `guia_remision_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`),
  ADD CONSTRAINT `guia_remision_ibfk_3` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `guia_remision_ibfk_4` FOREIGN KEY (`id_motivo_traslado`) REFERENCES `motivo_traslado` (`id_motivo_traslado`),
  ADD CONSTRAINT `guia_remision_ibfk_5` FOREIGN KEY (`id_unidad_medida`) REFERENCES `unidades_medida` (`id_unidad_medida`),
  ADD CONSTRAINT `guia_remision_ibfk_6` FOREIGN KEY (`id_departamento_partida`) REFERENCES `ubigeo_departamentos` (`id_departamento`),
  ADD CONSTRAINT `guia_remision_ibfk_7` FOREIGN KEY (`id_provincia_partida`) REFERENCES `ubigeo_provincias` (`id_provincia`),
  ADD CONSTRAINT `guia_remision_ibfk_8` FOREIGN KEY (`id_distrito_partida`) REFERENCES `ubigeo_distritos` (`id_distrito`),
  ADD CONSTRAINT `guia_remision_ibfk_9` FOREIGN KEY (`id_departamento_llegada`) REFERENCES `ubigeo_departamentos` (`id_departamento`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`id_serie`) REFERENCES `comprobantes_series` (`id_serie`),
  ADD CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobantes` (`id_comprobante`),
  ADD CONSTRAINT `notas_ibfk_3` FOREIGN KEY (`id_tipo_nota`) REFERENCES `tipos_nota` (`id_tipo_nota`),
  ADD CONSTRAINT `notas_ibfk_4` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `notas_ibfk_5` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`),
  ADD CONSTRAINT `notas_ibfk_6` FOREIGN KEY (`id_tipo_comprobantes`) REFERENCES `tipos_comprobantes` (`id_tipo_comprobantes`),
  ADD CONSTRAINT `notas_ibfk_7` FOREIGN KEY (`id_estado_comprobante`) REFERENCES `comprobantes_estados` (`id_estado_comprobante`);

--
-- Constraints for table `nota_detalle`
--
ALTER TABLE `nota_detalle`
  ADD CONSTRAINT `nota_detalle_ibfk_1` FOREIGN KEY (`id_nota`) REFERENCES `notas` (`id_nota`),
  ADD CONSTRAINT `nota_detalle_ibfk_2` FOREIGN KEY (`id_precio_lente`) REFERENCES `precios_lentes` (`id_precio_lente`),
  ADD CONSTRAINT `nota_detalle_ibfk_3` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`),
  ADD CONSTRAINT `nota_detalle_ibfk_4` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  ADD CONSTRAINT `nota_detalle_ibfk_5` FOREIGN KEY (`id_unidad_medida`) REFERENCES `unidades_medida` (`id_unidad_medida`);

--
-- Constraints for table `orden_laboratorio`
--
ALTER TABLE `orden_laboratorio`
  ADD CONSTRAINT `FK_anamnesis_orden_laboratorio_idx` FOREIGN KEY (`id_anamnesis`) REFERENCES `anamnesis` (`id_anamnesis`),
  ADD CONSTRAINT `FK_cliente_orden_laboratorio_idx` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `FK_estado_orden_laboratorio_idx` FOREIGN KEY (`id_estado_orden_laboratorio`) REFERENCES `orden_laboratorio_estados` (`id_estado_orden_laboratorio`),
  ADD CONSTRAINT `FK_montura_orden_laboratorio_idx` FOREIGN KEY (`id_montura`) REFERENCES `productos` (`id_producto`),
  ADD CONSTRAINT `FK_precio_lentes_orden_laboratorio_idx` FOREIGN KEY (`id_precio_lentes`) REFERENCES `precios_lentes` (`id_precio_lente`),
  ADD CONSTRAINT `FK_sucursal_orden_laboratorio_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`),
  ADD CONSTRAINT `FK_usuario_orden_laboratorio_idx` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`);

--
-- Constraints for table `orden_laboratorio_historial_estados`
--
ALTER TABLE `orden_laboratorio_historial_estados`
  ADD CONSTRAINT `orden_laboratorio_historial_estados_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `orden_laboratorio` (`id_orden_laboratorio`),
  ADD CONSTRAINT `orden_laboratorio_historial_estados_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `orden_laboratorio_estados` (`id_estado_orden_laboratorio`),
  ADD CONSTRAINT `orden_laboratorio_historial_estados_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`);

--
-- Constraints for table `origen_dinero`
--
ALTER TABLE `origen_dinero`
  ADD CONSTRAINT `FK_origen_dinero_sucursal_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);

--
-- Constraints for table `precios_lentes`
--
ALTER TABLE `precios_lentes`
  ADD CONSTRAINT `FK_sucursal_preciolente_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);

--
-- Constraints for table `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `FK_producto_afectacionigv_idx` FOREIGN KEY (`cod_afectacion_igv`) REFERENCES `afectacion_igv` (`cod_afectacion`),
  ADD CONSTRAINT `FK_producto_categoriaid_idx` FOREIGN KEY (`id_categoria`) REFERENCES `productos_categorias` (`id_producto_categoria`),
  ADD CONSTRAINT `FK_producto_formamontura_idx` FOREIGN KEY (`id_forma_montura`) REFERENCES `productos_forma_montura` (`id_forma_montura`),
  ADD CONSTRAINT `FK_producto_marcaid_idx` FOREIGN KEY (`id_marca`) REFERENCES `productos_marcas` (`id_marca_producto`),
  ADD CONSTRAINT `FK_producto_materialid_idx` FOREIGN KEY (`id_material`) REFERENCES `productos_material` (`id_material`),
  ADD CONSTRAINT `FK_producto_sucursalid_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`),
  ADD CONSTRAINT `FK_producto_tipoaroid_idx` FOREIGN KEY (`id_tipo_aro`) REFERENCES `productos_tipo_aro` (`id_tipo_aro`);

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `servicios`
--
ALTER TABLE `servicios`
  ADD CONSTRAINT `FK_cod_igv_servicio_idx` FOREIGN KEY (`cod_afectacion_igv`) REFERENCES `afectacion_igv` (`cod_afectacion`),
  ADD CONSTRAINT `FK_servicio_id_sucursal_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);

--
-- Constraints for table `tipos_nota`
--
ALTER TABLE `tipos_nota`
  ADD CONSTRAINT `tipos_nota_ibfk_1` FOREIGN KEY (`id_tipo_comprobantes`) REFERENCES `tipos_comprobantes` (`id_tipo_comprobantes`);

--
-- Constraints for table `ubigeo_distritos`
--
ALTER TABLE `ubigeo_distritos`
  ADD CONSTRAINT `FK_id_departamento_distrito_idx` FOREIGN KEY (`id_departamento`) REFERENCES `ubigeo_departamentos` (`id_departamento`),
  ADD CONSTRAINT `FK_id_provincia_distrito_idx` FOREIGN KEY (`id_provincia`) REFERENCES `ubigeo_provincias` (`id_provincia`);

--
-- Constraints for table `ubigeo_provincias`
--
ALTER TABLE `ubigeo_provincias`
  ADD CONSTRAINT `FK_id_departamento_provincia_idx` FOREIGN KEY (`id_departamento`) REFERENCES `ubigeo_departamentos` (`id_departamento`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_user_id_sucursal_idx` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;