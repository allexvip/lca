-- Дамп структуры базы данных SudAct
CREATE DATABASE IF NOT EXISTS `SudAct` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `SudAct`;

-- Дамп структуры для таблица SudAct.caseClasses
CREATE TABLE IF NOT EXISTS `caseClasses` (
  `idcaseClasses` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idcaseClasses`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.caseClasses: ~7 rows (приблизительно)
DELETE FROM `caseClasses`;
/*!40000 ALTER TABLE `caseClasses` DISABLE KEYS */;
INSERT INTO `caseClasses` (`idcaseClasses`, `Name`) VALUES
	(1, 'Режим воспитания'),
	(2, 'Определение места жительства'),
	(3, 'Развод'),
	(4, 'Раздел имущества'),
	(5, 'Выезд за границу'),
	(8, 'Лишение родительских прав'),
	(9, 'Алименты');
/*!40000 ALTER TABLE `caseClasses` ENABLE KEYS */;

-- Дамп структуры для таблица SudAct.caseJudges
CREATE TABLE IF NOT EXISTS `caseJudges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `custodyCaseID` varchar(12) CHARACTER SET latin1 NOT NULL,
  `judgeID` varchar(12) CHARACTER SET latin1 NOT NULL,
  `Name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.caseJudges: ~1 554 rows (приблизительно)
DELETE FROM `caseJudges`;
/*!40000 ALTER TABLE `caseJudges` DISABLE KEYS */;


-- Дамп структуры для таблица SudAct.caseReasons
CREATE TABLE IF NOT EXISTS `caseReasons` (
  `idcaseReasons` int NOT NULL AUTO_INCREMENT,
  `reasonText` varchar(3000) DEFAULT NULL,
  `custodyCaseID` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`idcaseReasons`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.caseReasons: ~1 043 rows (приблизительно)
DELETE FROM `caseReasons`;


-- Дамп структуры для таблица SudAct.caseReasonsCopy
CREATE TABLE IF NOT EXISTS `caseReasonsCopy` (
  `idcaseReasons` int NOT NULL AUTO_INCREMENT,
  `reasonText` varchar(2000) DEFAULT NULL,
  `custodyCaseID` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`idcaseReasons`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.caseReasonsCopy: ~870 rows (приблизительно)
DELETE FROM `caseReasonsCopy`;
/*!40000 ALTER TABLE `caseReasonsCopy` DISABLE KEYS */;


-- Дамп структуры для таблица SudAct.casesSplittedIntoMainParts
CREATE TABLE IF NOT EXISTS `casesSplittedIntoMainParts` (
  `custodyCaseID` varchar(12) CHARACTER SET latin1 NOT NULL,
  `Name` text,
  `Intro` text,
  `FactsAndResoning` mediumtext,
  `Decision` text,
  `CourtName` varchar(200) DEFAULT NULL,
  `CourtID` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `Category` varchar(200) DEFAULT NULL,
  `SubCategory` text,
  PRIMARY KEY (`custodyCaseID`),
  FULLTEXT KEY `fulltextIndex` (`Intro`,`FactsAndResoning`,`Decision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.casesSplittedIntoMainParts: ~1 233 rows (приблизительно)
DELETE FROM `casesSplittedIntoMainParts`;
/*!40000 ALTER TABLE `casesSplittedIntoMainParts` DISABLE KEYS */;


-- Дамп структуры для таблица SudAct.classReasonMatches
CREATE TABLE IF NOT EXISTS `classReasonMatches` (
  `idclassReasonMatches` int NOT NULL AUTO_INCREMENT,
  `idcaseClasses` int DEFAULT NULL,
  `idcaseReasons` int DEFAULT NULL,
  PRIMARY KEY (`idclassReasonMatches`),
  KEY `idcaseReasons` (`idcaseReasons`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.classReasonMatches: ~1 292 rows (приблизительно)
DELETE FROM `classReasonMatches`;
/*!40000 ALTER TABLE `classReasonMatches` DISABLE KEYS */;


-- Дамп структуры для таблица SudAct.classReasonMatchesCopy
CREATE TABLE IF NOT EXISTS `classReasonMatchesCopy` (
  `idclassReasonMatches` int NOT NULL AUTO_INCREMENT,
  `idcaseClasses` int DEFAULT NULL,
  `idcaseReasons` int DEFAULT NULL,
  PRIMARY KEY (`idclassReasonMatches`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.classReasonMatchesCopy: ~1 041 rows (приблизительно)
DELETE FROM `classReasonMatchesCopy`;
/*!40000 ALTER TABLE `classReasonMatchesCopy` DISABLE KEYS */;


-- Дамп структуры для таблица SudAct.Corrections
CREATE TABLE IF NOT EXISTS `Corrections` (
  `idCorrections` int NOT NULL AUTO_INCREMENT COMMENT '\n',
  `tableName` varchar(45) DEFAULT NULL,
  `columnName` varchar(45) DEFAULT NULL,
  `custodyCaseID` varchar(45) DEFAULT NULL,
  `old` text,
  `new` text,
  `fixed` tinyint DEFAULT NULL,
  PRIMARY KEY (`idCorrections`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.Corrections: ~29 rows (приблизительно)
DELETE FROM `Corrections`;
/*!40000 ALTER TABLE `Corrections` DISABLE KEYS */;


-- Дамп структуры для таблица SudAct.CustodyCasesList
CREATE TABLE IF NOT EXISTS `CustodyCasesList` (
  `custodyCaseID` varchar(12) CHARACTER SET latin1 NOT NULL,
  `Name` text,
  `Html` mediumtext,
  PRIMARY KEY (`custodyCaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Дамп данных таблицы SudAct.CustodyCasesList: ~1 466 rows (приблизительно)
DELETE FROM `CustodyCasesList`;
/*!40000 ALTER TABLE `CustodyCasesList` DISABLE KEYS */;