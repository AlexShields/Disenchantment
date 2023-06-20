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
-- Table `mydb`.`RelationshipType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RelationshipType` (
  `RelationshipTypeID` INT NOT NULL,
  `RelationshipTypeName` VARCHAR(45) NULL,
  PRIMARY KEY (`RelationshipTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relationship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Relationship` (
  `RelationshipID` INT NOT NULL,
  `RelationshipTypeID` INT NULL,
  PRIMARY KEY (`RelationshipID`),
  INDEX `fk_Relationship_RelationshipType1_idx` (`RelationshipTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_Relationship_RelationshipType1`
    FOREIGN KEY (`RelationshipTypeID`)
    REFERENCES `mydb`.`RelationshipType` (`RelationshipTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
-- Table `mydb`.`Event_Has_Wish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Has_Wish` (
  `EventID` INT NOT NULL,
  `GrantStatus` INT NULL,
  `GrantEventID` INT NULL,
  `Wish Quote` VARCHAR(45) NULL,
  `DescriptionOfObjectInclusion` VARCHAR(255) NULL,
  `WishingObjectID` INT NOT NULL,
  INDEX `fk_Event_Is_Wish_Events1_idx` (`GrantEventID` ASC) VISIBLE,
  INDEX `fk_Event_Is_Wish_Events2_idx` (`EventID` ASC) VISIBLE,
  INDEX `fk_Event_Is_Wish_Object1_idx` (`WishingObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Is_Wish_Events1`
    FOREIGN KEY (`GrantEventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Is_Wish_Events2`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Is_Wish_Object1`
    FOREIGN KEY (`WishingObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
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
-- Table `mydb`.`Event_Establishes_Object1_Relationship_To_Object2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Establishes_Object1_Relationship_To_Object2` (
  `EventID` INT NOT NULL,
  `Object1ID` INT NOT NULL,
  `RelationshipID` INT NOT NULL,
  `Object2ID` INT NOT NULL,
  `Explanation` VARCHAR(45) NULL,
  PRIMARY KEY (`EventID`),
  INDEX `fk_Event_Establishes_Object_Relationship_Events1_idx` (`EventID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Object1_idx` (`Object1ID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Relation_idx` (`RelationshipID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Object2_idx` (`Object2ID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
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
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Status` (
  `StatusID` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `StatusDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`StatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Establishes_Object_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Establishes_Object_Status` (
  `Event_Establishes_Object_Status_ID` INT NOT NULL AUTO_INCREMENT,
  `ObjectID` INT NOT NULL,
  `StatusID` INT NOT NULL,
  `EventID` INT NOT NULL,
  `Description` VARCHAR(255) NULL,
  INDEX `fk_Event_Establishes_Object_Status_Object1_idx` (`ObjectID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Status_Status1_idx` (`StatusID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Status_Events1_idx` (`EventID` ASC) VISIBLE,
  PRIMARY KEY (`Event_Establishes_Object_Status_ID`),
  CONSTRAINT `fk_Event_Establishes_Object_Status_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Establishes_Object_Status_Status1`
    FOREIGN KEY (`StatusID`)
    REFERENCES `mydb`.`Status` (`StatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Establishes_Object_Status_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Traits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Traits` (
  `TraitID` INT NOT NULL,
  `TraitName` VARCHAR(45) NULL,
  PRIMARY KEY (`TraitID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Object_Has_Trait`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Object_Has_Trait` (
  `Object_Has_TraitID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  `TraitID` INT NOT NULL,
  PRIMARY KEY (`Object_Has_TraitID`),
  INDEX `fk_ObjectHasTrait_Object1_idx` (`ObjectID` ASC) VISIBLE,
  INDEX `fk_ObjectHasTrait_Traits1_idx` (`TraitID` ASC) VISIBLE,
  CONSTRAINT `fk_ObjectHasTrait_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ObjectHasTrait_Traits1`
    FOREIGN KEY (`TraitID`)
    REFERENCES `mydb`.`Traits` (`TraitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ObjectName`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ObjectName` (
  `ObjectNameID` INT NOT NULL,
  `ObjectName` VARCHAR(45) NULL,
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
-- Table `mydb`.`Event_Has_Example_Of_Object_Has_Trait`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event_Has_Example_Of_Object_Has_Trait` (
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
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- procedure AddEpisode
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEpisode` (
IN NewEpisodeID INT,
IN NewPart INT,
IN NewEpisode INT,
IN NewName VARCHAR(45),
IN NewSynopsis VARCHAR(255)
)
BEGIN
IF NOT EXISTS (SELECT * FROM Episodes WHERE EpisodeID = NewEpisodeID) THEN
        INSERT INTO Episodes (EpisodeID, Part, NewEpisode, Name, Synopsis)
        VALUES (NewEmployeeID, NewPart, NewEpisode, NewName, NewSynopsis);
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEpisode
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEpisode` (
    IN EpisodeID INT,
    IN NewPart INT,
    IN NewEpisode INT,
    IN NewName VARCHAR(45),
    IN NewSynopsis VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT * FROM Episodes WHERE EpisodeID = EpisodeID) THEN
        UPDATE Episodes
        SET Part = IF(NewPart IS NOT NULL, NewPart, Part),
            Episode = IF(NewEpisode IS NOT NULL, NewEpisode, Episode),
            Name = IF(NewName IS NOT NULL, NewName, Name),
            Synopsis = IF(NewSynopsis IS NOT NULL, NewSynopsis, Synopsis)
        WHERE EpisodeID = EpisodeID;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEpisode
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEpisode` (DeleteEpisodeID INT)
BEGIN
    IF EXISTS (SELECT * FROM Episodes WHERE EpisodeID = DeleteEpisodeID) THEN
        DELETE FROM Episodes WHERE EpisodeID = DeleteEpisodeID;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddObject
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddObject` (
IN NewObjectReferenceName VARCHAR(45),
IN NewObjectTypeID INT, -- 1 for Characters
						-- 2 for Story Objects
                        -- 3 for Locations
                        -- 4 for Groups
                        -- 5 for Themes
IN NewObjectDescription VARCHAR(255)
)
BEGIN
IF NOT EXISTS (SELECT * FROM Object WHERE ObjectReferenceName = NewObjectReferecneName) THEN
        INSERT INTO Objects (ObjectTypeID, ObjectReferenceName, ObjectDescription)
        VALUES (NewObjectTypeID, NewObjectReferenceName, NewObjectDescription);
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteObject
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteObject` (IN DeleteObjectID INT)
BEGIN
    IF EXISTS (SELECT * FROM Object WHERE Object = DeleteEpisodeID) THEN
        DELETE FROM Object WHERE ObjectID = DeleteObjectID;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyObject
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyObject` (
    IN ObjectID INT,
    IN NewObjectTypeID INT,
    IN NewObjectDescription VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT * FROM Objects WHERE ObjectID = ObjectID) THEN
        UPDATE Objects
        SET ObjectTypeID = IF(NewObjectTypeID IS NOT NULL, NewObjectTypeID, ObjectTypeID),
            ObjectDescription = IF(NewObjectDescription IS NOT NULL, NewObjectDescription, ObjectDescription)
        WHERE ObjectID = ObjectID;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEvent
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEvent` (
    IN NewEventID INT,
    IN NewEventName VARCHAR(45),
    IN NewEpisodeID INT,
    IN NewEventDescription VARCHAR(255),
    IN NewTimestamp DECIMAL(3),
    IN NewSequentialID DECIMAL(3)
)
BEGIN
    INSERT INTO Events (EventID, EventName, EpisodeID, EventDescription, Timestamp, SequentialID)
    VALUES (NewEventID, NewEventName, NewEpisodeID, NewEventDescription, NewTimestamp, NewSequentialID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEvent
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEvent` (
    IN ModifyEventID INT,
    IN NewEventName VARCHAR(45),
    IN NewEpisodeID INT,
    IN NewEventDescription VARCHAR(255),
    IN NewTimestamp DECIMAL(3),
    IN NewSequentialID DECIMAL(3)
)
BEGIN
    IF EXISTS (SELECT * FROM Events WHERE EventID = ModifyEventID) THEN
        UPDATE Events
        SET EventName = IF(NewEventName IS NOT NULL, NewEventName, EventName),
            EpisodeID = IF(NewEpisodeID IS NOT NULL, NewEpisodeID, EpisodeID),
            EventDescription = IF(NewEventDescription IS NOT NULL, NewEventDescription, EventDescription),
            Timestamp = IF(NewTimestamp IS NOT NULL, NewTimestamp, Timestamp),
            SequentialID = IF(NewSequentialID IS NOT NULL, NewSequentialID, SequentialID)
        WHERE EventID = ModifyEventID;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEvent
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEvent` (
    IN DeleteEventID INT
)
BEGIN
    DELETE FROM Events WHERE EventID = DeleteEventID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventEstablishesObjectStatus
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventEstablishesObjectStatus` (
    IN NewObjectID INT,
    IN NewStatusID INT,
    IN NewEventID INT,
    IN NewDescription VARCHAR(255)
)
BEGIN
    INSERT INTO Event_Establishes_Object_Status (ObjectID, StatusID, EventID, Description)
    VALUES (NewObjectID, NewStatusID, NewEventID, NewDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventEstablishesObjectStatus
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventEstablishesObjectStatus` (
    IN ModifyEventEstablishesObjectStatusID INT,
    IN NewObjectID INT,
    IN NewStatusID INT,
    IN NewEventID INT,
    IN NewDescription VARCHAR(255)
)
BEGIN
    UPDATE Event_Establishes_Object_Status
    SET ObjectID = IF(NewObjectID IS NOT NULL, NewObjectID, ObjectID),
        StatusID = IF(NewStatusID IS NOT NULL, NewStatusID, StatusID),
        EventID = IF(NewEventID IS NOT NULL, NewEventID, EventID),
        Description = IF(NewDescription IS NOT NULL, NewDescription, Description)
    WHERE Event_Establishes_Object_Status_ID = ModifyEventEstablishesObjectStatusID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventEstablishesObjectStatus
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventEstablishesObjectStatus` (
    IN EventEstablishesObjectStatusID INT
)
BEGIN
    DELETE FROM Event_Establishes_Object_Status WHERE Event_Establishes_Object_Status_ID = EventEstablishesObjectStatusID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventHasWish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventHasWish` (
    IN NewEventID INT,
    IN NewGrantStatus INT,
    IN NewGrantEventID INT,
    IN NewWishQuote VARCHAR(45),
    IN NewDescriptionOfObjectInclusion VARCHAR(255),
    IN NewWishingObjectID INT
)
BEGIN
    INSERT INTO Event_Has_Wish (EventID, GrantStatus, GrantEventID, `Wish Quote`, DescriptionOfObjectInclusion, WishingObjectID)
    VALUES (NewEventID, NewGrantStatus, NewGrantEventID, NewWishQuote, NewDescriptionOfObjectInclusion, NewWishingObjectID);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventHasWish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventHasWish` (
    IN ModifyEventID INT,
    IN NewGrantStatus INT,
    IN NewGrantEventID INT,
    IN NewWishQuote VARCHAR(45),
    IN NewDescriptionOfObjectInclusion VARCHAR(255),
    IN NewWishingObjectID INT
)
BEGIN
    UPDATE Event_Has_Wish
    SET GrantStatus = IF(NewGrantStatus IS NOT NULL, NewGrantStatus, GrantStatus),
        GrantEventID = IF(NewGrantEventID IS NOT NULL, NewGrantEventID, GrantEventID),
        `Wish Quote` = IF(NewWishQuote IS NOT NULL, NewWishQuote, `Wish Quote`),
        DescriptionOfObjectInclusion = IF(NewDescriptionOfObjectInclusion IS NOT NULL, NewDescriptionOfObjectInclusion, DescriptionOfObjectInclusion),
        WishingObjectID = IF(NewWishingObjectID IS NOT NULL, NewWishingObjectID, WishingObjectID)
    WHERE EventID = ModifyEventID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventHasWish
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventHasWish` (
    IN EventID INT
)
BEGIN
    DELETE FROM Event_Has_Wish WHERE EventID = EventID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventIncludesObject
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventIncludesObject` (
    IN NewEventIncludesObjectID INT,
    IN NewEventID INT,
    IN NewObjectID INT,
    IN NewInclusionDescription VARCHAR(45)
)
BEGIN
    INSERT INTO Event_Includes_Object (Event_Includes_ObjectID, EventID, ObjectID, InclusionDescription)
    VALUES (NewEventIncludesObjectID, NewEventID, NewObjectID, NewInclusionDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventIncludesObject
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventIncludesObject` (
    IN ModifyEventIncludesObjectID INT,
    IN NewEventID INT,
    IN NewObjectID INT,
    IN NewInclusionDescription VARCHAR(45)
)
BEGIN
    UPDATE Event_Includes_Object
    SET EventID = IF(NewEventID IS NOT NULL, NewEventID, EventID),
        ObjectID = IF(NewObjectID IS NOT NULL, NewObjectID, ObjectID),
        InclusionDescription = IF(NewInclusionDescription IS NOT NULL, NewInclusionDescription, InclusionDescription)
    WHERE Event_Includes_ObjectID = ModifyEventIncludesObjectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventIncludesObject
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventIncludesObject` (
    IN EventIncludesObjectID INT
)
BEGIN
    DELETE FROM Event_Includes_Object WHERE Event_Includes_ObjectID = EventIncludesObjectID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventHasOtherNotes
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventHasOtherNotes` (
    IN NewEventHasOtherNotesID VARCHAR(45),
    IN NewEventID INT,
    IN NewNote VARCHAR(255)
)
BEGIN
    INSERT INTO Event_Has_Other_Notes (Event_Has_Other_NotesID, EventID, Note)
    VALUES (NewEventHasOtherNotesID, NewEventID, NewNote);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventHasOtherNotes
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventHasOtherNotes` (
    IN ModifyEventHasOtherNotesID VARCHAR(45),
    IN NewEventID INT,
    IN NewNote VARCHAR(255)
)
BEGIN
    UPDATE Event_Has_Other_Notes
    SET EventID = IF(NewEventID IS NOT NULL, NewEventID, EventID),
        Note = IF(NewNote IS NOT NULL, NewNote, Note)
    WHERE Event_Has_Other_NotesID = ModifyEventHasOtherNotesID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventHasOtherNotes
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventHasOtherNotes` (
    IN EventHasOtherNotesID VARCHAR(45)
)
BEGIN
    DELETE FROM Event_Has_Other_Notes WHERE Event_Has_Other_NotesID = EventHasOtherNotesID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddEventHasExampleOfObjectHasTrait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `AddEventHasExampleOfObjectHasTrait` (
    IN NewObjectHasTraitID INT,
    IN NewExampleEventID INT,
    IN NewDescription VARCHAR(255)
)
BEGIN
    INSERT INTO Event_Has_Example_Of_Object_Has_Trait (Object_Has_TraitID, ExampleEventID, Description)
    VALUES (NewObjectHasTraitID, NewExampleEventID, NewDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ModifyEventHasExampleOfObjectHasTrait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `ModifyEventHasExampleOfObjectHasTrait` (
    IN ModifyEventHasExampleOfObjectHasTraitID INT,
    IN NewObjectHasTraitID INT,
    IN NewExampleEventID INT,
    IN NewDescription VARCHAR(255)
)
BEGIN
    UPDATE Event_Has_Example_Of_Object_Has_Trait
    SET Object_Has_TraitID = IF(NewObjectHasTraitID IS NOT NULL, NewObjectHasTraitID, Object_Has_TraitID),
        ExampleEventID = IF(NewExampleEventID IS NOT NULL, NewExampleEventID, ExampleEventID),
        Description = IF(NewDescription IS NOT NULL, NewDescription, Description)
    WHERE Event_Has_Example_Of_Object_Has_Trait = ModifyEventHasExampleOfObjectHasTraitID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteEventHasExampleOfObjectHasTrait
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `DeleteEventHasExampleOfObjectHasTrait` (
    IN EventHasExampleOfObjectHasTraitID INT
)
BEGIN
    DELETE FROM Event_Has_Example_Of_Object_Has_Trait WHERE Event_Has_Example_Of_Object_Has_Trait = EventHasExampleOfObjectHasTraitID;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
