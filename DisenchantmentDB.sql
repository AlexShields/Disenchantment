-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Episodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Episodes` (
  `EpisodeID` INT NOT NULL,
  `Part` INT NULL,
  `Episode` INT NULL,
  `Name` VARCHAR(45) NULL,
  `Synopsis` VARCHAR(255) NULL,
  PRIMARY KEY (`EpisodeID`),
  UNIQUE INDEX `EpisodeID_UNIQUE` (`EpisodeID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Events` (
  `EventID` INT NOT NULL,
  `EventName` VARCHAR(45) CHARACTER SET 'armscii8' NULL,
  `EpisodeID` INT NOT NULL,
  `EventDescription` VARCHAR(255) NULL,
  `Timestamp` DECIMAL(3) NULL,
  `SequentialID` DECIMAL(3) NULL,
  PRIMARY KEY (`EventID`),
  INDEX `fk_Events_Episodes_idx` (`EpisodeID` ASC) VISIBLE,
  CONSTRAINT `fk_Events_Episodes`
    FOREIGN KEY (`EpisodeID`)
    REFERENCES `mydb`.`Episodes` (`EpisodeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relationship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Relationship` (
  `RelationshipID` INT NOT NULL,
  `RelationshipType` VARCHAR(45) NULL,
  `RelationshipTypeUniversalDescription` VARCHAR(255) NULL,
  `Relationshipcol` VARCHAR(45) NULL,
  PRIMARY KEY (`RelationshipID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Object`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Object` (
  `ObjectID` INT NOT NULL AUTO_INCREMENT,
  `ObjectTypeID` INT NOT NULL,
  `ObjectReferenceName` VARCHAR(45) NULL,
  `ObjectDescription` VARCHAR(255) NULL,
  PRIMARY KEY (`ObjectID`),
  UNIQUE INDEX `ObjectID_UNIQUE` (`ObjectID` ASC) VISIBLE,
  UNIQUE INDEX `ObjectReferenceName_UNIQUE` (`ObjectReferenceName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Wish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Wish` (
  `WishID` INT NOT NULL,
  `Wish Quote` VARCHAR(45) NULL,
  `Description` VARCHAR(255) NULL,
  `WishingObjectID` INT NOT NULL,
  PRIMARY KEY (`WishID`),
  INDEX `fk_Wish_Object1_idx` (`WishingObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Wish_Object1`
    FOREIGN KEY (`WishingObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Has_Wish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Has_Wish` (
  `Event_Has_WishID` INT NOT NULL,
  `EventID` INT NOT NULL,
  `WishID` INT NOT NULL,
  `WishGrantDeny` VARCHAR(5) NULL,
  INDEX `fk_Event_Is_Wish_Events2_idx` (`EventID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Wish_Wish1_idx` (`WishID` ASC) VISIBLE,
  PRIMARY KEY (`Event_Has_WishID`),
  CONSTRAINT `fk_Event_Is_Wish_Events2`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Has_Wish_Wish1`
    FOREIGN KEY (`WishID`)
    REFERENCES `mydb`.`Wish` (`WishID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Includes_Object`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Includes_Object` (
  `Event_Includes_ObjectID` INT NOT NULL,
  `EventID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  `InclusionDescription` VARCHAR(45) NULL,
  INDEX `fk_Event_Has_Object_Events1_idx` (`EventID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Object_Object1_idx` (`ObjectID` ASC) VISIBLE,
  PRIMARY KEY (`Event_Includes_ObjectID`),
  CONSTRAINT `fk_Event_Has_Object_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Has_Object_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Duration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Duration` (
  `DurationID` INT NOT NULL,
  `StartEventID` INT NOT NULL,
  `EndEventID` INT NOT NULL,
  `StartEventDescription` VARCHAR(255) NULL,
  `EndEventDescription` VARCHAR(255) NULL,
  `Durationcol` VARCHAR(45) NULL,
  PRIMARY KEY (`DurationID`),
  INDEX `fk_Duration_Events1_idx` (`StartEventID` ASC) VISIBLE,
  INDEX `fk_Duration_Events2_idx` (`EndEventID` ASC) VISIBLE,
  CONSTRAINT `fk_Duration_Events1`
    FOREIGN KEY (`StartEventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Duration_Events2`
    FOREIGN KEY (`EndEventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Object1_Has_Relationship_To_Object2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Object1_Has_Relationship_To_Object2` (
  `Object1_Has_Relationship_To_Object2ID` INT NOT NULL,
  `Object1ID` INT NOT NULL,
  `RelationshipID` INT NOT NULL,
  `Object2ID` INT NOT NULL,
  `Explanation` VARCHAR(45) NULL,
  `DurationID` INT NOT NULL,
  `RelationshipPriorityID` VARCHAR(45) NULL,
  PRIMARY KEY (`Object1_Has_Relationship_To_Object2ID`),
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Object1_idx` (`Object1ID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Relation_idx` (`RelationshipID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Object2_idx` (`Object2ID` ASC) VISIBLE,
  INDEX `fk_Object1_Has_Relationship_To_Object2_Duration1_idx` (`DurationID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Object1`
    FOREIGN KEY (`Object1ID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Relationsh1`
    FOREIGN KEY (`RelationshipID`)
    REFERENCES `mydb`.`Relationship` (`RelationshipID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Object2`
    FOREIGN KEY (`Object2ID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Object1_Has_Relationship_To_Object2_Duration1`
    FOREIGN KEY (`DurationID`)
    REFERENCES `mydb`.`Duration` (`DurationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Traits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Traits` (
  `TraitID` INT NOT NULL,
  `TraitName` VARCHAR(45) NULL,
  `TriatUniversalDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`TraitID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Object_Has_Trait`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Object_Has_Trait` (
  `Object_Has_TraitID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  `TraitID` INT NOT NULL,
  `DurationID` INT NOT NULL,
  `Object_Has_Trait_Description` VARCHAR(255) NULL,
  `TraitPriority` DECIMAL(2) NULL,
  PRIMARY KEY (`Object_Has_TraitID`),
  INDEX `fk_ObjectHasTrait_Object1_idx` (`ObjectID` ASC) VISIBLE,
  INDEX `fk_ObjectHasTrait_Traits1_idx` (`TraitID` ASC) VISIBLE,
  INDEX `fk_Object_Has_Trait_Duration1_idx` (`DurationID` ASC) VISIBLE,
  CONSTRAINT `fk_ObjectHasTrait_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ObjectHasTrait_Traits1`
    FOREIGN KEY (`TraitID`)
    REFERENCES `mydb`.`Traits` (`TraitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Object_Has_Trait_Duration1`
    FOREIGN KEY (`DurationID`)
    REFERENCES `mydb`.`Duration` (`DurationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ObjectName`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ObjectName` (
  `ObjectNameID` INT NOT NULL,
  `ObjectName` VARCHAR(45) NULL,
  `NameType` VARCHAR(45) NULL,
  `NamePriority` VARCHAR(45) NULL,
  PRIMARY KEY (`ObjectNameID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Object_Has_ObjectName`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Object_Has_ObjectName` (
  `ObjectHasNameID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  `ObjectNameID` INT NOT NULL,
  PRIMARY KEY (`ObjectHasNameID`),
  INDEX `fk_Object_Has_Name_Object1_idx` (`ObjectID` ASC) VISIBLE,
  INDEX `fk_Object_Has_ObjectName_ObjectName1_idx` (`ObjectNameID` ASC) VISIBLE,
  CONSTRAINT `fk_Object_Has_Name_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Object_Has_ObjectName_ObjectName1`
    FOREIGN KEY (`ObjectNameID`)
    REFERENCES `mydb`.`ObjectName` (`ObjectNameID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Has_Example_Of_ObjectName`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Has_Example_Of_ObjectName` (
  `Event_Has_Example_Of_ObjectNameID` INT NOT NULL AUTO_INCREMENT,
  `ExampleEventID` INT NOT NULL,
  `Object_Has_ObjectName_ObjectHasNameID` INT NOT NULL,
  `EvidenceDescription` VARCHAR(255) NULL,
  INDEX `fk_Event_Has_Example_Of_ObjectName_Events1_idx` (`ExampleEventID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Example_Of_ObjectName_Object_Has_ObjectName1_idx` (`Object_Has_ObjectName_ObjectHasNameID` ASC) VISIBLE,
  PRIMARY KEY (`Event_Has_Example_Of_ObjectNameID`),
  CONSTRAINT `fk_Event_Has_Example_Of_ObjectName_Events1`
    FOREIGN KEY (`ExampleEventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Has_Example_Of_ObjectName_Object_Has_ObjectName1`
    FOREIGN KEY (`Object_Has_ObjectName_ObjectHasNameID`)
    REFERENCES `mydb`.`Object_Has_ObjectName` (`ObjectHasNameID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Has_Other_Notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Has_Other_Notes` (
  `Event_Has_Other_NotesID` VARCHAR(45) NOT NULL,
  `EventID` INT NOT NULL,
  `Note` VARCHAR(255) NOT NULL,
  INDEX `fk_table1_Events1_idx` (`EventID` ASC) VISIBLE,
  PRIMARY KEY (`Event_Has_Other_NotesID`),
  CONSTRAINT `fk_table1_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Addresses_Object_Has_Trait`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Addresses_Object_Has_Trait` (
  `Event_Has_Example_Of_Object_Has_Trait` INT NOT NULL AUTO_INCREMENT,
  `Object_Has_TraitID` INT NOT NULL,
  `ExampleEventID` INT NOT NULL,
  `Description` VARCHAR(255) NULL,
  INDEX `fk_Event_Has_Example_Of_Object_Has_Trait_Object_Has_Trait1_idx` (`Object_Has_TraitID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Example_Of_Object_Has_Trait_Events1_idx` (`ExampleEventID` ASC) VISIBLE,
  PRIMARY KEY (`Event_Has_Example_Of_Object_Has_Trait`),
  UNIQUE INDEX `Event_Has_Example_Of_Object_Has_Trait_UNIQUE` (`Event_Has_Example_Of_Object_Has_Trait` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Has_Example_Of_Object_Has_Trait_Object_Has_Trait1`
    FOREIGN KEY (`Object_Has_TraitID`)
    REFERENCES `mydb`.`Object_Has_Trait` (`Object_Has_TraitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Has_Example_Of_Object_Has_Trait_Events1`
    FOREIGN KEY (`ExampleEventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Addresses_Object_Relationship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Addresses_Object_Relationship` (
  `Event_Addresses_Object_RelationshipID` INT NOT NULL AUTO_INCREMENT,
  `EventID` INT NOT NULL,
  `Object1_Has_Relationship_To_Object2ID` INT NOT NULL,
  `Description` VARCHAR(45) NULL,
  INDEX `fk_Event_Addresses_Object_Relationship_Events1_idx` (`EventID` ASC) VISIBLE,
  PRIMARY KEY (`Event_Addresses_Object_RelationshipID`),
  INDEX `fk_Event_Addresses_Object_Relationship_Object1_Has_Relation_idx` (`Object1_Has_Relationship_To_Object2ID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Addresses_Object_Relationship_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Addresses_Object_Relationship_Object1_Has_Relationsh1`
    FOREIGN KEY (`Object1_Has_Relationship_To_Object2ID`)
    REFERENCES `mydb`.`Object1_Has_Relationship_To_Object2` (`Object1_Has_Relationship_To_Object2ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- procedure Add_Episode
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Episode` (
    IN episodeID INT,
    IN part INT,
    IN episode INT,
    IN name VARCHAR(45),
    IN synopsis VARCHAR(255)
)
BEGIN
    INSERT INTO Episodes (EpisodeID, Part, Episode, Name, Synopsis)
    VALUES (episodeID, part, episode, name, synopsis);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Episode
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Episode` (
    IN episodeID INT,
    IN part INT,
    IN episode INT,
    IN name VARCHAR(45),
    IN synopsis VARCHAR(255)
)
BEGIN
    UPDATE Episodes
    SET Part = part, Episode = episode, Name = name, Synopsis = synopsis
    WHERE EpisodeID = episodeID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Episode
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Episode` (
    IN episodeID INT
)
BEGIN
    DELETE FROM Episodes
    WHERE EpisodeID = episodeID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Event
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Event` (
    IN eventID INT,
    IN eventName VARCHAR(45),
    IN episodeID INT,
    IN eventDescription VARCHAR(255),
    IN timestamp DECIMAL(3),
    IN sequentialID DECIMAL(3)
)
BEGIN
    INSERT INTO Events (EventID, EventName, EpisodeID, EventDescription, Timestamp, SequentialID)
    VALUES (eventID, eventName, episodeID, eventDescription, timestamp, sequentialID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Event
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Event` (
    IN eventID INT,
    IN eventName VARCHAR(45),
    IN episodeID INT,
    IN eventDescription VARCHAR(255),
    IN timestamp DECIMAL(3),
    IN sequentialID DECIMAL(3)
)
BEGIN
    UPDATE Events
    SET EventName = eventName, EpisodeID = episodeID, EventDescription = eventDescription, Timestamp = timestamp, SequentialID = sequentialID
    WHERE EventID = eventID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Relationship
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Relationship` (
    IN relationshipID INT,
    IN relationshipType VARCHAR(45),
    IN relationshipTypeUniversalDescription VARCHAR(255),
    IN relationshipcol VARCHAR(45)
)
BEGIN
    INSERT INTO Relationship (RelationshipID, RelationshipType, RelationshipTypeUniversalDescription, Relationshipcol)
    VALUES (relationshipID, relationshipType, relationshipTypeUniversalDescription, relationshipcol);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Relationship
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Relationship` (
    IN relationshipID INT,
    IN relationshipType VARCHAR(45),
    IN relationshipTypeUniversalDescription VARCHAR(255),
    IN relationshipcol VARCHAR(45)
)
BEGIN
    UPDATE Relationship
    SET RelationshipType = relationshipType, RelationshipTypeUniversalDescription = relationshipTypeUniversalDescription, Relationshipcol = relationshipcol
    WHERE RelationshipID = relationshipID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Relationship
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Relationship` (
    IN relationshipID INT
)
BEGIN
    DELETE FROM Relationship
    WHERE RelationshipID = relationshipID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Object
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Object` (
    IN objectID INT,
    IN objectTypeID INT,
    IN objectReferenceName VARCHAR(45),
    IN objectDescription VARCHAR(255)
)
BEGIN
    INSERT INTO Object (ObjectID, ObjectTypeID, ObjectReferenceName, ObjectDescription)
    VALUES (objectID, objectTypeID, objectReferenceName, objectDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Object
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Object` (
    IN objectID INT,
    IN objectTypeID INT,
    IN objectReferenceName VARCHAR(45),
    IN objectDescription VARCHAR(255)
)
BEGIN
    UPDATE Object
    SET ObjectTypeID = objectTypeID, ObjectReferenceName = objectReferenceName, ObjectDescription = objectDescription
    WHERE ObjectID = objectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Object
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Object` (
    IN objectID INT
)
BEGIN
    DELETE FROM Object
    WHERE ObjectID = objectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Wish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Wish` (
    IN wishID INT,
    IN wishQuote VARCHAR(45),
    IN description VARCHAR(255),
    IN wishingObjectID INT
)
BEGIN
    INSERT INTO Wish (WishID, `Wish Quote`, Description, WishingObjectID)
    VALUES (wishID, wishQuote, description, wishingObjectID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Wish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Wish` (
    IN wishID INT,
    IN wishQuote VARCHAR(45),
    IN description VARCHAR(255),
    IN wishingObjectID INT
)
BEGIN
    UPDATE Wish
    SET `Wish Quote` = wishQuote, Description = description, WishingObjectID = wishingObjectID
    WHERE WishID = wishID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Wish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Wish` (
    IN wishID INT
)
BEGIN
    DELETE FROM Wish
    WHERE WishID = wishID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Event_Has_Wish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Event_Has_Wish` (
  IN p_EventID INT,
  IN p_WishID INT,
  IN p_WishGrantDeny VARCHAR(5)
)
BEGIN
  INSERT INTO `Event_Has_Wish` (`EventID`, `WishID`, `WishGrantDeny`)
  VALUES (p_EventID, p_WishID, p_WishGrantDeny);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Event_Includes_Object
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Event_Includes_Object` (
  IN p_EventID INT,
  IN p_ObjectID INT,
  IN p_InclusionDescription VARCHAR(45)
)
BEGIN
  INSERT INTO `Event_Includes_Object` (`EventID`, `ObjectID`, `InclusionDescription`)
  VALUES (p_EventID, p_ObjectID, p_InclusionDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Event_Has_Wish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Event_Has_Wish` (
  IN p_Event_Has_WishID INT,
  IN p_EventID INT,
  IN p_WishID INT,
  IN p_WishGrantDeny VARCHAR(5)
)
BEGIN
  UPDATE `Event_Has_Wish`
  SET `EventID` = p_EventID, `WishID` = p_WishID, `WishGrantDeny` = p_WishGrantDeny
  WHERE `Event_Has_WishID` = p_Event_Has_WishID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Event_Has_Wish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Event_Has_Wish` (
  IN p_Event_Has_WishID INT
)
BEGIN
  DELETE FROM `Event_Has_Wish`
  WHERE `Event_Has_WishID` = p_Event_Has_WishID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Event_Includes_Object
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Event_Includes_Object` (
  IN p_Event_Includes_ObjectID INT,
  IN p_EventID INT,
  IN p_ObjectID INT,
  IN p_InclusionDescription VARCHAR(45)
)
BEGIN
  UPDATE `Event_Includes_Object`
  SET `EventID` = p_EventID, `ObjectID` = p_ObjectID, `InclusionDescription` = p_InclusionDescription
  WHERE `Event_Includes_ObjectID` = p_Event_Includes_ObjectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Event_Includes_Object
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Event_Includes_Object` (
  IN p_Event_Includes_ObjectID INT
)
BEGIN
  DELETE FROM `Event_Includes_Object`
  WHERE `Event_Includes_ObjectID` = p_Event_Includes_ObjectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Duration
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Duration` (
  IN p_StartEventID INT,
  IN p_EndEventID INT,
  IN p_StartEventDescription VARCHAR(255),
  IN p_EndEventDescription VARCHAR(255),
  IN p_Durationcol VARCHAR(45)
)
BEGIN
  INSERT INTO `Duration` (`StartEventID`, `EndEventID`, `StartEventDescription`, `EndEventDescription`, `Durationcol`)
  VALUES (p_StartEventID, p_EndEventID, p_StartEventDescription, p_EndEventDescription, p_Durationcol);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Duration
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Duration` (
  IN p_DurationID INT,
  IN p_StartEventID INT,
  IN p_EndEventID INT,
  IN p_StartEventDescription VARCHAR(255),
  IN p_EndEventDescription VARCHAR(255),
  IN p_Durationcol VARCHAR(45)
)
BEGIN
  UPDATE `Duration`
  SET `StartEventID` = p_StartEventID, `EndEventID` = p_EndEventID, `StartEventDescription` = p_StartEventDescription,
      `EndEventDescription` = p_EndEventDescription, `Durationcol` = p_Durationcol
  WHERE `DurationID` = p_DurationID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Duration
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Duration` (
  IN p_DurationID INT
)
BEGIN
  DELETE FROM `Duration`
  WHERE `DurationID` = p_DurationID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Object_Has_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Object_Has_Trait` (
  IN p_Object_Has_TraitID INT,
  IN p_ObjectID INT,
  IN p_TraitID INT,
  IN p_DurationID INT,
  IN p_Object_Has_Trait_Description VARCHAR(255),
  IN p_TraitPriority DECIMAL(2)
)
BEGIN
  UPDATE `Object_Has_Trait`
  SET `ObjectID` = p_ObjectID, `TraitID` = p_TraitID, `DurationID` = p_DurationID,
      `Object_Has_Trait_Description` = p_Object_Has_Trait_Description, `TraitPriority` = p_TraitPriority
  WHERE `Object_Has_TraitID` = p_Object_Has_TraitID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Object1_Has_Relationship_To_Object2
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Object1_Has_Relationship_To_Object2` (
  IN p_Object1ID INT,
  IN p_RelationshipID INT,
  IN p_Object2ID INT,
  IN p_Explanation VARCHAR(255),
  IN p_DurationID INT,
  IN p_RelationshipPriorityID VARCHAR(45)
)
BEGIN
  INSERT INTO `Object1_Has_Relationship_To_Object2` (`Object1ID`, `RelationshipID`, `Object2ID`, `Explanation`, `DurationID`, `RelationshipPriorityID`)
  VALUES (p_Object1ID, p_RelationshipID, p_Object2ID, p_Explanation, p_DurationID, p_RelationshipPriorityID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Object1_Has_Relationship_To_Object2
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Object1_Has_Relationship_To_Object2` (
  IN p_Object1_Has_Relationship_To_Object2ID INT,
  IN p_Object1ID INT,
  IN p_RelationshipID INT,
  IN p_Object2ID INT,
  IN p_Explanation VARCHAR(255),
  IN p_DurationID INT,
  IN p_RelationshipPriorityID VARCHAR(45)
)
BEGIN
  UPDATE `Object1_Has_Relationship_To_Object2`
  SET `Object1ID` = p_Object1ID, `RelationshipID` = p_RelationshipID, `Object2ID` = p_Object2ID,
      `Explanation` = p_Explanation, `DurationID` = p_DurationID, `RelationshipPriorityID` = p_RelationshipPriorityID
  WHERE `Object1_Has_Relationship_To_Object2ID` = p_Object1_Has_Relationship_To_Object2ID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Object1_Has_Relationship_To_Object2
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Object1_Has_Relationship_To_Object2` (
  IN p_Object1_Has_Relationship_To_Object2ID INT
)
BEGIN
  DELETE FROM `Object1_Has_Relationship_To_Object2`
  WHERE `Object1_Has_Relationship_To_Object2ID` = p_Object1_Has_Relationship_To_Object2ID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Trait` (
  IN p_TraitID INT,
  IN p_TraitName VARCHAR(45),
  IN p_TriatUniversalDescription VARCHAR(45)
)
BEGIN
  INSERT INTO `Traits` (`TraitID`, `TraitName`, `TriatUniversalDescription`)
  VALUES (p_TraitID, p_TraitName, p_TriatUniversalDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Trait` (
  IN p_TraitID INT,
  IN p_TraitName VARCHAR(45),
  IN p_TriatUniversalDescription VARCHAR(45)
)
BEGIN
  UPDATE `Traits`
  SET `TraitName` = p_TraitName, `TriatUniversalDescription` = p_TriatUniversalDescription
  WHERE `TraitID` = p_TraitID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Trait` (
  IN p_TraitID INT
)
BEGIN
  DELETE FROM `Traits`
  WHERE `TraitID` = p_TraitID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Object_Has_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Object_Has_Trait` (
  IN p_Object_Has_TraitID INT
)
BEGIN
  DELETE FROM `Object_Has_Trait`
  WHERE `Object_Has_TraitID` = p_Object_Has_TraitID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Object_Has_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Object_Has_Trait` (
  IN p_Object_Has_TraitID INT,
  IN p_ObjectID INT,
  IN p_TraitID INT,
  IN p_DurationID INT,
  IN p_Object_Has_Trait_Description VARCHAR(255),
  IN p_TraitPriority DECIMAL(2)
)
BEGIN
  INSERT INTO `Object_Has_Trait` (`Object_Has_TraitID`, `ObjectID`, `TraitID`, `DurationID`, `Object_Has_Trait_Description`, `TraitPriority`)
  VALUES (p_Object_Has_TraitID, p_ObjectID, p_TraitID, p_DurationID, p_Object_Has_Trait_Description, p_TraitPriority);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Event
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Event` (
    IN eventID INT
)
BEGIN
    DELETE FROM Events
    WHERE EventID = eventID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_ObjectName` (
  IN p_ObjectNameID INT,
  IN p_ObjectName VARCHAR(45),
  IN p_NameType VARCHAR(45),
  IN p_NamePriority VARCHAR(45)
)
BEGIN
  INSERT INTO `ObjectName` (`ObjectNameID`, `ObjectName`, `NameType`, `NamePriority`)
  VALUES (p_ObjectNameID, p_ObjectName, p_NameType, p_NamePriority);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_ObjectName` (
  IN p_ObjectNameID INT,
  IN p_ObjectName VARCHAR(45),
  IN p_NameType VARCHAR(45),
  IN p_NamePriority VARCHAR(45)
)
BEGIN
  UPDATE `ObjectName`
  SET `ObjectName` = p_ObjectName, `NameType` = p_NameType, `NamePriority` = p_NamePriority
  WHERE `ObjectNameID` = p_ObjectNameID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_ObjectName` (
  IN p_ObjectNameID INT
)
BEGIN
  DELETE FROM `ObjectName`
  WHERE `ObjectNameID` = p_ObjectNameID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Object_Has_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Object_Has_ObjectName` (
  IN p_ObjectHasNameID INT,
  IN p_ObjectID INT,
  IN p_ObjectNameID INT
)
BEGIN
  INSERT INTO `Object_Has_ObjectName` (`ObjectHasNameID`, `ObjectID`, `ObjectNameID`)
  VALUES (p_ObjectHasNameID, p_ObjectID, p_ObjectNameID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Object_Has_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Object_Has_ObjectName` (
  IN p_ObjectHasNameID INT,
  IN p_ObjectID INT,
  IN p_ObjectNameID INT
)
BEGIN
  UPDATE `Object_Has_ObjectName`
  SET `ObjectID` = p_ObjectID, `ObjectNameID` = p_ObjectNameID
  WHERE `ObjectHasNameID` = p_ObjectHasNameID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Object_Has_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Object_Has_ObjectName` (
  IN p_ObjectHasNameID INT
)
BEGIN
  DELETE FROM `Object_Has_ObjectName`
  WHERE `ObjectHasNameID` = p_ObjectHasNameID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Event_Has_Example_Of_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Event_Has_Example_Of_ObjectName` (
  IN p_Event_Has_Example_Of_ObjectNameID INT,
  IN p_ExampleEventID INT,
  IN p_Object_Has_ObjectName_ObjectHasNameID INT,
  IN p_EvidenceDescription VARCHAR(255)
)
BEGIN
  INSERT INTO `Event_Has_Example_Of_ObjectName` (`Event_Has_Example_Of_ObjectNameID`, `ExampleEventID`, `Object_Has_ObjectName_ObjectHasNameID`, `EvidenceDescription`)
  VALUES (p_Event_Has_Example_Of_ObjectNameID, p_ExampleEventID, p_Object_Has_ObjectName_ObjectHasNameID, p_EvidenceDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Event_Has_Example_Of_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Event_Has_Example_Of_ObjectName` (
  IN p_Event_Has_Example_Of_ObjectNameID INT,
  IN p_ExampleEventID INT,
  IN p_Object_Has_ObjectName_ObjectHasNameID INT,
  IN p_EvidenceDescription VARCHAR(255)
)
BEGIN
  UPDATE `Event_Has_Example_Of_ObjectName`
  SET `ExampleEventID` = p_ExampleEventID, `Object_Has_ObjectName_ObjectHasNameID` = p_Object_Has_ObjectName_ObjectHasNameID, `EvidenceDescription` = p_EvidenceDescription
  WHERE `Event_Has_Example_Of_ObjectNameID` = p_Event_Has_Example_Of_ObjectNameID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Event_Has_Example_Of_ObjectName
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Event_Has_Example_Of_ObjectName` (
  IN p_Event_Has_Example_Of_ObjectNameID INT
)
BEGIN
  DELETE FROM `Event_Has_Example_Of_ObjectName`
  WHERE `Event_Has_Example_Of_ObjectNameID` = p_Event_Has_Example_Of_ObjectNameID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Event_Has_Other_Notes
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Event_Has_Other_Notes` (
  IN p_Event_Has_Other_NotesID VARCHAR(45),
  IN p_EventID INT,
  IN p_Note VARCHAR(255)
)
BEGIN
  INSERT INTO `Event_Has_Other_Notes` (`Event_Has_Other_NotesID`, `EventID`, `Note`)
  VALUES (p_Event_Has_Other_NotesID, p_EventID, p_Note);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Event_Has_Other_Notes
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Event_Has_Other_Notes` (
  IN p_Event_Has_Other_NotesID VARCHAR(45),
  IN p_EventID INT,
  IN p_Note VARCHAR(255)
)
BEGIN
  UPDATE `Event_Has_Other_Notes`
  SET `EventID` = p_EventID, `Note` = p_Note
  WHERE `Event_Has_Other_NotesID` = p_Event_Has_Other_NotesID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Event_Has_Other_Notes
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Event_Has_Other_Notes` (
  IN p_Event_Has_Other_NotesID VARCHAR(45)
)
BEGIN
  DELETE FROM `Event_Has_Other_Notes`
  WHERE `Event_Has_Other_NotesID` = p_Event_Has_Other_NotesID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Event_Addresses_Object_Has_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Event_Addresses_Object_Has_Trait` (
  IN p_Event_Has_Example_Of_Object_Has_Trait INT,
  IN p_Object_Has_TraitID INT,
  IN p_ExampleEventID INT,
  IN p_Description VARCHAR(255)
)
BEGIN
  UPDATE `Event_Addresses_Object_Has_Trait`
  SET `Object_Has_TraitID` = p_Object_Has_TraitID, `ExampleEventID` = p_ExampleEventID, `Description` = p_Description
  WHERE `Event_Has_Example_Of_Object_Has_Trait` = p_Event_Has_Example_Of_Object_Has_Trait;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Event_Addresses_Object_Has_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Event_Addresses_Object_Has_Trait` (
  IN p_Event_Has_Example_Of_Object_Has_Trait INT,
  IN p_Object_Has_TraitID INT,
  IN p_ExampleEventID INT,
  IN p_Description VARCHAR(255)
)
BEGIN
  INSERT INTO `Event_Addresses_Object_Has_Trait` (`Event_Has_Example_Of_Object_Has_Trait`, `Object_Has_TraitID`, `ExampleEventID`, `Description`)
  VALUES (p_Event_Has_Example_Of_Object_Has_Trait, p_Object_Has_TraitID, p_ExampleEventID, p_Description);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Event_Addresses_Object_Has_Trait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Event_Addresses_Object_Has_Trait` (
  IN p_Event_Has_Example_Of_Object_Has_Trait INT
)
BEGIN
  DELETE FROM `Event_Addresses_Object_Has_Trait`
  WHERE `Event_Has_Example_Of_Object_Has_Trait` = p_Event_Has_Example_Of_Object_Has_Trait;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Add_Event_Addresses_Object_Relationship
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Add_Event_Addresses_Object_Relationship` (
  IN p_Event_Addresses_Object_RelationshipID INT,
  IN p_EventID INT,
  IN p_Object1_Has_Relationship_To_Object2ID INT,
  IN p_Description VARCHAR(45)
)
BEGIN
  INSERT INTO `Event_Addresses_Object_Relationship` (`Event_Addresses_Object_RelationshipID`, `EventID`, `Object1_Has_Relationship_To_Object2ID`, `Description`)
  VALUES (p_Event_Addresses_Object_RelationshipID, p_EventID, p_Object1_Has_Relationship_To_Object2ID, p_Description);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Modify_Event_Addresses_Object_Relationship
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Modify_Event_Addresses_Object_Relationship` (
  IN p_Event_Addresses_Object_RelationshipID INT,
  IN p_EventID INT,
  IN p_Object1_Has_Relationship_To_Object2ID INT,
  IN p_Description VARCHAR(45)
)
BEGIN
  UPDATE `Event_Addresses_Object_Relationship`
  SET `EventID` = p_EventID, `Object1_Has_Relationship_To_Object2ID` = p_Object1_Has_Relationship_To_Object2ID, `Description` = p_Description
  WHERE `Event_Addresses_Object_RelationshipID` = p_Event_Addresses_Object_RelationshipID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Delete_Event_Addresses_Object_Relationship
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `Delete_Event_Addresses_Object_Relationship` (
  IN p_Event_Addresses_Object_RelationshipID INT
)
BEGIN
  DELETE FROM `Event_Addresses_Object_Relationship`
  WHERE `Event_Addresses_Object_RelationshipID` = p_Event_Addresses_Object_RelationshipID;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
