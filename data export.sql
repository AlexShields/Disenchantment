-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: testdisenchantment
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `addelementhastraitview`
--

DROP TABLE IF EXISTS `addelementhastraitview`;
/*!50001 DROP VIEW IF EXISTS `addelementhastraitview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `addelementhastraitview` AS SELECT 
 1 AS `TraitName`,
 1 AS `ElementID`,
 1 AS `ElementReferenceName`,
 1 AS `TraitID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `addelementnameview`
--

DROP TABLE IF EXISTS `addelementnameview`;
/*!50001 DROP VIEW IF EXISTS `addelementnameview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `addelementnameview` AS SELECT 
 1 AS `ElementReferenceName`,
 1 AS `ElementID`,
 1 AS `SceneIncludesElementID`,
 1 AS `SceneID`,
 1 AS `SceneHasExampleOfElementNameID`,
 1 AS `EvidenceDescription`,
 1 AS `ElementHasNameID`,
 1 AS `ElementNameID`,
 1 AS `ElementName`,
 1 AS `NameType`,
 1 AS `NamePriority`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `addelementrelationshipview`
--

DROP TABLE IF EXISTS `addelementrelationshipview`;
/*!50001 DROP VIEW IF EXISTS `addelementrelationshipview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `addelementrelationshipview` AS SELECT 
 1 AS `ElementReferenceName`,
 1 AS `Element1ID`,
 1 AS `SceneIncludesElementID`,
 1 AS `SceneID`,
 1 AS `SceneAddressesElementRelationshipID`,
 1 AS `SceneAddressesElementRelationshipDescription`,
 1 AS `ElementHasRelationshipToElementID`,
 1 AS `Element2ID`,
 1 AS `RelationshipDurationID`,
 1 AS `RelationshipPriority`,
 1 AS `Element1InheritsTraitsFromElement2`,
 1 AS `RelationshipType`,
 1 AS `RelationshipID`,
 1 AS `RelationshipInstance`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `element`
--

DROP TABLE IF EXISTS `element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `element` (
  `ElementID` int NOT NULL AUTO_INCREMENT,
  `ElementType` varchar(45) NOT NULL,
  `ElementReferenceName` varchar(255) DEFAULT NULL,
  `ElementDescription` varchar(4095) DEFAULT NULL,
  PRIMARY KEY (`ElementID`),
  UNIQUE KEY `ElementID_UNIQUE` (`ElementID`),
  UNIQUE KEY `ElementReferenceName_UNIQUE` (`ElementReferenceName`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element`
--

LOCK TABLES `element` WRITE;
/*!40000 ALTER TABLE `element` DISABLE KEYS */;
INSERT INTO `element` VALUES (1,'Location','Dreamland','Kingdom that the series centers around. '),(2,'Establishment','Dreamland Apothecary','The apothecary in dreamland'),(3,'Location','Badlands','Location near Dreamland'),(4,'Establishment','Dankmire Bar','The Bar depicted in Dankmire'),(5,'Location','Bentwood','A wealthy kingdom to the west of dreamland and the enchanted forest'),(6,'Establishment','Dreamland Castle','The Capitol and royal palace of dreamland.'),(7,'Establishment','Blue Lion Cafe','A cafe within dreamland'),(8,'Establishment','Candy Cabin','A cabin made of candy located in the enchanted forest'),(9,'Establishment','Cave of the Single Trap','A cave located on the devil\'s snowcone, occupied by Malfus'),(10,'Location','Cremorrah','The Lost City of Cremorrah hidden under a desert'),(11,'Location','Dankmire','A magical realm and the home of the Salamanders. It is located in a large swamp and is centered around water canals located to the south of dreamland'),(12,'Establishment','Dankmire Childrens Theatre','A community playhouse in Dankmire'),(13,'Establishment','The Den Of Wonders','A drug den in the Black Light District of Dreamland'),(14,'Location','The Devil\'s Punchbowl','A large desert located west of Bentwood.\n\n'),(15,'Location','The Devil\'s Snowcone','A large snow-covered mountain near Dreamland'),(16,'Location','Earth','An alternate version of earth the show is believed to take place in'),(17,'Location','Edge of the World','The edge of the known world. Its a very steep cliff into oblivion. '),(18,'Location','Elf Alley','An Elf refuge located within the city of Dreamland'),(19,'Location','The Enchanted Forest','A magical forest with critters next to Dreamland.'),(20,'Establishment','Gift Shoppe at the Edge of the World','A shop located at the Edge of the World'),(21,'Establishment','Gumdrop Tree\n','A large tree which bears Gumdrops as fruits, located in Elfwood'),(22,'Location','Heaven','Home and creation of God and all angels. It serves as an afterlife for deceased mortals who led morally good lives.'),(23,'Location','Hell','the magical realm below the Earth and home of all demons. It also serves as the afterlife for deceased mortals who committed many sins in life.'),(24,'Establishment','Little Seizures Poison Shop\n','A store in Dreamland that sells poisons.'),(25,'Establishment','Luci\'s Inferno','A tavern in Dreamland '),(26,'Location','Maru','A desert empire neighboring the abandoned city-state of Cremorrah.'),(27,'Location','Mt. Piping Hot Suckhole','A volcano used by Big Jo to kill demons'),(28,'Establishment','Muddruckers','A restaurant in Dankmire'),(29,'Location','Ogreland','The kingdom and homeland of the Ogres.'),(30,'Establishment','Our Lady of Unlimited Chastity','A monastery church in Dreamland that is located on a hill near the city'),(31,'Establishment','P.T. Freak Show\n','A building in steamland run for the depiction of beings that people would pay to come see'),(32,'Establishment','The Plague Pit','A pit where the Plague Patrol dumps and cremates the dead bodies of plague victims'),(33,'Establishment','Runoff Springs Health Spa\n','A healthspa Zog retreats to after drinking bad well water. '),(34,'Location','Steamland','A city-state and kingdom in a continent far away from Dreamland. '),(35,'Establishment','The Jittery','A coffee shop located within Dreamland'),(36,'Establishment','The Spotted Liver Ale House','A tavern located in Dreamland and is where Bean says she was raised by a group of drinking buddies. She has been shown to play cards there'),(37,'Establishment','Bentwood Torture Chamber','The torture chamber within the Bentwood palace'),(38,'Location','Trøgtown','The subterranean home of the Trøgs, located beneath Dreamland Castle.'),(39,'Establishment','Twinkle Town Insane Asylum\n','a mental institution in Twinkle Town'),(40,'Location','Unpassable Mountains','A mountain range near Dreamland. Despite the name they are passable.'),(41,'Location','The Valley of Scorpions','The valley through the Unpassable Mountains'),(42,'Location','Walrus Island','An island located some distance away from the coast of Dreamland, and is very close to Mermaid Island.'),(43,'Location','Mermaid Island','a fabled and large island country in the Sea of Dreamland, which is located some distance away from the coast of Dreamland, and is very close to Walrus Island'),(44,'Character','Alva Gunderson','The founder of Steamland and head of Gunderson Steamwork company.'),(45,'Character','Annoyo','Elf who presumably is annoying'),(46,'Character','Arch-Druidess','The top priestess of the official state religion of Dreamland'),(47,'Group','Aristocrats','Characters who are monarchs, royalty, or other nobility'),(48,'Character','Asmodium','A powerful demon lord in Hell'),(49,'Character','Assassin','The stealthiest assassin of Maru'),(50,'Character','Bad Bean','Bean\'s evil alter-ego.'),(51,'Character','Wade Brody Sr.','Captain of the El De Barge.'),(52,'Character','Rebecca','A Maruvian princess and sorceress'),(53,'Character','Big Jo','The world\'s leading exorcist'),(54,'Physical Object','Bloaty the Squirrel','A dead squirrel with a backstory made up by Elfo as part of a ruse by Bean to try to get Sven and the vikings the drink the filthy, contaminated water from the water fountain.'),(55,'Character','Bob','A giant man that went on a rampage in the \'80s.'),(56,'Character','Bozak Admiral','He was the naval commander of a Bozak warship'),(57,'Character','Bunty','Bean\'s handmaid'),(58,'Character','Bunty Junior','Bunty Junior is a daughter of Bunty who looks like a miniature version of her mother'),(59,'Character','Cedric','A local shephard in Dreamland.'),(60,'Character','Chancellor of Dankmire','a high-ranking politician from Dankmire'),(61,'Character','Chazzzzz','a Dankmirian man who works in various different jobs.'),(62,'Group','Clergy','Priests, priestesses, and other religious officials.'),(63,'Character','Cloyd','he uncharismatic ruler of the Empire of Maru'),(64,'Group','Swamp People Duo','a duo of farmers who live deep in the swamps of Dankmire.'),(65,'Character','Darrell','The lone employee at the Gift Shoppe at the Edge of the World'),(66,'Character','Old Peddler','An old man who sells his bathing water'),(67,'Character','Derek','The son of Zøg and  Oona'),(68,'Character','Edgar the Fearless','ne of the bravest knights in the Knight of the Zøg Table'),(69,'Character','Edith','A performer as a psychic  head in P.T.\'s Steamland Freak Show'),(70,'Character','Elastico','a member of the Troll Circus Troupe. He is a contortionist and the world\'s stretchiest troll'),(71,'Character','Elfo','the tritagonist of Disenchantment. He lives in Dreamland, and is Princess Bean\'s companion'),(72,'Character','Examplo','According to Elfo, if you look up \"elf\" in the dictionary, Examplo appears as the picture next to the definition.'),(73,'Character','Farmer','a man who Elfo found early on during his journey. '),(74,'Character','Freckles','Freckles is a ventriloquist dummy that is alive'),(75,'Character','Giggles','Giggles is an imprisoned murderer in Twinkletown Insane Asylum'),(76,'Character','God','God is the supreme, omnipotent deity who created the universe.'),(77,'Character','Griffin','nnamed griffin that lives in a cliffside nest along the Edge of the World.'),(78,'Character','Grifto','A troll circus ringmaster and con artist'),(79,'Character','Grindl','Bentwood\'s resident scholar of magic'),(80,'Character','Gwen','She is a witch who lives in the Enchanted Forest.'),(81,'Character','Hansel ','The boy of a pair of cannibalistic serial killers who lure people into their Candy Cabin to kill and eat them.'),(82,'Character','Gretel','The girl of a pair of cannibalistic serial killers who lure people into their Candy Cabin to kill and eat them.'),(83,'Character','Harriet','A citizen of Steamland who works for Alva'),(84,'Character','Herald','A messenger who announces the latest news and events around Dreamland.'),(85,'Character','Inky Winky\n','Inky Winky is an inmate of P.T.s Freak show'),(86,'Character','Jasper',' A young Forest Selkie as well as the natural son of Ursula and Zøg'),(87,'Character','Jerry','he youngest brother of Queen Dagmar, Becky and Cloyd'),(88,'Character','Jester','The fool in King Zøg\'s Court.'),(89,'Character','Junior','The only survivor of a deadly battle between armies of ogres and gnomes. '),(90,'Character','Kilt Man','A dreamlander who wears a kilt'),(91,'Character','Agøgg','The first king of Dreamland.'),(92,'Character','Brock','The ruler of the Ogre kingdom.'),(93,'Character','Doris','The last king of Cremorrah.'),(94,'Character','Dripo','King of the Sea Trøgs.'),(95,'Character','King of Dankmire','The King of Dankmire'),(96,'Character','Rulo','the King of the Elves'),(97,'Character','Xøg','The father of Yøg and Zøg,'),(98,'Character','Yøg','as the son of Bee-Baw, the older brother of Zøg,'),(99,'Character','Kissy',' a female elf and daughter of the Elf King'),(100,'Character','Lady Bowmore\n',' member of The League of Gallivanting Scrutinators who lives in Steamland'),(101,'Character','Lady in the Lake','a nymph (nature spirit) that lives in the Enchanted Forest.'),(102,'Character','Laughing Horse','A horse with the ability to laugh like a human'),(103,'Character','Leavo','An Elf who left Elfwood before the start of the series'),(104,'Character','Lady Lingonberry','the wife of Lord Lingonberry.'),(105,'Character','Lord Lingonberry','An old nobleman from Dreamland'),(106,'Character','Lorenzo I','The king of Bentwood'),(107,'Character','Luci','The deuteragonist in Disenchantment. He lives in Dreamland, is Princess Bean\'s \"personal demon\"'),(108,'Character','Luci\'s Lawyer','Luci\'s Lawyer'),(109,'Character','Malfus','Man who resides in resides in the Cave of the Single Trap'),(110,'Character','Mariabeanie','Grandmother of Dagmar, Becky, Cloyd and Jerry'),(111,'Character','Mephismo','Author of ancient writings'),(112,'Group','Royal Family of Maru','The imperial family of Maru'),(113,'Character','Mermaid Queen','The Queen of Mermaid Island and mother of Mora'),(114,'Character','Mrs. Mertz','Sir Mertz\'s mother'),(115,'Character','Sir Mertz','A Knight of the Zog Table'),(116,'Character','Miri','Mop Girl in Dreamland castle'),(117,'Character','Miss Moonpence',' a servant and secretary to Prime Minister Odval of Dreamland'),(118,'Character','Mora','The princess of Mermaid Island'),(119,'Character','Mortimer the Expendable','a Knight of the Zøg Table'),(120,'Character','Mother Superior','The head nun in charge of a monastery called Our Lady of Unlimited Chastity'),(121,'Character','Odval','Prime minster of Dreamland and the top royal advisor'),(122,'Character','Ogler','Unnamed minor character in Disenchantment. He was a castle servant who was beheaded after he looked at Bean topless'),(123,'Character','Old Chef\n','The old chef who runs a restaurant in Dankmire.'),(124,'Character','Old Man Touchy','an old man with no eyes who can identify anything he touches'),(125,'Character','P.T. McGee','Owner of the freak show'),(126,'Character','Philip J. Fry','The main character in the show Futurama'),(127,'Character','Bender','Bender from Futurama'),(128,'Character','Professor','The professor from Futurama'),(129,'Character','Pig-Merkimer','A pig who is made to look like Merkimer when Merkimer turns into a pig'),(130,'Character','Plague Doctor','Doctor who works at the Apothecary'),(131,'Group','Plague Patrol','a man and a wagon which picks up diseased remains and tosses them into the Plague Pit before cremating them. '),(132,'Group','Policemen',' law enforcement officers in Dreamland'),(133,'Character','Pops','Elfo\'s Father'),(134,'Character','Porky','Big Jo\'s assistant'),(135,'Character','Guysbert','Eldest son of the royal family of Bentwood'),(136,'Character','Merkimer','the son/nephew of King Lorenzo I and Queen Bunny, Turned into a pig before he could marry Bean'),(137,'Character','Pyro','A troll who can breathe fire'),(138,'Character','Bean','Tiabeanie Mariabeanie de la Rochambeaux Grunkwitz, better known as Bean[2], is the main character of Disenchantment. She is the 19-year-old Princess of Dreamland'),(139,'Character','Bee-Baw','The mother of the King Yøg and the King Zøg,'),(140,'Character','Queen Bunny','The queen of Bentwood'),(141,'Character','Dagmar','The Maruvian-born former queen of Dreamland'),(142,'Character','Grogda','The ruler of Ogre Valley and the wife of the King Brock,'),(143,'Character','Queen of Dankmire','The Queen of Dankmire'),(144,'Character','Oona','The second wife of King Zøg, the mother of the Prince Derek, and the stepmother of the Queen Bean.'),(145,'Character','Racist Antelope','A speaking antelope known to be racist'),(146,'Character','Returno','An elf who was implied to have left Elfwood'),(147,'Character','Rhonda','The daughter of the Mermaid Queen and sister of Mora as well as Princess of Mermaid Island'),(148,'Character','Roger','An unseen, one-time character in the plague pit'),(149,'Character','Sagatha','A magical fairy that lived in the Enchanted Forest'),(150,'Character','Satan','The King of Hell'),(151,'Character','Scribe','A man who writes down and narrates events while they happen'),(152,'Character','Scruffles','A talking cat and lives in Dreamland'),(153,'Character','Shelly','The sole female member of the Troll Circus Troupe'),(154,'Character','Shocko','Elf with a a habit of expressing his shock and surprise by gasping out loud'),(155,'Character','Shrimpo','An elf who is much shorter than other adult elves, and dates Kissy after Elfo'),(156,'Character','Singo','An elf who especially enjoys singing'),(157,'Character','Pendergast','The leader of the knights of the zog table'),(158,'Character','Sky Gunderson','a scientist, inventor, mechanic and airship pilot from Steamland'),(159,'Character','Slapo','A beast tamer and member of the Troll Circus Troupe'),(160,'Character','Sorcerio','A wizard who served as a scientific advisor on both natural and magical matters to King Zøg'),(161,'Character','Speako','An elf who is known to be talkative'),(162,'Character','Stacianne LeBlatt','One of the demons captured by Big Jo. She is an ex-girlfriend of Luci'),(163,'Character','Stan','The Royal Executioner'),(164,'Character','Stryker','A knight of the Zøg Table'),(165,'Character','Bolt','A knight of the Zøg Table'),(166,'Character','Superviso','the supervisor of the candy factory in Elfwood.'),(167,'Character','Sven','Regional manager of the Land Vikings'),(168,'Character','Tess','A giant who lives past the unpassable mountains'),(169,'Character','Trixy','female Trøg who formed a relationship with Elfo'),(170,'Character','Turbish','A Knight of the Zøg Table'),(171,'Character','Ursula','A Selkie who lives in the Enchanted Forest.'),(172,'Character','Vip','attendant to King Zøg '),(173,'Character','Vap','attendant to King Zøg '),(174,'Character','Voop','attendant to King Zøg '),(175,'Character','Washmaster','an elderly man who washes clothing'),(176,'Character','Watcho','A guard at the magical entrance gate that conceals Elfwood '),(177,'Character','Weirdo','A perverted elf'),(178,'Character','Witch','The witch accused of kidnapping and eating children'),(179,'Character','Worko','An elderly elf from Elfwood.'),(180,'Character','Zøg','The father of Bean and King of Dreamland');
/*!40000 ALTER TABLE `element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementhaselementname`
--

DROP TABLE IF EXISTS `elementhaselementname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elementhaselementname` (
  `ElementHasNameID` int NOT NULL AUTO_INCREMENT,
  `ElementID` int NOT NULL,
  `ElementNameID` int NOT NULL,
  PRIMARY KEY (`ElementHasNameID`),
  KEY `fk_Element_Has_Name_Element1_idx` (`ElementID`),
  KEY `fk_Element_Has_ElementName_ElementName1_idx` (`ElementNameID`),
  CONSTRAINT `fk_Element_Has_ElementName_ElementName1a` FOREIGN KEY (`ElementNameID`) REFERENCES `elementname` (`ElementNameID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Element_Has_Name_Element1a` FOREIGN KEY (`ElementID`) REFERENCES `element` (`ElementID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementhaselementname`
--

LOCK TABLES `elementhaselementname` WRITE;
/*!40000 ALTER TABLE `elementhaselementname` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementhaselementname` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementhasrelationshiptoelement`
--

DROP TABLE IF EXISTS `elementhasrelationshiptoelement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elementhasrelationshiptoelement` (
  `ElementHasRelationshipToElementID` int NOT NULL AUTO_INCREMENT,
  `Element1ID` int NOT NULL,
  `RelationshipID` int NOT NULL,
  `Element2ID` int NOT NULL,
  `Explanation` varchar(255) DEFAULT NULL,
  `RelationshipDurationID` int DEFAULT NULL,
  `RelationshipPriority` decimal(4,2) DEFAULT NULL,
  `Element1InheritsTraitsFromElement2` int DEFAULT NULL,
  `RelationshipInstance` int DEFAULT NULL,
  PRIMARY KEY (`ElementHasRelationshipToElementID`),
  KEY `fk_Scene_Establishes_El_Relationship_To_El_El1_idx` (`Element1ID`),
  KEY `fk_Scene_Establishes_El_Relationship_To_El_Relation_idx` (`RelationshipID`),
  KEY `fk_Scene_Establishes_El_Relationship_To_El_El2_idx` (`Element2ID`),
  KEY `fk_Element1_Has_Relationship_To_Element2_Duration1_idx` (`RelationshipDurationID`),
  CONSTRAINT `fk_Element_Has_Relationship_To_Element_Duration1b` FOREIGN KEY (`RelationshipDurationID`) REFERENCES `relationshipduration` (`RelationshipDurationID`),
  CONSTRAINT `fk_Scene_Establishes_Element_Relationship_To_Element_Element1b` FOREIGN KEY (`Element1ID`) REFERENCES `element` (`ElementID`),
  CONSTRAINT `fk_Scene_Establishes_Element_Relationship_To_Element_Element2b` FOREIGN KEY (`Element2ID`) REFERENCES `element` (`ElementID`),
  CONSTRAINT `fk_Scene_Establishes_Element_Relationship_To_Element_Rel1b` FOREIGN KEY (`RelationshipID`) REFERENCES `relationship` (`RelationshipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementhasrelationshiptoelement`
--

LOCK TABLES `elementhasrelationshiptoelement` WRITE;
/*!40000 ALTER TABLE `elementhasrelationshiptoelement` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementhasrelationshiptoelement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementhastrait`
--

DROP TABLE IF EXISTS `elementhastrait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elementhastrait` (
  `ElementHasTraitID` int NOT NULL AUTO_INCREMENT,
  `ElementID` int NOT NULL,
  `TraitID` int NOT NULL,
  `TraitDurationID` int DEFAULT NULL,
  `ElementHasTraitDescription` varchar(4095) DEFAULT NULL,
  `TraitPriority` decimal(4,2) DEFAULT NULL,
  `TraitInstance` int DEFAULT NULL,
  PRIMARY KEY (`ElementHasTraitID`),
  KEY `fk_ElementHasTrait_Element1_idx` (`ElementID`),
  KEY `fk_ElementHasTrait_Trait1_idx` (`TraitID`),
  KEY `fk_ElementHasTrait_TraitDuration1_idx` (`TraitDurationID`),
  CONSTRAINT `fk_ElementHasTrait_Element2` FOREIGN KEY (`ElementID`) REFERENCES `element` (`ElementID`),
  CONSTRAINT `fk_ElementHasTrait_Trait1` FOREIGN KEY (`TraitID`) REFERENCES `trait` (`TraitID`),
  CONSTRAINT `fk_ElementHasTrait_TraitDuration1` FOREIGN KEY (`TraitDurationID`) REFERENCES `traitduration` (`TraitDurationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementhastrait`
--

LOCK TABLES `elementhastrait` WRITE;
/*!40000 ALTER TABLE `elementhastrait` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementhastrait` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementname`
--

DROP TABLE IF EXISTS `elementname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elementname` (
  `ElementNameID` int NOT NULL AUTO_INCREMENT,
  `ElementName` varchar(255) DEFAULT NULL,
  `NameType` varchar(255) DEFAULT NULL,
  `NamePriority` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ElementNameID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementname`
--

LOCK TABLES `elementname` WRITE;
/*!40000 ALTER TABLE `elementname` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementname` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode`
--

DROP TABLE IF EXISTS `episode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode` (
  `EpisodeID` int NOT NULL AUTO_INCREMENT,
  `PartID` int DEFAULT NULL,
  `EpisodeName` varchar(255) DEFAULT NULL,
  `Synopsis` varchar(4095) DEFAULT NULL,
  PRIMARY KEY (`EpisodeID`),
  UNIQUE KEY `EpisodeID_UNIQUE` (`EpisodeID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode`
--

LOCK TABLES `episode` WRITE;
/*!40000 ALTER TABLE `episode` DISABLE KEYS */;
INSERT INTO `episode` VALUES (1,1,'A Princess, an Elf, and a Demon Walk Into a Bar','Princess Bean already has the wedding day blues when a mysterious figure arrives, claiming he\'s her personal demon. Elfo hates his happy homeland.'),(2,1,'For Whom the Pig Oinks\n','How to get rid of an unwanted fiancé? Bean\'s plan involves a party barge and mermaids. King Zøg tries to make Elfo\'s blood into an immortality potion.\n\n'),(3,1,'The Princess of Darkness\n','The Princess of Darkness\n'),(4,1,'Castle Party Massacre','With the king away, Bean throws a wild party while Odval and Sorcerio gather their secret society for a ritual, but the night takes a surprising turn.'),(5,1,'Faster, Princess! Kill! Kill!\n','\nBanished from the castle by Zøg, Bean tries to work but has trouble keeping a job. Elfo encounters a bizarre pair of siblings living in a candy house.'),(6,1,'Swamp and Circumstance','Bean tries her hand at diplomacy after Zøg makes her ambassador to Dankmire, Oona\'s kingdom and an important ally for Dreamland.\n\n'),(7,1,'Love\'s Tender Rampage','Elfo lies to hide his feelings for Bean, but things get complicated when she tries to help him by sending the knights on a quest.'),(8,1,'The Limits of Immortality','Elfo\'s been kidnapped! Bean, Luci, Sorcerio and the knights search for him, along with a magical pendant needed to complete the immortality potion.'),(9,1,'To Thine Own Elf Be True','After he learns a surprising secret about himself, Elfo heads home to Elfwood in search of the truth.'),(10,1,'Dreamland Falls','As Dreamland celebrates an unexpected arrival while saying goodbye to a friend, everyday life is thrown into disarray.');
/*!40000 ALTER TABLE `episode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship` (
  `RelationshipID` int NOT NULL AUTO_INCREMENT,
  `RelationshipType` varchar(255) DEFAULT NULL,
  `RelationshipTypeUniversalDescription` varchar(4095) DEFAULT NULL,
  PRIMARY KEY (`RelationshipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship`
--

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationshipduration`
--

DROP TABLE IF EXISTS `relationshipduration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationshipduration` (
  `RelationshipDurationID` int NOT NULL AUTO_INCREMENT,
  `StartSceneDescription` varchar(4095) DEFAULT NULL,
  `EndSceneDescription` varchar(4095) DEFAULT NULL,
  `StartSceneIncludesElementID` int DEFAULT NULL,
  `EndSceneIncludesElementID` int DEFAULT NULL,
  PRIMARY KEY (`RelationshipDurationID`),
  KEY `fk_relationshipduration_sceneincludeselement1_idx` (`StartSceneIncludesElementID`),
  KEY `fk_relationshipduration_sceneincludeselement2_idx` (`EndSceneIncludesElementID`),
  CONSTRAINT `fk_relationshipduration_sceneincludeselement1` FOREIGN KEY (`StartSceneIncludesElementID`) REFERENCES `sceneincludeselement` (`SceneIncludesElementID`),
  CONSTRAINT `fk_relationshipduration_sceneincludeselement2` FOREIGN KEY (`EndSceneIncludesElementID`) REFERENCES `sceneincludeselement` (`SceneIncludesElementID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationshipduration`
--

LOCK TABLES `relationshipduration` WRITE;
/*!40000 ALTER TABLE `relationshipduration` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationshipduration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scene`
--

DROP TABLE IF EXISTS `scene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scene` (
  `SceneID` int NOT NULL AUTO_INCREMENT,
  `SceneName` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_general_ci DEFAULT NULL,
  `EpisodeID` int NOT NULL,
  `SceneDescription` varchar(4095) DEFAULT NULL,
  `Timestamp` decimal(9,3) DEFAULT NULL,
  PRIMARY KEY (`SceneID`),
  KEY `fk_Scene_Episodes_idx` (`EpisodeID`),
  CONSTRAINT `fk_Scene_Episodes` FOREIGN KEY (`EpisodeID`) REFERENCES `episode` (`EpisodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scene`
--

LOCK TABLES `scene` WRITE;
/*!40000 ALTER TABLE `scene` DISABLE KEYS */;
/*!40000 ALTER TABLE `scene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sceneaddresseselementhastrait`
--

DROP TABLE IF EXISTS `sceneaddresseselementhastrait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sceneaddresseselementhastrait` (
  `SceneAddressesElementHasTraitID` int NOT NULL AUTO_INCREMENT,
  `ElementHasTraitID` int NOT NULL,
  `SceneAddressesElementHasTraitDescription` varchar(4095) DEFAULT NULL,
  `SceneIncludesElementID` int NOT NULL,
  PRIMARY KEY (`SceneAddressesElementHasTraitID`),
  UNIQUE KEY `Scene_Has_Example_Of_Element_Has_Trait_UNIQUE` (`SceneAddressesElementHasTraitID`),
  KEY `fk_Scene_Has_Example_Of_Element_Has_Trait_Element_Has_Trait1_idx` (`ElementHasTraitID`),
  KEY `fk_Scene_Addresses_Element_Has_Trait_Scene_Includes_Element1_idx` (`SceneIncludesElementID`),
  CONSTRAINT `fk_Scene_Addresses_Element_Has_Trait_Element_Has_Trait1` FOREIGN KEY (`ElementHasTraitID`) REFERENCES `elementhastrait` (`ElementHasTraitID`),
  CONSTRAINT `fk_Scene_Addresses_Element_Has_Trait_Scene_Includes_Element1a` FOREIGN KEY (`SceneIncludesElementID`) REFERENCES `sceneincludeselement` (`SceneIncludesElementID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sceneaddresseselementhastrait`
--

LOCK TABLES `sceneaddresseselementhastrait` WRITE;
/*!40000 ALTER TABLE `sceneaddresseselementhastrait` DISABLE KEYS */;
/*!40000 ALTER TABLE `sceneaddresseselementhastrait` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sceneaddresseselementrelationship`
--

DROP TABLE IF EXISTS `sceneaddresseselementrelationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sceneaddresseselementrelationship` (
  `sceneAddressesElementRelationshipID` int NOT NULL AUTO_INCREMENT,
  `ElementHasRelationshipToElementID` int NOT NULL,
  `sceneAddressesElementRelationshipDescription` varchar(4095) DEFAULT NULL,
  `sceneIncludesElementID` int NOT NULL,
  `sceneElementAddressingRelationshipID` int DEFAULT NULL,
  `RelationshipID` int DEFAULT NULL,
  PRIMARY KEY (`sceneAddressesElementRelationshipID`),
  KEY `fk_scene_Addresses_Element_Relationship_scene_Includes_Objec_idx` (`sceneIncludesElementID`),
  KEY `fk_sceneaddresseselementrelationship_ehasrelationshipto_idx` (`ElementHasRelationshipToElementID`),
  KEY `fk_sceneaddresseselementrelationship_relationship_idx` (`RelationshipID`),
  KEY `fk_sceneaddresseselementrelationship_elementhasrelationshipb2` (`sceneElementAddressingRelationshipID`),
  CONSTRAINT `fk_scene_Addresses_Element_Relationship_scene_Includes_Element1a` FOREIGN KEY (`sceneIncludesElementID`) REFERENCES `sceneincludeselement` (`SceneIncludesElementID`),
  CONSTRAINT `fk_sceneaddresseselementrelationship_elementhasrelationshipb1` FOREIGN KEY (`sceneIncludesElementID`) REFERENCES `elementhasrelationshiptoelement` (`ElementHasRelationshipToElementID`),
  CONSTRAINT `fk_sceneaddresseselementrelationship_elementhasrelationshipb2` FOREIGN KEY (`sceneElementAddressingRelationshipID`) REFERENCES `element` (`ElementID`),
  CONSTRAINT `fk_sceneaddresseselementrelationship_relationship` FOREIGN KEY (`RelationshipID`) REFERENCES `relationship` (`RelationshipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sceneaddresseselementrelationship`
--

LOCK TABLES `sceneaddresseselementrelationship` WRITE;
/*!40000 ALTER TABLE `sceneaddresseselementrelationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `sceneaddresseselementrelationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenehasexampleofelementname`
--

DROP TABLE IF EXISTS `scenehasexampleofelementname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scenehasexampleofelementname` (
  `SceneHasExampleOfElementNameID` int NOT NULL AUTO_INCREMENT,
  `ElementHasNameID` int NOT NULL,
  `EvidenceDescription` varchar(4095) DEFAULT NULL,
  `SceneIncludesElementID` int NOT NULL,
  PRIMARY KEY (`SceneHasExampleOfElementNameID`),
  KEY `fk_Scene_Has_Example_Of_ElementName_Element_Has_ElementName1_idx` (`ElementHasNameID`),
  KEY `fk_Scene_Has_Example_Of_ElementName_Scene_Includes_Element1_idx` (`SceneIncludesElementID`),
  CONSTRAINT `fk_Scene_Has_Example_Of_ElementName_Element_Has_ElementName1a` FOREIGN KEY (`ElementHasNameID`) REFERENCES `elementhaselementname` (`ElementHasNameID`),
  CONSTRAINT `fk_Scene_Has_Example_Of_ElementName_Scene_Includes_Element1a` FOREIGN KEY (`SceneIncludesElementID`) REFERENCES `sceneincludeselement` (`SceneIncludesElementID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenehasexampleofelementname`
--

LOCK TABLES `scenehasexampleofelementname` WRITE;
/*!40000 ALTER TABLE `scenehasexampleofelementname` DISABLE KEYS */;
/*!40000 ALTER TABLE `scenehasexampleofelementname` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sceneincludeselement`
--

DROP TABLE IF EXISTS `sceneincludeselement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sceneincludeselement` (
  `SceneIncludesElementID` int NOT NULL AUTO_INCREMENT,
  `SceneID` int NOT NULL,
  `ElementID` int NOT NULL,
  `InclusionDescription` varchar(4095) DEFAULT NULL,
  `SequentialID` decimal(11,5) DEFAULT NULL,
  PRIMARY KEY (`SceneIncludesElementID`),
  KEY `fk_SceneIncludesElement_Scenes1_idx` (`SceneID`),
  KEY `fk_SceneIncludesElement_Element1_idx` (`ElementID`),
  CONSTRAINT `fk_SceneIncludesElement_Element1` FOREIGN KEY (`ElementID`) REFERENCES `element` (`ElementID`),
  CONSTRAINT `fk_SceneIncludesElement_Scenes1` FOREIGN KEY (`SceneID`) REFERENCES `scene` (`SceneID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sceneincludeselement`
--

LOCK TABLES `sceneincludeselement` WRITE;
/*!40000 ALTER TABLE `sceneincludeselement` DISABLE KEYS */;
/*!40000 ALTER TABLE `sceneincludeselement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sceneincludeselementhaswish`
--

DROP TABLE IF EXISTS `sceneincludeselementhaswish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sceneincludeselementhaswish` (
  `SceneHasWishID` int NOT NULL AUTO_INCREMENT,
  `WishID` int NOT NULL,
  `WishGrantDeny` varchar(5) DEFAULT NULL,
  `SceneIncludesElementID` int NOT NULL,
  `SceneIncludesElementHasWishDescription` varchar(4095) DEFAULT NULL,
  PRIMARY KEY (`SceneHasWishID`),
  KEY `fk_Scene_Has_Wish_Wish1_idx` (`WishID`),
  KEY `fk_Scene_Has_Wish_Scene_Includes_Element1_idx` (`SceneIncludesElementID`),
  CONSTRAINT `fk_Scene_Has_Wish_Scene_Includes_Element1` FOREIGN KEY (`SceneIncludesElementID`) REFERENCES `sceneincludeselement` (`SceneIncludesElementID`),
  CONSTRAINT `fk_Scene_Has_Wish_Wish1` FOREIGN KEY (`WishID`) REFERENCES `wish` (`WishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sceneincludeselementhaswish`
--

LOCK TABLES `sceneincludeselementhaswish` WRITE;
/*!40000 ALTER TABLE `sceneincludeselementhaswish` DISABLE KEYS */;
/*!40000 ALTER TABLE `sceneincludeselementhaswish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `sceneview`
--

DROP TABLE IF EXISTS `sceneview`;
/*!50001 DROP VIEW IF EXISTS `sceneview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sceneview` AS SELECT 
 1 AS `SceneID`,
 1 AS `SceneName`,
 1 AS `InclusionDescription`,
 1 AS `SceneIncludesElementID`,
 1 AS `ElementID`,
 1 AS `ElementReferenceName`,
 1 AS `TableName`,
 1 AS `SequentialID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `trait`
--

DROP TABLE IF EXISTS `trait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trait` (
  `TraitID` int NOT NULL AUTO_INCREMENT,
  `TraitName` varchar(255) DEFAULT NULL,
  `TraitUniversalDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TraitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trait`
--

LOCK TABLES `trait` WRITE;
/*!40000 ALTER TABLE `trait` DISABLE KEYS */;
/*!40000 ALTER TABLE `trait` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traitduration`
--

DROP TABLE IF EXISTS `traitduration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traitduration` (
  `TraitDurationID` int NOT NULL AUTO_INCREMENT,
  `StartSceneDescription` varchar(4095) DEFAULT NULL,
  `EndSceneDescription` varchar(4095) DEFAULT NULL,
  `StartSceneIncludesElementID` int DEFAULT NULL,
  `EndSceneIncludesElementID` int DEFAULT NULL,
  PRIMARY KEY (`TraitDurationID`),
  KEY `fk_traitduration_sceneincludeselement1_idx` (`StartSceneIncludesElementID`),
  KEY `fk_traitduration_sceneincludeselement2_idx` (`EndSceneIncludesElementID`),
  CONSTRAINT `fk_traitduration_sceneincludeselement1` FOREIGN KEY (`StartSceneIncludesElementID`) REFERENCES `sceneincludeselement` (`SceneIncludesElementID`),
  CONSTRAINT `fk_traitduration_sceneincludeselement2` FOREIGN KEY (`EndSceneIncludesElementID`) REFERENCES `sceneincludeselement` (`SceneIncludesElementID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traitduration`
--

LOCK TABLES `traitduration` WRITE;
/*!40000 ALTER TABLE `traitduration` DISABLE KEYS */;
/*!40000 ALTER TABLE `traitduration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wish`
--

DROP TABLE IF EXISTS `wish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wish` (
  `WishID` int NOT NULL AUTO_INCREMENT,
  `WishQuote` varchar(4095) DEFAULT NULL,
  `Description` varchar(4095) DEFAULT NULL,
  `CurrentStatusDescription` varchar(4095) DEFAULT NULL,
  PRIMARY KEY (`WishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wish`
--

LOCK TABLES `wish` WRITE;
/*!40000 ALTER TABLE `wish` DISABLE KEYS */;
/*!40000 ALTER TABLE `wish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `addelementhastraitview`
--

/*!50001 DROP VIEW IF EXISTS `addelementhastraitview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DisenchantmentAdmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `addelementhastraitview` AS select `t`.`TraitName` AS `TraitName`,`e`.`ElementID` AS `ElementID`,`e`.`ElementReferenceName` AS `ElementReferenceName`,`eht`.`TraitID` AS `TraitID` from ((`element` `e` left join `elementhastrait` `eht` on((`e`.`ElementID` = `eht`.`ElementID`))) left join `trait` `t` on((`eht`.`TraitID` = `t`.`TraitID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `addelementnameview`
--

/*!50001 DROP VIEW IF EXISTS `addelementnameview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DisenchantmentAdmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `addelementnameview` AS select `e`.`ElementReferenceName` AS `ElementReferenceName`,`e`.`ElementID` AS `ElementID`,`sie`.`SceneIncludesElementID` AS `SceneIncludesElementID`,`sie`.`SceneID` AS `SceneID`,`sheen`.`SceneHasExampleOfElementNameID` AS `SceneHasExampleOfElementNameID`,`sheen`.`EvidenceDescription` AS `EvidenceDescription`,`ehen`.`ElementHasNameID` AS `ElementHasNameID`,`ehen`.`ElementNameID` AS `ElementNameID`,`en`.`ElementName` AS `ElementName`,`en`.`NameType` AS `NameType`,`en`.`NamePriority` AS `NamePriority` from (((((`sceneincludeselement` `sie` left join `element` `e` on((`sie`.`ElementID` = `e`.`ElementID`))) left join `scene` `s` on((`sie`.`SceneID` = `s`.`SceneID`))) left join `scenehasexampleofelementname` `sheen` on((`sie`.`SceneIncludesElementID` = `sheen`.`SceneIncludesElementID`))) left join `elementhaselementname` `ehen` on((`e`.`ElementID` = `ehen`.`ElementID`))) left join `elementname` `en` on((`ehen`.`ElementNameID` = `en`.`ElementNameID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `addelementrelationshipview`
--

/*!50001 DROP VIEW IF EXISTS `addelementrelationshipview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DisenchantmentAdmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `addelementrelationshipview` AS select `e`.`ElementReferenceName` AS `ElementReferenceName`,`e`.`ElementID` AS `Element1ID`,`sie`.`SceneIncludesElementID` AS `SceneIncludesElementID`,`sie`.`SceneID` AS `SceneID`,`saer`.`sceneAddressesElementRelationshipID` AS `SceneAddressesElementRelationshipID`,`saer`.`sceneAddressesElementRelationshipDescription` AS `SceneAddressesElementRelationshipDescription`,`ehrte`.`ElementHasRelationshipToElementID` AS `ElementHasRelationshipToElementID`,`ehrte`.`Element2ID` AS `Element2ID`,`ehrte`.`RelationshipDurationID` AS `RelationshipDurationID`,`ehrte`.`RelationshipPriority` AS `RelationshipPriority`,`ehrte`.`Element1InheritsTraitsFromElement2` AS `Element1InheritsTraitsFromElement2`,`r`.`RelationshipType` AS `RelationshipType`,`r`.`RelationshipID` AS `RelationshipID`,`ehrte`.`RelationshipInstance` AS `RelationshipInstance` from ((((((`sceneincludeselement` `sie` left join `element` `e` on((`sie`.`ElementID` = `e`.`ElementID`))) left join `scene` `s` on((`sie`.`SceneID` = `s`.`SceneID`))) left join `sceneaddresseselementrelationship` `saer` on((`sie`.`SceneIncludesElementID` = `saer`.`sceneIncludesElementID`))) left join `elementhasrelationshiptoelement` `ehrte` on((`saer`.`ElementHasRelationshipToElementID` = `ehrte`.`ElementHasRelationshipToElementID`))) left join `relationship` `r` on((`ehrte`.`RelationshipID` = `r`.`RelationshipID`))) left join `relationshipduration` `rd` on((`ehrte`.`RelationshipDurationID` = `rd`.`RelationshipDurationID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sceneview`
--

/*!50001 DROP VIEW IF EXISTS `sceneview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DisenchantmentAdmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `sceneview` AS select `s`.`SceneID` AS `SceneID`,`s`.`SceneName` AS `SceneName`,`sie`.`InclusionDescription` AS `InclusionDescription`,`sie`.`SceneIncludesElementID` AS `SceneIncludesElementID`,`sie`.`ElementID` AS `ElementID`,(case when (`e`.`ElementReferenceName` is not null) then `e`.`ElementReferenceName` else 'other notes' end) AS `ElementReferenceName`,(case when (`saeht`.`SceneIncludesElementID` is not null) then 'sceneaddresseselementhastrait' when (`saer`.`sceneIncludesElementID` is not null) then 'sceneaddresseselementrelationship' when (`sheen`.`SceneIncludesElementID` is not null) then 'scenehasexampleofelementname' when (`siehw`.`SceneIncludesElementID` is not null) then 'sceneincludeselementhaswish' else 'other notes' end) AS `TableName`,`sie`.`SequentialID` AS `SequentialID` from ((((((`sceneincludeselement` `sie` left join `scene` `s` on((`sie`.`SceneID` = `s`.`SceneID`))) left join `element` `e` on((`sie`.`ElementID` = `e`.`ElementID`))) left join `sceneaddresseselementhastrait` `saeht` on((`sie`.`SceneIncludesElementID` = `saeht`.`SceneIncludesElementID`))) left join `sceneaddresseselementrelationship` `saer` on((`sie`.`SceneIncludesElementID` = `saer`.`sceneIncludesElementID`))) left join `scenehasexampleofelementname` `sheen` on((`sie`.`SceneIncludesElementID` = `sheen`.`SceneIncludesElementID`))) left join `sceneincludeselementhaswish` `siehw` on((`sie`.`SceneIncludesElementID` = `siehw`.`SceneIncludesElementID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-26 20:34:51
