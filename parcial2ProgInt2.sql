-- --------------------------------------------------------
-- Host:                         developeros.com.mx
-- Versión del servidor:         5.7.23-23 - Percona Server (GPL), Release 23, Revision 500fcf5
-- SO del servidor:              Linux
-- HeidiSQL Versión:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para develop7_ulsa
CREATE DATABASE IF NOT EXISTS `develop7_ulsa` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `develop7_ulsa`;

-- Volcando estructura para procedimiento develop7_ulsa.antonioDeleteSong
DELIMITER //
CREATE PROCEDURE `antonioDeleteSong`(IN songId INT(255))
BEGIN
DELETE FROM `develop7_ulsa`.`AntonioSongs` WHERE (`id` = songId);
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.antonioRegisterSong
DELIMITER //
CREATE PROCEDURE `antonioRegisterSong`(IN songName VARCHAR(255), IN songAuthor VARCHAR(255), IN songYear INT(20))
BEGIN
INSERT INTO AntonioSongs (name, author, year) 
VALUES(songName, songAuthor, songYear);
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.antonioRegisterUser
DELIMITER //
CREATE PROCEDURE `antonioRegisterUser`(IN SPname VARCHAR(255), IN SPpassword VARCHAR(255), IN userKey VARCHAR(255))
BEGIN
INSERT INTO Antoniousers (name, lastName, password) 
VALUES(SPname, 'ULSA', AES_ENCRYPT(SPpassword , userKey));
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.antonioShowSong
DELIMITER //
CREATE PROCEDURE `antonioShowSong`(IN songId INT(255))
BEGIN
SELECT * FROM AntonioSongs WHERE id=songId;
END//
DELIMITER ;

-- Volcando estructura para tabla develop7_ulsa.AntonioSongs
CREATE TABLE IF NOT EXISTS `AntonioSongs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `year` int(11) DEFAULT NULL,
  `info` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla develop7_ulsa.AntonioSongs: ~4 rows (aproximadamente)
DELETE FROM `AntonioSongs`;
/*!40000 ALTER TABLE `AntonioSongs` DISABLE KEYS */;
INSERT INTO `AntonioSongs` (`id`, `name`, `author`, `year`, `info`) VALUES
	(3, 'Not PLaying', 'Playboi Carti', 2019, 'Esta es una canción muy popular desde la fecha de su lanzamiento.'),
	(5, 'Carter 14!', 'Trippie Redd', 2021, 'Esta fue una de las mejores colaboraciones que se han mirado.'),
	(10, 'Pull up', 'Lil Mosey', 2018, 'Esta es una canción de un artista muy talentoso.'),
	(12, 'Canción 1', 'ULSA', 2022, NULL),
	(14, 'Pepito', 'Pepito', 2010, NULL);
/*!40000 ALTER TABLE `AntonioSongs` ENABLE KEYS */;

-- Volcando estructura para procedimiento develop7_ulsa.antonioUpdateSong
DELIMITER //
CREATE PROCEDURE `antonioUpdateSong`(IN songId INT(255), IN songName VARCHAR(255), IN songAuthor VARCHAR(255), IN songYear INT(255))
BEGIN
UPDATE AntonioSongs SET name=songName, author=songAuthor, year=songYear WHERE id=songId;
END//
DELIMITER ;

-- Volcando estructura para tabla develop7_ulsa.Antoniousers
CREATE TABLE IF NOT EXISTS `Antoniousers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla develop7_ulsa.Antoniousers: ~5 rows (aproximadamente)
DELETE FROM `Antoniousers`;
/*!40000 ALTER TABLE `Antoniousers` DISABLE KEYS */;
INSERT INTO `Antoniousers` (`id`, `name`, `lastName`, `password`) VALUES
	(4, 'antonio', 'ULSA', _binary 0x501D),
	(5, 'antonio', 'ULSA', _binary 0x501DEFC4013F3F21529C123F33C065AD),
	(6, 'Admin', 'ULSA', _binary 0x3C7218DB0D354A7D4A09565CB2C5A2FA),
	(7, 'Chefcito123', 'ULSA', _binary 0x08B64AC9E3D28AE52A14ED7E8CB0D87C),
	(8, 'Pepito', 'ULSA', _binary 0x81F44672F7707F551EA23C36B66F7AFE);
/*!40000 ALTER TABLE `Antoniousers` ENABLE KEYS */;

