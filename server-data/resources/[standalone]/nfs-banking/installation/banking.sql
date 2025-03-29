-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.3.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table esxlegacy_219e9c.banking_cards
CREATE TABLE IF NOT EXISTS `banking_cards` (
  `owner` varchar(50) NOT NULL,
  `iban` varchar(8) NOT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table esxlegacy_219e9c.banking_cards: ~2 rows (approximately)
REPLACE INTO `banking_cards` (`owner`, `iban`, `data`) VALUES
	('char1:801b80054f9c4983433beac722a5a852c74d9284', '6a2acc37', '{"quick_transfer_users":[{"userName":"1wsd","iban":"5e204114"}],"freeze":false,"day_stats":{"expense":102,"income":400},"balance":298,"main":true}'),
	('char1:801b80054f9c4983433beac722a5a852c74d9284', '5e204114', '{"quick_transfer_users":[],"freeze":false,"day_stats":{"expense":0,"income":2},"balance":2,"main":true}');

-- Dumping structure for table esxlegacy_219e9c.banking_transactions
CREATE TABLE IF NOT EXISTS `banking_transactions` (
  `iban` varchar(8) NOT NULL,
  `data` longtext DEFAULT NULL,
  KEY `iban` (`iban`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table esxlegacy_219e9c.banking_transactions: ~1 rows (approximately)
REPLACE INTO `banking_transactions` (`iban`, `data`) VALUES
	('6a2acc37', '[{"date":1714345611,"id":"f278df65","amount":100,"note":"","type":"deposit"},{"date":1714345614,"id":"26fc6a32","amount":100,"note":"","type":"deposit"},{"date":1714345618,"id":"1d2ae526","amount":100,"note":"","type":"deposit"},{"date":1714345621,"id":"3bba329a","amount":100,"note":"","type":"widthraw"},{"date":1714345624,"id":"43bb83b1","amount":100,"note":"","type":"deposit"}]');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
