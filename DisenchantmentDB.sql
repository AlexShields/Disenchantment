-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`duration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`duration` (
  `DurationID` INT NOT NULL,
  `StartEventDescription` VARCHAR(255) NULL DEFAULT NULL,
  `EndEventDescription` VARCHAR(255) NULL DEFAULT NULL,
  `Durationcol` VARCHAR(45) NULL DEFAULT NULL,
  `StartEvent_Includes_ObjectID` INT NOT NULL,
  `EndEvent_Includes_ObjectID` INT NOT NULL,
  PRIMARY KEY (`DurationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`episode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`episode` (
  `EpisodeID` INT NOT NULL,
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
CREATE TABLE IF NOT EXISTS `mydb`.`event` (
  `EventID` INT NOT NULL,
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
CREATE TABLE IF NOT EXISTS `mydb`.`eventincludesobject` (
  `EventIncludesObjectID` INT NOT NULL,
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
-- Table `mydb`.`trait`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `mydb`.`objecthastrait` (
  `ObjectHasTraitID` INT NOT NULL,
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
CREATE TABLE IF NOT EXISTS `mydb`.`relationship` (
  `RelationshipID` INT NOT NULL,
  `RelationshipType` VARCHAR(45) NULL DEFAULT NULL,
  `RelationshipTypeUniversalDescription` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`RelationshipID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`object1hasrelationshiptoobject2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`object1hasrelationshiptoobject2` (
  `Object1_Has_Relationship_To_Object2ID` INT NOT NULL,
  `Object1ID` INT NOT NULL,
  `RelationshipID` INT NOT NULL,
  `Object2ID` INT NOT NULL,
  `Explanation` VARCHAR(45) NULL DEFAULT NULL,
  `DurationID` INT NOT NULL,
  `RelationshipPriorityID` DECIMAL(2,0) NULL DEFAULT NULL,
  `Object2InheritsTraitsFromObject1` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Object1_Has_Relationship_To_Object2ID`),
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Object1_idx` (`Object1ID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Relation_idx` (`RelationshipID` ASC) VISIBLE,
  INDEX `fk_Event_Establishes_Object_Relationship_To_Object_Object2_idx` (`Object2ID` ASC) VISIBLE,
  INDEX `fk_Object1_Has_Relationship_To_Object2_Duration1_idx` (`DurationID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Object1a`
    FOREIGN KEY (`Object1ID`)
    REFERENCES `mydb`.`object` (`ObjectID`),
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Object2a`
    FOREIGN KEY (`Object2ID`)
    REFERENCES `mydb`.`object` (`ObjectID`),
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Rel1a`
    FOREIGN KEY (`RelationshipID`)
    REFERENCES `mydb`.`relationship` (`RelationshipID`),
  CONSTRAINT `fk_Object1_Has_Relationship_To_Object2_Duration1a`
    FOREIGN KEY (`DurationID`)
    REFERENCES `mydb`.`duration` (`DurationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`eventaddressesobjectrelationship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eventaddressesobjectrelationship` (
  `EventAddressesObjectRelationshipID` INT NOT NULL AUTO_INCREMENT,
  `Object1HasRelationshipToObject2ID` INT NOT NULL,
  `EventAddressesObjectRelationshipDescription` VARCHAR(255) NULL DEFAULT NULL,
  `EventIncludesObjectID` INT NOT NULL,
  PRIMARY KEY (`EventAddressesObjectRelationshipID`),
  INDEX `fk_Event_Addresses_Object_Relationship_Object1_Has_Relation_idx` (`Object1HasRelationshipToObject2ID` ASC) VISIBLE,
  INDEX `fk_Event_Addresses_Object_Relationship_Event_Includes_Objec_idx` (`EventIncludesObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Addresses_Object_Relationship_Event_Includes_Object1a`
    FOREIGN KEY (`EventIncludesObjectID`)
    REFERENCES `mydb`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_Event_Addresses_Object_Relationship_Object1_Has_Relationsh1a`
    FOREIGN KEY (`Object1HasRelationshipToObject2ID`)
    REFERENCES `mydb`.`object1hasrelationshiptoobject2` (`Object1_Has_Relationship_To_Object2ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`objectname`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `mydb`.`eventhasothernotes` (
  `EventHasOtherNotesID` VARCHAR(45) NOT NULL,
  `EventID` INT NOT NULL,
  `Note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`EventHasOtherNotesID`),
  INDEX `fk_table1_Events1_idx` (`EventID` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`event` (`EventID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`wish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wish` (
  `WishID` INT NOT NULL,
  `WishQuote` VARCHAR(255) NULL DEFAULT NULL,
  `Description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`WishID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`eventincludesobjecthaswish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eventincludesobjecthaswish` (
  `EventHasWishID` INT NOT NULL,
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