-- Volcando estructura para procedimiento develop7_ulsa.antonioValidacion
DELIMITER //
CREATE PROCEDURE `antonioValidacion`(IN SPname VARCHAR(255), IN SPpassword VARCHAR(255), IN SPuserkey VARCHAR(255))
BEGIN
SELECT name, lastName FROM Antoniousers WHERE name = SPname AND password = AES_ENCRYPT(SPpassword , SPuserkey);
END//
DELIMITER ;

-- Volcando estructura para tabla develop7_ulsa.cac_users
CREATE TABLE IF NOT EXISTS `cac_users` (
  `password` text COLLATE utf8_unicode_ci,
  `username` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla develop7_ulsa.cac_users: ~0 rows (aproximadamente)
DELETE FROM `cac_users`;
/*!40000 ALTER TABLE `cac_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `cac_users` ENABLE KEYS */;

-- Volcando estructura para tabla develop7_ulsa.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla develop7_ulsa.failed_jobs: ~0 rows (aproximadamente)
DELETE FROM `failed_jobs`;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Volcando estructura para tabla develop7_ulsa.items
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla develop7_ulsa.items: ~2 rows (aproximadamente)
DELETE FROM `items`;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`id`, `nombre`, `cantidad`) VALUES
	(7, 'Barbie', 5),
	(17, 'pulsera', 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Volcando estructura para tabla develop7_ulsa.libros
CREATE TABLE IF NOT EXISTS `libros` (
  `idLibro` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nomLibro` varchar(255) NOT NULL,
  `precio` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idLibro`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla develop7_ulsa.libros: ~1 rows (aproximadamente)
DELETE FROM `libros`;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` (`idLibro`, `nomLibro`, `precio`, `created_at`, `updated_at`) VALUES
	(6, 'DrÃ¡cula', 350.00, '2020-11-11 00:00:00', '2020-11-11 00:00:00');
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;

-- Volcando estructura para procedimiento develop7_ulsa.LIMMcheckCount
DELIMITER //
CREATE PROCEDURE `LIMMcheckCount`(
	IN `_User` VARCHAR(50),
	IN `_Key` VARCHAR(50)
)
BEGIN
SELECT id, USER, CAST(AES_DECRYPT(PASSWORD, _Key) AS CHAR), Description
FROM LIMMUsers WHERE USER = _User;
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LIMMdeleteUser
DELIMITER //
CREATE PROCEDURE `LIMMdeleteUser`(
	IN `_User` VARCHAR(50)
)
BEGIN
DELETE FROM LIMMUsers WHERE USER=_User;
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LIMMshowUsers
DELIMITER //
CREATE PROCEDURE `LIMMshowUsers`()
BEGIN
	SELECT USER, Description FROM LIMMUsers;
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LIMMsignUp
DELIMITER //
CREATE PROCEDURE `LIMMsignUp`(
	IN `_User` VARCHAR(50),
	IN `_Password` VARCHAR(50),
	IN `_Key` VARCHAR(50)
)
BEGIN
INSERT INTO	LIMMUsers (USER, PASSWORD) VALUES (_User, AES_ENCRYPT(_Password,_Key));
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LIMMupdateDesc
DELIMITER //
CREATE PROCEDURE `LIMMupdateDesc`(
	IN `_Description` VARCHAR(50),
	IN `_id` INT
)
BEGIN
UPDATE LIMMUsers SET Description = _Description WHERE id = _id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LIMMuserExist
DELIMITER //
CREATE PROCEDURE `LIMMuserExist`(
	IN `_User` VARCHAR(50)
)
BEGIN
SELECT USER FROM LIMMUsers WHERE USER = _User;
END//
DELIMITER ;

-- Volcando estructura para tabla develop7_ulsa.LIMMUsers
CREATE TABLE IF NOT EXISTS `LIMMUsers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Password` blob NOT NULL,
  `Description` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Falta editar.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Luis Isaac Miranda Morales';

-- Volcando datos para la tabla develop7_ulsa.LIMMUsers: ~3 rows (aproximadamente)
DELETE FROM `LIMMUsers`;
/*!40000 ALTER TABLE `LIMMUsers` DISABLE KEYS */;
INSERT INTO `LIMMUsers` (`id`, `User`, `Password`, `Description`) VALUES
	(5, 'Luis_Isaac', _binary 0xA45FB0DDB599A61BA6F684AB9C19FE85, 'Mucho gusto, estudio en la ULSA'),
	(7, 'UsuarioPrueba', _binary 0xC383CFFA32F97875CEAA52D371ED6003, 'Usuario promedio.'),
	(8, 'Pepito', _binary 0xE5647342C74BB1458861C2D3B2B0C9D1, 'asjdhfkajsdf');
/*!40000 ALTER TABLE `LIMMUsers` ENABLE KEYS */;

-- Volcando estructura para procedimiento develop7_ulsa.listComic
DELIMITER //
//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LV_Actualizar
DELIMITER //
CREATE PROCEDURE `LV_Actualizar`(
In PID INT,
IN PName VARCHAR(45),
IN PPass VARCHAR(45))
BEGIN

UPDATE `develop7_ulsa`.`LV_usuarios` SET `Name` = PName,  `Password` = AES_ENCRYPT(PPass , PName)   WHERE (`id` = PId);

END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LV_Borrar
DELIMITER //
CREATE PROCEDURE `LV_Borrar`(
IN p_id int)
BEGIN

DELETE FROM `develop7_ulsa`.`LV_usuarios` WHERE (`id` = p_id);
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LV_ExActualizar
DELIMITER //
CREATE PROCEDURE `LV_ExActualizar`(
In PID INT,
IN PName VARCHAR(45),
IN PPrecio INT,
IN PSotck INT
)
BEGIN
UPDATE `develop7_ulsa`.`LV_productos` SET `Name` = PName,  `Price` = PPrecio,`Stock` = PSotck WHERE (`id` = PId);

END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LV_ExBorrar
DELIMITER //
CREATE PROCEDURE `LV_ExBorrar`(
IN p_id int)
BEGIN
DELETE FROM `develop7_ulsa`.`LV_productos` WHERE (`id` = p_id);
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LV_ExCrearPro
DELIMITER //
CREATE PROCEDURE `LV_ExCrearPro`(
IN PName VARCHAR(45),
IN PPrecio INT,
IN PStock INT)
BEGIN
INSERT INTO `develop7_ulsa`.`LV_productos` (`Name`, `Price`, `Stock`, `User`) VALUES (PName, PPrecio, PStock, 0);
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LV_ExCrearUs
DELIMITER //
CREATE PROCEDURE `LV_ExCrearUs`(
IN PName VARCHAR(45),
IN PPass VARCHAR(45),
IN SEMILLA VARCHAR(255)
)
BEGIN
INSERT INTO `develop7_ulsa`.`LV_productos` (`Name`, `Password`, `Key_V`, `User`) VALUES (PName, AES_ENCRYPT(PPass , SEMILLA), SEMILLA, 1);
END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LV_ExValidar
DELIMITER //
CREATE PROCEDURE `LV_ExValidar`(
IN PName VARCHAR(45),
IN PPass VARCHAR(45),
IN SEMILLA VARCHAR(255))
BEGIN

SELECT Name FROM develop7_ulsa.LV_productos WHERE Name = PName AND Password = AES_ENCRYPT(PPass , SEMILLA);

END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.LV_Insertar
DELIMITER //
CREATE PROCEDURE `LV_Insertar`(
IN PName VARCHAR(45),
IN PPass VARCHAR(45),
IN SEMILLA VARCHAR(255)
)
BEGIN

INSERT INTO `develop7_ulsa`.`LV_usuarios` (`Name`, `Password`) VALUES (PName, AES_ENCRYPT(PPass , SEMILLA));

END//
DELIMITER ;

-- Volcando estructura para tabla develop7_ulsa.LV_productos
CREATE TABLE IF NOT EXISTS `LV_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `Stock` int(11) DEFAULT NULL,
  `Password` blob,
  `Key_V` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `User` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla develop7_ulsa.LV_productos: ~7 rows (aproximadamente)
DELETE FROM `LV_productos`;
/*!40000 ALTER TABLE `LV_productos` DISABLE KEYS */;
INSERT INTO `LV_productos` (`id`, `Name`, `Price`, `Stock`, `Password`, `Key_V`, `User`) VALUES
	(3, 'User', NULL, NULL, _binary 0x65FD42C9C93D8092AB44A30822F98BA7, 'User', 1),
	(6, 'Luna', NULL, NULL, _binary 0x5C0FDD1F3308C9C016695797537A8B93, 'Luna', 1),
	(7, 'Luna', NULL, NULL, _binary 0x5C0FDD1F3308C9C016695797537A8B93, 'Luna', 1),
	(9, 'User', NULL, NULL, _binary 0x65FD42C9C93D8092AB44A30822F98BA7, 'User', 1),
	(14, 'adfsd', 12323, 1232, NULL, NULL, 0),
	(15, 'Lu1', NULL, NULL, _binary 0x1576BD92AC40AC4305E8212E2E25ED8F, 'LI', 1);
/*!40000 ALTER TABLE `LV_productos` ENABLE KEYS */;

-- Volcando estructura para tabla develop7_ulsa.LV_usuarios
CREATE TABLE IF NOT EXISTS `LV_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Datos` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Password` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla develop7_ulsa.LV_usuarios: ~3 rows (aproximadamente)
DELETE FROM `LV_usuarios`;
/*!40000 ALTER TABLE `LV_usuarios` DISABLE KEYS */;
INSERT INTO `LV_usuarios` (`id`, `Name`, `Datos`, `Password`) VALUES
	(15, 'l', NULL, _binary 0x819A535D8CCE4B3C6349B5F77C8BCBAD),
	(16, '1', NULL, _binary 0x4FB5DCFF1E2825CFB154032A43E93903),
	(17, 'Luis Carlos', NULL, _binary 0x75EB64791A94949F283DE5D2D97D1FB2),
	(20, 'Luis', NULL, _binary 0xA522803F6CD5B87E1186D3FE57C2F1D5);
/*!40000 ALTER TABLE `LV_usuarios` ENABLE KEYS */;

-- Volcando estructura para procedimiento develop7_ulsa.LV_Validacion
DELIMITER //
CREATE PROCEDURE `LV_Validacion`(
IN PName VARCHAR(45),
IN PPass VARCHAR(45),
IN SEMILLA VARCHAR(255)
)
BEGIN

SELECT Name, Datos FROM develop7_ulsa.LV_usuarios WHERE Name = PName AND Password = AES_ENCRYPT(PPass , SEMILLA);

END//
DELIMITER ;

-- Volcando estructura para tabla develop7_ulsa.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla develop7_ulsa.migrations: ~4 rows (aproximadamente)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2021_05_10_230708_create_libros', 1),
	(5, '2021_05_10_230654_create_libros', 2),
	(6, '2021_05_29_211111_create_programs', 3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla develop7_ulsa.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla develop7_ulsa.password_resets: ~0 rows (aproximadamente)
DELETE FROM `password_resets`;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla develop7_ulsa.programs
CREATE TABLE IF NOT EXISTS `programs` (
  `idProgram` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nameProgram` varchar(255) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `chapters` int(11) NOT NULL,
  `month` varchar(255) NOT NULL,
  PRIMARY KEY (`idProgram`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla develop7_ulsa.programs: ~3 rows (aproximadamente)
DELETE FROM `programs`;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` (`idProgram`, `nameProgram`, `genre`, `chapters`, `month`) VALUES
	(5, 'Crash Landing On You', 'Drama', 16, 'January'),
	(6, 'Goblin', 'Drama', 16, 'April'),
	(9, 'Avatar', 'Anime', 50, 'March');
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;

-- Volcando estructura para tabla develop7_ulsa.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla develop7_ulsa.users: ~0 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para tabla develop7_ulsa.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `contrasena` blob,
  `llave` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usuario` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla develop7_ulsa.usuarios: ~6 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`contrasena`, `llave`, `usuario`, `id`) VALUES
	(_binary 0xB42BD8B5234CF73E842E2C5AFBD22DC5, 'foo', 'foo', 6),
	(_binary 0xAD249C2C7C780C6F841619191EA73647, 'ioo', 'ioo', 17),
	(_binary 0x857A193CB88F0238B85CCD3B591AD48B, 'loo', 'loo', 18),
	(_binary 0xB0BB67A8FD8F91B5E0C4B15DDD3D8CCA, 'ño', 'ño', 19),
	(_binary 0x6A5769096C4498906127B102BDC1381B, 'boo', 'boo', 20),
	(_binary 0x857A193CB88F0238B85CCD3B591AD48B, 'loo', 'loo', 21),
	(_binary 0xDC4A86E0C7DA59B29392033FD6BB3E57, 'raul', 'Raul', 22);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Volcando estructura para procedimiento develop7_ulsa.Validacion
DELIMITER //
CREATE PROCEDURE `Validacion`(
IN PName VARCHAR(45),
IN PPass VARCHAR(45),
IN SEMILLA VARCHAR(255)
)
BEGIN

SELECT Name, Datos FROM develop7_ulsa.LV_usuarios WHERE Name = PName AND  AES_ENCRYPT(PPass , SEMILLA);

END//
DELIMITER ;

-- Volcando estructura para procedimiento develop7_ulsa.Validar
DELIMITER //
CREATE PROCEDURE `Validar`(
in PName varchar(45),
in pPass varchar(45),
in pkey varchar(45)
)
BEGIN

select Name from LV_productos where (Name = PName and Password = aes_encrypt(PPass, Pkey));

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
