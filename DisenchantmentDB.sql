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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
