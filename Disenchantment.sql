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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`episode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`episode` ;

CREATE TABLE IF NOT EXISTS `mydb`.`episode` (
  `EpisodeID` INT NOT NULL AUTO_INCREMENT,
  `Part` INT NULL DEFAULT NULL,
  `Episode` INT NULL DEFAULT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Synopsis` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`EpisodeID`),
  UNIQUE INDEX `EpisodeID_UNIQUE` (`EpisodeID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`event` ;

CREATE TABLE IF NOT EXISTS `mydb`.`event` (
  `EventID` INT NOT NULL AUTO_INCREMENT,
  `EventName` VARCHAR(45) CHARACTER SET 'armscii8' NULL DEFAULT NULL,
  `EpisodeID` INT NOT NULL,
  `EventDescription` VARCHAR(255) NULL DEFAULT NULL,
  `Timestamp` DECIMAL(3,0) NULL DEFAULT NULL,
  PRIMARY KEY (`EventID`),
  INDEX `fk_Event_Episodes_idx` (`EpisodeID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Episodes`
    FOREIGN KEY (`EpisodeID`)
    REFERENCES `mydb`.`episode` (`EpisodeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`object` ;

CREATE TABLE IF NOT EXISTS `mydb`.`object` (
  `ObjectID` INT NOT NULL AUTO_INCREMENT,
  `ObjectTypeID` INT NOT NULL,
  `ObjectReferenceName` VARCHAR(45) NULL DEFAULT NULL,
  `ObjectDescription` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`ObjectID`),
  UNIQUE INDEX `ObjectID_UNIQUE` (`ObjectID` ASC) VISIBLE,
  UNIQUE INDEX `ObjectReferenceName_UNIQUE` (`ObjectReferenceName` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`eventincludesobject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`eventincludesobject` ;

CREATE TABLE IF NOT EXISTS `mydb`.`eventincludesobject` (
  `EventIncludesObjectID` INT NOT NULL AUTO_INCREMENT,
  `EventID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  `InclusionDescription` VARCHAR(45) NULL DEFAULT NULL,
  `SequentialID` DECIMAL(3,0) NULL DEFAULT NULL,
  PRIMARY KEY (`EventIncludesObjectID`),
  INDEX `fk_EventIncludesObject_Events1_idx` (`EventID` ASC) VISIBLE,
  INDEX `fk_EventIncludesObject_Object1_idx` (`ObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_EventIncludesObject_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`event` (`EventID`),
  CONSTRAINT `fk_EventIncludesObject_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`object` (`ObjectID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`duration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`duration` ;

CREATE TABLE IF NOT EXISTS `mydb`.`duration` (
  `DurationID` INT NOT NULL AUTO_INCREMENT,
  `StartEventDescription` VARCHAR(255) NOT NULL,
  `EndEventDescription` VARCHAR(255) NULL DEFAULT NULL,
  `StartEventIncludesObjectID` INT NOT NULL,
  `EndEventIncludesObjectID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`DurationID`),
  INDEX `fk_duration_eventincludesobject1_idx` (`StartEventIncludesObjectID` ASC) VISIBLE,
  INDEX `fk_duration_eventincludesobject2_idx` (`EndEventIncludesObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_duration_eventincludesobject1`
    FOREIGN KEY (`StartEventIncludesObjectID`)
    REFERENCES `mydb`.`eventincludesobject` (`EventIncludesObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_duration_eventincludesobject2`
    FOREIGN KEY (`EndEventIncludesObjectID`)
    REFERENCES `mydb`.`eventincludesobject` (`EventIncludesObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`trait`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`trait` ;

CREATE TABLE IF NOT EXISTS `mydb`.`trait` (
  `TraitID` INT NOT NULL,
  `TraitName` VARCHAR(45) NULL DEFAULT NULL,
  `TraitUniversalDescription` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`TraitID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`objecthastrait`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`objecthastrait` ;

CREATE TABLE IF NOT EXISTS `mydb`.`objecthastrait` (
  `ObjectHasTraitID` INT NOT NULL AUTO_INCREMENT,
  `ObjectID` INT NOT NULL,
  `TraitID` INT NOT NULL,
  `DurationID` INT NOT NULL,
  `ObjectHasTraitDescription` VARCHAR(255) NULL DEFAULT NULL,
  `TraitPriority` DECIMAL(2,0) NULL DEFAULT NULL,
  PRIMARY KEY (`ObjectHasTraitID`),
  INDEX `fk_ObjectHasTrait_Object1_idx` (`ObjectID` ASC) VISIBLE,
  INDEX `fk_ObjectHasTrait_Trait1_idx` (`TraitID` ASC) VISIBLE,
  INDEX `fk_ObjectHasTrait_Duration1_idx` (`DurationID` ASC) VISIBLE,
  CONSTRAINT `fk_ObjectHasTrait_Duration1`
    FOREIGN KEY (`DurationID`)
    REFERENCES `mydb`.`duration` (`DurationID`),
  CONSTRAINT `fk_ObjectHasTrait_Object2`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`object` (`ObjectID`),
  CONSTRAINT `fk_ObjectHasTrait_Trait1`
    FOREIGN KEY (`TraitID`)
    REFERENCES `mydb`.`trait` (`TraitID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`eventaddressesobjecthastrait`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`eventaddressesobjecthastrait` ;

CREATE TABLE IF NOT EXISTS `mydb`.`eventaddressesobjecthastrait` (
  `EventAddressesObjectHasTraitID` INT NOT NULL AUTO_INCREMENT,
  `ObjectHasTraitID` INT NOT NULL,
  `EventAddressesObjectHasTraitDescription` VARCHAR(255) NULL DEFAULT NULL,
  `EventIncludesObjectID` INT NOT NULL,
  PRIMARY KEY (`EventAddressesObjectHasTraitID`),
  UNIQUE INDEX `Event_Has_Example_Of_Object_Has_Trait_UNIQUE` (`EventAddressesObjectHasTraitID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Example_Of_Object_Has_Trait_Object_Has_Trait1_idx` (`ObjectHasTraitID` ASC) VISIBLE,
  INDEX `fk_Event_Addresses_Object_Has_Trait_Event_Includes_Object1_idx` (`EventIncludesObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Addresses_Object_Has_Trait_Event_Includes_Object1a`
    FOREIGN KEY (`EventIncludesObjectID`)
    REFERENCES `mydb`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_Event_Addresses_Object_Has_Trait_Object_Has_Trait1`
    FOREIGN KEY (`ObjectHasTraitID`)
    REFERENCES `mydb`.`objecthastrait` (`ObjectHasTraitID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`relationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`relationship` ;

CREATE TABLE IF NOT EXISTS `mydb`.`relationship` (
  `RelationshipID` INT NOT NULL,
  `RelationshipType` VARCHAR(45) NULL DEFAULT NULL,
  `RelationshipTypeUniversalDescription` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`RelationshipID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`objecthasrelationshiptoobject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`objecthasrelationshiptoobject` ;

CREATE TABLE IF NOT EXISTS `mydb`.`objecthasrelationshiptoobject` (
  `ObjectHasRelationshipToObjectID` INT NOT NULL,
  `Object1ID` INT NOT NULL,
  `RelationshipID` INT NOT NULL,
  `Object2ID` INT NOT NULL,
  `Explanation` VARCHAR(45) NULL DEFAULT NULL,
  `DurationID` INT NOT NULL,
  `RelationshipPriorityID` DECIMAL(2,0) NULL DEFAULT NULL,
  `Object2InheritsTraitsFromObject1` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ObjectHasRelationshipToObjectID`),
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Object1_idx` (`Object1ID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Relation_idx` (`RelationshipID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Object2_idx` (`Object2ID` ASC) VISIBLE,
  INDEX `fk_Object1_Has_Relationship_To_Object2_Duration1_idx` (`DurationID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Object1b`
    FOREIGN KEY (`Object1ID`)
    REFERENCES `mydb`.`object` (`ObjectID`),
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Object2b`
    FOREIGN KEY (`Object2ID`)
    REFERENCES `mydb`.`object` (`ObjectID`),
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Rel1b`
    FOREIGN KEY (`RelationshipID`)
    REFERENCES `mydb`.`relationship` (`RelationshipID`),
  CONSTRAINT `fk_Object_Has_Relationship_To_Object_Duration1b`
    FOREIGN KEY (`DurationID`)
    REFERENCES `mydb`.`duration` (`DurationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`eventaddressesobjectrelationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`eventaddressesobjectrelationship` ;

CREATE TABLE IF NOT EXISTS `mydb`.`eventaddressesobjectrelationship` (
  `EventAddressesObjectRelationshipID` INT NOT NULL AUTO_INCREMENT,
  `ObjectHasRelationshipToObjectID` INT NOT NULL,
  `EventAddressesObjectRelationshipDescription` VARCHAR(255) NULL DEFAULT NULL,
  `EventIncludesObjectID` INT NOT NULL,
  PRIMARY KEY (`EventAddressesObjectRelationshipID`),
  INDEX `fk_Event_Addresses_Object_Relationship_Event_Includes_Objec_idx` (`EventIncludesObjectID` ASC) VISIBLE,
  INDEX `fk_eventaddressesobjectrelationship_objecthasrelationshipto_idx` (`ObjectHasRelationshipToObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Addresses_Object_Relationship_Event_Includes_Object1a`
    FOREIGN KEY (`EventIncludesObjectID`)
    REFERENCES `mydb`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_eventaddressesobjectrelationship_objecthasrelationshiptoob1`
    FOREIGN KEY (`EventIncludesObjectID`)
    REFERENCES `mydb`.`objecthasrelationshiptoobject` (`ObjectHasRelationshipToObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventaddressesobjectrelationship_objecthasrelationshiptoob2`
    FOREIGN KEY (`ObjectHasRelationshipToObjectID`)
    REFERENCES `mydb`.`objecthasrelationshiptoobject` (`ObjectHasRelationshipToObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`objectname`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`objectname` ;

CREATE TABLE IF NOT EXISTS `mydb`.`objectname` (
  `ObjectNameID` INT NOT NULL,
  `ObjectName` VARCHAR(45) NULL DEFAULT NULL,
  `NameType` VARCHAR(45) NULL DEFAULT NULL,
  `NamePriority` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ObjectNameID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`objecthasobjectname`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`objecthasobjectname` ;

CREATE TABLE IF NOT EXISTS `mydb`.`objecthasobjectname` (
  `ObjectHasNameID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  `ObjectNameID` INT NOT NULL,
  PRIMARY KEY (`ObjectHasNameID`),
  INDEX `fk_Object_Has_Name_Object1_idx` (`ObjectID` ASC) VISIBLE,
  INDEX `fk_Object_Has_ObjectName_ObjectName1_idx` (`ObjectNameID` ASC) VISIBLE,
  CONSTRAINT `fk_Object_Has_Name_Object1a`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`object` (`ObjectID`),
  CONSTRAINT `fk_Object_Has_ObjectName_ObjectName1a`
    FOREIGN KEY (`ObjectNameID`)
    REFERENCES `mydb`.`objectname` (`ObjectNameID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`eventhasexampleofobjectname`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`eventhasexampleofobjectname` ;

CREATE TABLE IF NOT EXISTS `mydb`.`eventhasexampleofobjectname` (
  `EventHasExampleOfObjectNameID` INT NOT NULL AUTO_INCREMENT,
  `ObjectHasNameID` INT NOT NULL,
  `EvidenceDescription` VARCHAR(255) NULL DEFAULT NULL,
  `EventIncludesObjectID` INT NOT NULL,
  PRIMARY KEY (`EventHasExampleOfObjectNameID`),
  INDEX `fk_Event_Has_Example_Of_ObjectName_Object_Has_ObjectName1_idx` (`ObjectHasNameID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Example_Of_ObjectName_Event_Includes_Object1_idx` (`EventIncludesObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Has_Example_Of_ObjectName_Event_Includes_Object1a`
    FOREIGN KEY (`EventIncludesObjectID`)
    REFERENCES `mydb`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_Event_Has_Example_Of_ObjectName_Object_Has_ObjectName1a`
    FOREIGN KEY (`ObjectHasNameID`)
    REFERENCES `mydb`.`objecthasobjectname` (`ObjectHasNameID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`eventhasothernotes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`eventhasothernotes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`eventhasothernotes` (
  `EventHasOtherNotesID` INT NOT NULL AUTO_INCREMENT,
  `EventID` INT NOT NULL,
  `Note` VARCHAR(255) NOT NULL,
  INDEX `fk_table1_Events1_idx` (`EventID` ASC) VISIBLE,
  PRIMARY KEY (`EventHasOtherNotesID`),
  CONSTRAINT `fk_table1_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`event` (`EventID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`wish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`wish` ;

CREATE TABLE IF NOT EXISTS `mydb`.`wish` (
  `WishID` INT NOT NULL AUTO_INCREMENT,
  `WishQuote` VARCHAR(255) NULL DEFAULT NULL,
  `Description` VARCHAR(255) NULL DEFAULT NULL,
  `CurrentStatusDescription` VARCHAR(255) NULL,
  PRIMARY KEY (`WishID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`eventincludesobjecthaswish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`eventincludesobjecthaswish` ;

CREATE TABLE IF NOT EXISTS `mydb`.`eventincludesobjecthaswish` (
  `EventHasWishID` INT NOT NULL AUTO_INCREMENT,
  `WishID` INT NOT NULL,
  `WishGrantDeny` VARCHAR(5) NULL DEFAULT NULL,
  `EventIncludesObjectID` INT NOT NULL,
  PRIMARY KEY (`EventHasWishID`),
  INDEX `fk_Event_Has_Wish_Wish1_idx` (`WishID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Wish_Event_Includes_Object1_idx` (`EventIncludesObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Has_Wish_Event_Includes_Object1`
    FOREIGN KEY (`EventIncludesObjectID`)
    REFERENCES `mydb`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_Event_Has_Wish_Wish1`
    FOREIGN KEY (`WishID`)
    REFERENCES `mydb`.`wish` (`WishID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`objecttimeline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`objecttimeline` (`ObjectReferenceName` INT, `InclusionDescription` INT);

-- -----------------------------------------------------
-- procedure AddEpisode
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEpisode`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEpisode` (
    IN NewPart INT,
    IN NewEpisode INT,
    IN NewName VARCHAR(45),
    IN NewSynopsis VARCHAR(255)
)
BEGIN
    INSERT INTO episode (Part, Episode, Name, Synopsis)
    VALUES (NewPart, NewEpisode, NewName, NewSynopsis);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEpisode
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyEpisode`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEpisode` (
    IN ModifyEpisodeID INT,
    IN NewPart INT,
    IN NewEpisode INT,
    IN NewName VARCHAR(45),
    IN NewSynopsis VARCHAR(255)
)
BEGIN
    UPDATE episode
    SET
        Part = IF(NewPart IS NOT NULL, NewPart, Part),
        Episode = IF(NewEpisode IS NOT NULL, NewEpisode, Episode),
        Name = IF(NewName IS NOT NULL, NewName, Name),
        Synopsis = IF(NewSynopsis IS NOT NULL, NewSynopsis, Synopsis)
    WHERE EpisodeID = ModifyEpisodeID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEpisode
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEpisode`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEpisode` (
    IN DeleteEpisodeID INT
)
BEGIN
    DELETE FROM episode
    WHERE EpisodeID = DeleteEpisodeID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddStartDuration
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddStartDuration`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddStartDuration` (
    IN NewStartEventIncludesObjectID INT,
    IN NewStartEventDescription VARCHAR(255)
)
BEGIN
    INSERT INTO duration (StartEventDescription, StartEventIncludesObjectID)
    VALUES (NewStartEventDescription, NewStartEventIncludesObjectID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEndDuration
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEndDuration`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEndDuration` (
    IN NewDurationID INT,
    IN NewEndEventDescription VARCHAR(255),
    IN NewEndEventIncludesObjectID INT
)
BEGIN
    UPDATE duration
    SET EndEventDescription = IFNULL(NewEndEventDescription, EndEventDescription),
        EndEventIncludesObjectID = IFNULL(NewEndEventIncludesObjectID, EndEventIncludesObjectID)
    WHERE DurationID = NewDurationID AND (NewEndEventDescription IS NOT NULL OR NewEndEventIncludesObjectID IS NOT NULL);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyDuration
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyDuration`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyDuration` (
    IN NewDurationID INT,
    IN NewStartEventDescription VARCHAR(255),
    IN NewEndEventDescription VARCHAR(255),
    IN NewStartEventIncludesObjectID INT,
    IN NewEndEventIncludesObjectID INT
)
BEGIN
    UPDATE duration
    SET
        StartEventDescription = IF(NewStartEventDescription IS NOT NULL, NewStartEventDescription, StartEventDescription),
        EndEventDescription = IF(NewEndEventDescription IS NOT NULL, NewEndEventDescription, EndEventDescription),
        StartEventIncludesObjectID = IF(NewStartEventIncludesObjectID IS NOT NULL, NewStartEventIncludesObjectID, StartEventIncludesObjectID),
        EndEventIncludesObjectID = IF(NewEndEventIncludesObjectID IS NOT NULL, NewEndEventIncludesObjectID, EndEventIncludesObjectID)
    WHERE DurationID = NewDurationID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteDuration
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteDuration`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteDuration` (
    IN DurationIDToDelete INT
)
BEGIN
    DELETE FROM duration
    WHERE DurationID = DurationIDToDelete;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEvent
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEvent`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEvent` (
    IN NewEventName VARCHAR(45),
    IN NewEpisodeID INT,
    IN NewEventDescription VARCHAR(255),
    IN NewTimestamp DECIMAL(3, 0)
)
BEGIN
    INSERT INTO event (EventName, EpisodeID, EventDescription, Timestamp)
    VALUES (NewEventName, NewEpisodeID, NewEventDescription, NewTimestamp);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEvent
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyEvent`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEvent` (
    IN EventIDToUpdate INT,
    IN NewEventName VARCHAR(45),
    IN NewEpisodeID INT,
    IN NewEventDescription VARCHAR(255),
    IN NewTimestamp DECIMAL(3, 0)
)
BEGIN
    UPDATE event
    SET EventName = IFNULL(NewEventName, EventName),
        EpisodeID = IFNULL(NewEpisodeID, EpisodeID),
        EventDescription = IFNULL(NewEventDescription, EventDescription),
        Timestamp = IFNULL(NewTimestamp, Timestamp)
    WHERE EventID = EventIDToUpdate;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEvent
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEvent`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEvent` (
    IN EventIDToDelete INT
)
BEGIN
    DELETE FROM event
    WHERE EventID = EventIDToDelete;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddTrait` (
    IN NewTraitID INT,
    IN NewTraitName VARCHAR(45),
    IN NewTraitUniversalDescription VARCHAR(45)
)
BEGIN
    INSERT INTO trait (TraitID, TraitName, TraitUniversalDescription)
    VALUES (NewTraitID, NewTraitName, NewTraitUniversalDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyTrait` (
    IN TraitIDToUpdate INT,
    IN NewTraitName VARCHAR(45),
    IN NewTraitUniversalDescription VARCHAR(45)
)
BEGIN
    UPDATE trait
    SET TraitName = IFNULL(NewTraitName, TraitName),
        TraitUniversalDescription = IFNULL(NewTraitUniversalDescription, TraitUniversalDescription)
    WHERE TraitID = TraitIDToUpdate;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteTrait` (
    IN TraitIDToDelete INT
)
BEGIN
    DELETE FROM trait
    WHERE TraitID = TraitIDToDelete;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddObjectHasTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddObjectHasTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddObjectHasTrait` (
    IN NewObjectHasTraitID INT,
    IN NewObjectID INT,
    IN NewTraitID INT,
    IN NewDurationID INT,
    IN NewObjectHasTraitDescription VARCHAR(255),
    IN NewTraitPriority DECIMAL(2,0)
)
BEGIN
    INSERT INTO objecthastrait (ObjectHasTraitID, ObjectID, TraitID, DurationID, ObjectHasTraitDescription, TraitPriority)
    VALUES (NewObjectHasTraitID, NewObjectID, NewTraitID, NewDurationID, NewObjectHasTraitDescription, NewTraitPriority);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyObjectHasTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyObjectHasTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyObjectHasTrait` (
    IN ObjectHasTraitIDToUpdate INT,
    IN NewObjectID INT,
    IN NewTraitID INT,
    IN NewDurationID INT,
    IN NewObjectHasTraitDescription VARCHAR(255),
    IN NewTraitPriority DECIMAL(2,0)
)
BEGIN
    UPDATE objecthastrait
    SET ObjectID = IFNULL(NewObjectID, ObjectID),
        TraitID = IFNULL(NewTraitID, TraitID),
        DurationID = IFNULL(NewDurationID, DurationID),
        ObjectHasTraitDescription = IFNULL(NewObjectHasTraitDescription, ObjectHasTraitDescription),
        TraitPriority = IFNULL(NewTraitPriority, TraitPriority)
    WHERE ObjectHasTraitID = ObjectHasTraitIDToUpdate;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteObjectHasTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteObjectHasTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteObjectHasTrait` (
    IN ObjectHasTraitIDToDelete INT
)
BEGIN
    DELETE FROM objecthastrait
    WHERE ObjectHasTraitID = ObjectHasTraitIDToDelete;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddObject
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddObject`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddObject` (
    IN NewObjectID INT,
    IN NewObjectTypeID INT,
    IN NewObjectReferenceName VARCHAR(45),
    IN NewObjectDescription VARCHAR(255)
)
BEGIN
    INSERT INTO `object` (ObjectID, ObjectTypeID, ObjectReferenceName, ObjectDescription)
    VALUES (NewObjectID, NewObjectTypeID, NewObjectReferenceName, NewObjectDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyObject
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyObject`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyObject` (
    IN ObjectIDToUpdate INT,
    IN NewObjectTypeID INT,
    IN NewObjectReferenceName VARCHAR(45),
    IN NewObjectDescription VARCHAR(255)
)
BEGIN
    UPDATE `object`
    SET ObjectTypeID = IFNULL(NewObjectTypeID, ObjectTypeID),
        ObjectReferenceName = IFNULL(NewObjectReferenceName, ObjectReferenceName),
        ObjectDescription = IFNULL(NewObjectDescription, ObjectDescription)
    WHERE ObjectID = ObjectIDToUpdate;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteObject
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteObject`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteObject` (
    IN ObjectIDToDelete INT
)
BEGIN
    DELETE FROM `object`
    WHERE ObjectID = ObjectIDToDelete;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddObjectHasObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddObjectHasObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddObjectHasObjectName` (
    IN NewObjectHasNameID INT,
    IN NewObjectID INT,
    IN NewObjectNameID INT
)
BEGIN
    INSERT INTO `objecthasobjectname` (ObjectHasNameID, ObjectID, ObjectNameID)
    VALUES (NewObjectHasNameID, NewObjectID, NewObjectNameID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyObjectHasObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyObjectHasObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyObjectHasObjectName` (
    IN ObjectHasNameIDToUpdate INT,
    IN NewObjectID INT,
    IN NewObjectNameID INT
)
BEGIN
    UPDATE `objecthasobjectname`
    SET ObjectID = IFNULL(NewObjectID, ObjectID),
        ObjectNameID = IFNULL(NewObjectNameID, ObjectNameID)
    WHERE ObjectHasNameID = ObjectHasNameIDToUpdate;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteObjectHasObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteObjectHasObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteObjectHasObjectName` (
    IN ObjectHasNameIDToDelete INT
)
BEGIN
    DELETE FROM `objecthasobjectname`
    WHERE ObjectHasNameID = ObjectHasNameIDToDelete;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventHasExampleOfObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEventHasExampleOfObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventHasExampleOfObjectName` (
    IN NewEventHasExampleOfObjectNameID INT,
    IN NewObjectHasNameID INT,
    IN NewEvidenceDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    INSERT INTO `eventhasexampleofobjectname` (EventHasExampleOfObjectNameID, ObjectHasNameID, EvidenceDescription, EventIncludesObjectID)
    VALUES (NewEventHasExampleOfObjectNameID, NewObjectHasNameID, NewEvidenceDescription, NewEventIncludesObjectID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventHasExampleOfObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyEventHasExampleOfObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventHasExampleOfObjectName` (
    IN EventHasExampleOfObjectNameIDToUpdate INT,
    IN NewObjectHasNameID INT,
    IN NewEvidenceDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    UPDATE `eventhasexampleofobjectname`
    SET ObjectHasNameID = IFNULL(NewObjectHasNameID, ObjectHasNameID),
        EvidenceDescription = IFNULL(NewEvidenceDescription, EvidenceDescription),
        EventIncludesObjectID = IFNULL(NewEventIncludesObjectID, EventIncludesObjectID)
    WHERE EventHasExampleOfObjectNameID = EventHasExampleOfObjectNameIDToUpdate;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventHasExampleOfObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEventHasExampleOfObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventHasExampleOfObjectName` (
    IN EventHasExampleOfObjectNameIDToDelete INT
)
BEGIN
    DELETE FROM `eventhasexampleofobjectname`
    WHERE EventHasExampleOfObjectNameID = EventHasExampleOfObjectNameIDToDelete;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventIncludesObject
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEventIncludesObject`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventIncludesObject` (
    IN NewEventID INT,
    IN NewObjectID INT,
    IN NewInclusionDescription VARCHAR(45),
    IN NewSequentialID DECIMAL(3,0)
)
BEGIN
    INSERT INTO `mydb`.`eventincludesobject` (EventID, ObjectID, InclusionDescription, SequentialID)
    VALUES (NewEventID, NewObjectID, NewInclusionDescription, NewSequentialID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventIncludesObject
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyEventIncludesObject`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventIncludesObject` (
    IN ModifyEventIncludesObjectID INT,
    IN NewEventID INT,
    IN NewObjectID INT,
    IN NewInclusionDescription VARCHAR(45),
    IN NewSequentialID DECIMAL(3,0)
)
BEGIN
    UPDATE `mydb`.`eventincludesobject`
    SET EventID = IFNULL(NewEventID, EventID),
        ObjectID = IFNULL(NewObjectID, ObjectID),
        InclusionDescription = IFNULL(NewInclusionDescription, InclusionDescription),
        SequentialID = IFNULL(NewSequentialID, SequentialID)
    WHERE EventIncludesObjectID = ModifyEventIncludesObjectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventIncludesObject
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEventIncludesObject`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventIncludesObject` (
    IN DeleteEventIncludesObjectID INT
)
BEGIN
    DELETE FROM `mydb`.`eventincludesobject`
    WHERE EventIncludesObjectID = DeleteEventIncludesObjectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventAddressesObjectHasTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEventAddressesObjectHasTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventAddressesObjectHasTrait` (
    IN NewObjectHasTraitID INT,
    IN NewEventAddressesObjectHasTraitDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    INSERT INTO `mydb`.`eventaddressesobjecthastrait` (ObjectHasTraitID, EventAddressesObjectHasTraitDescription, EventIncludesObjectID)
    VALUES (NewObjectHasTraitID, NewEventAddressesObjectHasTraitDescription, NewEventIncludesObjectID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventAddressesObjectHasTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyEventAddressesObjectHasTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventAddressesObjectHasTrait` (
    IN ModifyEventAddressesObjectHasTraitID INT,
    IN NewObjectHasTraitID INT,
    IN NewEventAddressesObjectHasTraitDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    UPDATE `mydb`.`eventaddressesobjecthastrait`
    SET ObjectHasTraitID = IFNULL(NewObjectHasTraitID, ObjectHasTraitID),
        EventAddressesObjectHasTraitDescription = IFNULL(NewEventAddressesObjectHasTraitDescription, EventAddressesObjectHasTraitDescription),
        EventIncludesObjectID = IFNULL(NewEventIncludesObjectID, EventIncludesObjectID)
    WHERE EventAddressesObjectHasTraitID = ModifyEventAddressesObjectHasTraitID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventAddressesObjectHasTrait
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEventAddressesObjectHasTrait`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventAddressesObjectHasTrait` (
    IN DeleteEventAddressesObjectHasTraitID INT
)
BEGIN
    DELETE FROM `mydb`.`eventaddressesobjecthastrait`
    WHERE EventAddressesObjectHasTraitID = DeleteEventAddressesObjectHasTraitID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventAddressesObjectRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEventAddressesObjectRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventAddressesObjectRelationship` (
    IN NewObjectHasRelationshipToObjectID INT,
    IN NewEventAddressesObjectRelationshipDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    INSERT INTO `mydb`.`eventaddressesobjectrelationship` (ObjectHasRelationshipToObjectID, EventAddressesObjectRelationshipDescription, EventIncludesObjectID)
    VALUES (NewObjectHasRelationshipToObjectID, NewEventAddressesObjectRelationshipDescription, NewEventIncludesObjectID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventAddressesObjectRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyEventAddressesObjectRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventAddressesObjectRelationship` (
    IN ModifyEventAddressesObjectRelationshipID INT,
    IN NewObjectHasRelationshipToObjectID INT,
    IN NewEventAddressesObjectRelationshipDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    UPDATE `mydb`.`eventaddressesobjectrelationship`
    SET ObjectHasRelationshipToObjectID = IFNULL(NewObjectHasRelationshipToObjectID, ObjectHasRelationshipToObjectID),
        EventAddressesObjectRelationshipDescription = IFNULL(NewEventAddressesObjectRelationshipDescription, EventAddressesObjectRelationshipDescription),
        EventIncludesObjectID = IFNULL(NewEventIncludesObjectID, EventIncludesObjectID)
    WHERE EventAddressesObjectRelationshipID = ModifyEventAddressesObjectRelationshipID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventAddressesObjectRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEventAddressesObjectRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventAddressesObjectRelationship` (
    IN DeleteEventAddressesObjectRelationshipID INT
)
BEGIN
    DELETE FROM `mydb`.`eventaddressesobjectrelationship`
    WHERE EventAddressesObjectRelationshipID = DeleteEventAddressesObjectRelationshipID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventHasOtherNotes
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEventHasOtherNotes`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventHasOtherNotes` (
    IN NewEventID INT,
    IN NewNote VARCHAR(255)
)
BEGIN
    INSERT INTO `mydb`.`eventhasothernotes` (EventID, Note)
    VALUES (NewEventID, NewNote);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventHasOtherNotes
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyEventHasOtherNotes`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventHasOtherNotes` (
    IN ModifyEventHasOtherNotesID INT,
    IN NewEventID INT,
    IN NewNote VARCHAR(255)
)
BEGIN
    UPDATE `mydb`.`eventhasothernotes`
    SET EventID = IFNULL(NewEventID, EventID),
        Note = IFNULL(NewNote, Note)
    WHERE EventHasOtherNotesID = ModifyEventHasOtherNotesID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventHasOtherNotes
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEventHasOtherNotes`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventHasOtherNotes` (
    IN DeleteEventHasOtherNotesID INT
)
BEGIN
    DELETE FROM `mydb`.`eventhasothernotes`
    WHERE EventHasOtherNotesID = DeleteEventHasOtherNotesID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddRelationship` (
    IN NewRelationshipID INT,
    IN NewRelationshipType VARCHAR(45),
    IN NewRelationshipTypeUniversalDescription VARCHAR(255)
)
BEGIN
    INSERT INTO `mydb`.`relationship` (RelationshipID, RelationshipType, RelationshipTypeUniversalDescription)
    VALUES (NewRelationshipID, NewRelationshipType, NewRelationshipTypeUniversalDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyRelationship` (
    IN ModifyRelationshipID INT,
    IN NewRelationshipType VARCHAR(45),
    IN NewRelationshipTypeUniversalDescription VARCHAR(255)
)
BEGIN
    UPDATE `mydb`.`relationship`
    SET RelationshipType = IFNULL(NewRelationshipType, RelationshipType),
        RelationshipTypeUniversalDescription = IFNULL(NewRelationshipTypeUniversalDescription, RelationshipTypeUniversalDescription)
    WHERE RelationshipID = ModifyRelationshipID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteRelationship` (
    IN DeleteRelationshipID INT
)
BEGIN
    DELETE FROM `mydb`.`relationship`
    WHERE RelationshipID = DeleteRelationshipID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddWish
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddWish`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddWish` (
    IN WishQuoteValue VARCHAR(255),
    IN DescriptionValue VARCHAR(255),
    IN CurrentStatusDescriptionValue VARCHAR(255)
)
BEGIN
    INSERT INTO `mydb`.`wish` (WishQuote, Description, CurrentStatusDescription)
    VALUES (WishQuoteValue, DescriptionValue, CurrentStatusDescriptionValue);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyWish
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyWish`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyWish` (
    IN WishIDValue INT,
    IN WishQuoteValue VARCHAR(255),
    IN DescriptionValue VARCHAR(255),
    IN CurrentStatusDescriptionValue VARCHAR(255)
)
BEGIN
    UPDATE `mydb`.`wish`
    SET
        WishQuote = IFNULL(WishQuoteValue, WishQuote),
        Description = IFNULL(DescriptionValue, Description),
        CurrentStatusDescription = IFNULL(CurrentStatusDescriptionValue, CurrentStatusDescription)
    WHERE WishID = WishIDValue;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteWish
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteWish`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteWish` (
    IN DeleteWishID INT
)
BEGIN
    DELETE FROM `mydb`.`wish`
    WHERE WishID = DeleteWishID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventHasWish
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddEventHasWish`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventHasWish` (
    IN WishIDValue INT,
    IN WishGrantDenyValue VARCHAR(5),
    IN EventIncludesObjectIDValue INT
)
BEGIN
    INSERT INTO `mydb`.`eventincludesobjecthaswish` (WishID, WishGrantDeny, EventIncludesObjectID)
    VALUES (WishIDValue, WishGrantDenyValue, EventIncludesObjectIDValue);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventHasWish
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyEventHasWish`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventHasWish` (
    IN EventHasWishIDValue INT,
    IN WishIDValue INT,
    IN WishGrantDenyValue VARCHAR(5),
    IN EventIncludesObjectIDValue INT
)
BEGIN
    UPDATE `mydb`.`eventincludesobjecthaswish`
    SET
        WishID = WishIDValue,
        WishGrantDeny = WishGrantDenyValue,
        EventIncludesObjectID = EventIncludesObjectIDValue
    WHERE EventHasWishID = EventHasWishIDValue;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventHasWish
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteEventHasWish`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventHasWish` (
    IN DeleteEventHasWishID INT
)
BEGIN
    DELETE FROM `mydb`.`eventincludesobjecthaswish`
    WHERE EventHasWishID = DeleteEventHasWishID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddObjectHasRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddObjectHasRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddObjectHasRelationship` (
    IN ObjectHasRelationshipToObjectIDValue INT,
    IN Object1IDValue INT,
    IN RelationshipIDValue INT,
    IN Object2IDValue INT,
    IN ExplanationValue VARCHAR(45),
    IN DurationIDValue INT,
    IN RelationshipPriorityIDValue DECIMAL(2,0),
    IN Object2InheritsTraitsFromObject1Value INT
)
BEGIN
    INSERT INTO `mydb`.`objecthasrelationshiptoobject` (ObjectHasRelationshipToObjectID, Object1ID, RelationshipID, Object2ID, Explanation, DurationID, RelationshipPriorityID, Object2InheritsTraitsFromObject1)
    VALUES (ObjectHasRelationshipToObjectIDValue, Object1IDValue, RelationshipIDValue, Object2IDValue, ExplanationValue, DurationIDValue, RelationshipPriorityIDValue, Object2InheritsTraitsFromObject1Value);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyObjectHasRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyObjectHasRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyObjectHasRelationship` (
    IN ObjectHasRelationshipToObjectIDValue INT,
    IN Object1IDValue INT,
    IN RelationshipIDValue INT,
    IN Object2IDValue INT,
    IN ExplanationValue VARCHAR(45),
    IN DurationIDValue INT,
    IN RelationshipPriorityIDValue DECIMAL(2,0),
    IN Object2InheritsTraitsFromObject1Value INT
)
BEGIN
    UPDATE `mydb`.`objecthasrelationshiptoobject`
    SET
        Object1ID = Object1IDValue,
        RelationshipID = RelationshipIDValue,
        Object2ID = Object2IDValue,
        Explanation = ExplanationValue,
        DurationID = DurationIDValue,
        RelationshipPriorityID = RelationshipPriorityIDValue,
        Object2InheritsTraitsFromObject1 = Object2InheritsTraitsFromObject1Value
    WHERE ObjectHasRelationshipToObjectID = ObjectHasRelationshipToObjectIDValue;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteObjectHasRelationship
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteObjectHasRelationship`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteObjectHasRelationship` (
    IN DeleteObjectHasRelationshipToObjectID INT
)
BEGIN
    DELETE FROM `mydb`.`objecthasrelationshiptoobject`
    WHERE ObjectHasRelationshipToObjectID = DeleteObjectHasRelationshipToObjectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`AddObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddObjectName` (
    IN ObjectNameIDValue INT,
    IN ObjectNameValue VARCHAR(45),
    IN NameTypeValue VARCHAR(45),
    IN NamePriorityValue VARCHAR(45)
)
BEGIN
    INSERT INTO `mydb`.`objectname` (ObjectNameID, ObjectName, NameType, NamePriority)
    VALUES (ObjectNameIDValue, ObjectNameValue, NameTypeValue, NamePriorityValue);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ModifyObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyObjectName` (
    IN ObjectNameIDValue INT,
    IN ObjectNameValue VARCHAR(45),
    IN NameTypeValue VARCHAR(45),
    IN NamePriorityValue VARCHAR(45)
)
BEGIN
    UPDATE `mydb`.`objectname`
    SET
        ObjectName = ObjectNameValue,
        NameType = NameTypeValue,
        NamePriority = NamePriorityValue
    WHERE ObjectNameID = ObjectNameIDValue;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteObjectName
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`DeleteObjectName`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteObjectName` (
    IN DeleteObjectNameID INT
)
BEGIN
    DELETE FROM `mydb`.`objectname`
    WHERE ObjectNameID = DeleteObjectNameID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `mydb`.`objecttimeline`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`objecttimeline`;
DROP VIEW IF EXISTS `mydb`.`objecttimeline` ;
USE `mydb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`CapstoneAuthor`@`%` SQL SECURITY DEFINER VIEW `mydb`.`objecttimeline` AS select `o`.`ObjectReferenceName` AS `ObjectReferenceName`,`eio`.`InclusionDescription` AS `InclusionDescription` from (((((((((`mydb`.`objecthasrelationshiptoobject` `ohrto` left join (((`mydb`.`object` `o` left join `mydb`.`eventincludesobject` `eio` on((`o`.`ObjectID` = `eio`.`ObjectID`))) left join `mydb`.`event` `e` on((`eio`.`EventID` = `e`.`EventID`))) left join `mydb`.`eventaddressesobjectrelationship` `eaor` on((`eio`.`EventIncludesObjectID` = `eaor`.`EventIncludesObjectID`))) on((`o`.`ObjectID` = `ohrto`.`Object1ID`))) left join `mydb`.`eventhasexampleofobjectname` `eheoo` on((`eio`.`EventIncludesObjectID` = `eheoo`.`EventIncludesObjectID`))) left join `mydb`.`eventincludesobjecthaswish` `eiohw` on((`eio`.`EventIncludesObjectID` = `eiohw`.`EventIncludesObjectID`))) left join `mydb`.`eventaddressesobjecthastrait` `eaoht` on((`eio`.`EventIncludesObjectID` = `eaoht`.`EventIncludesObjectID`))) left join `mydb`.`objecthastrait` `aht` on((`eaoht`.`ObjectHasTraitID` = `aht`.`ObjectHasTraitID`))) left join `mydb`.`trait` `t` on((`aht`.`TraitID` = `t`.`TraitID`))) left join `mydb`.`objecthasobjectname` `oho` on((`eheoo`.`ObjectHasNameID` = `oho`.`ObjectHasNameID`))) left join `mydb`.`objectname` `n` on((`oho`.`ObjectNameID` = `n`.`ObjectNameID`))) left join `mydb`.`wish` `w` on((`eiohw`.`WishID` = `w`.`WishID`))) order by `eio`.`SequentialID`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
