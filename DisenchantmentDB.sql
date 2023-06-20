-- MySQL Script generated by MySQL Workbench
-- Tue Jun 20 10:59:09 2023
-- Model: New Model    Version: 1.0
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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Character`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Character` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Character` (
  `ObjectID` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `Nickname` VARCHAR(45) NULL,
  `SpeciesID` INT NOT NULL,
  `HalfSpeciesID` INT NOT NULL,
  INDEX `fk_Character_Species1_idx` (`SpeciesID` ASC) VISIBLE,
  INDEX `fk_Character_Species2_idx` (`HalfSpeciesID` ASC) VISIBLE,
  PRIMARY KEY (`ObjectID`),
  UNIQUE INDEX `ObjectID_UNIQUE` (`ObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Character_Species1`
    FOREIGN KEY (`SpeciesID`)
    REFERENCES `mydb`.`Species` (`SpeciesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Character_Species2`
    FOREIGN KEY (`HalfSpeciesID`)
    REFERENCES `mydb`.`Species` (`SpeciesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Character_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Episodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Episodes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Episodes` (
  `EpisodeID` INT NOT NULL,
  `Part` INT NULL,
  `Episode` INT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`EpisodeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Establishes_Object1_Relationship_To_Object2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Event_Establishes_Object1_Relationship_To_Object2` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Event_Establishes_Object1_Relationship_To_Object2` (
  `EventID` INT NOT NULL,
  `Object1ID` INT NOT NULL,
  `RelationshipID` INT NOT NULL,
  `Object2ID` INT NOT NULL,
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
-- Table `mydb`.`Event_Establishes_Object_Status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Event_Establishes_Object_Status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Event_Establishes_Object_Status` (
  `EventID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  `StatusID` INT NOT NULL,
  INDEX `fk_Event_Establishes_Object_Status_Object1_idx` (`ObjectID` ASC) VISIBLE,
  PRIMARY KEY (`EventID`),
  INDEX `fk_Event_Establishes_Object_Status_Status1_idx` (`StatusID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Establishes_Object_Status_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Establishes_Object_Status_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Establishes_Object_Status_Status1`
    FOREIGN KEY (`StatusID`)
    REFERENCES `mydb`.`Status` (`StatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event_Includes_Object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Event_Includes_Object` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Event_Includes_Object` (
  `EventID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  INDEX `fk_Event_Has_Object_Events1_idx` (`EventID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Object_Object1_idx` (`ObjectID` ASC) VISIBLE,
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
-- Table `mydb`.`Event_Is_Wish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Event_Is_Wish` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Event_Is_Wish` (
  `EventID` INT NOT NULL,
  `GrantStatus` INT NULL,
  `GrantEventID` INT NULL,
  `Wish Quote` VARCHAR(45) NULL,
  `ObjectID` INT NOT NULL,
  `DescriptionOfObjectInclusion` VARCHAR(255) NULL,
  INDEX `fk_Event_Has_Theme_Wish_Character1_idx` (`ObjectID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Wish_Events1_idx` (`EventID` ASC) VISIBLE,
  INDEX `fk_Event_Is_Wish_Events1_idx` (`GrantEventID` ASC) VISIBLE,
  PRIMARY KEY (`EventID`),
  UNIQUE INDEX `EventID_UNIQUE` (`EventID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Has_Theme_Wish_Character1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Character` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Has_Wish_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Is_Wish_Events1`
    FOREIGN KEY (`GrantEventID`)
    REFERENCES `mydb`.`Events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Events` ;

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
-- Table `mydb`.`Group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Group` (
  `ObjectID` INT NOT NULL,
  `GroupName` VARCHAR(45) NULL,
  `GroupDescription` VARCHAR(45) NULL,
  `Groupcol` VARCHAR(45) NULL,
  PRIMARY KEY (`ObjectID`),
  INDEX `fk_Group_Object1_idx` (`ObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Group_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Location` (
  `ObjectID` INT NOT NULL,
  `LocationName` VARCHAR(45) NULL,
  PRIMARY KEY (`ObjectID`),
  UNIQUE INDEX `ObjectID_UNIQUE` (`ObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Location_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Object` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Object` (
  `ObjectID` INT NOT NULL AUTO_INCREMENT,
  `ObjectName` VARCHAR(45) NULL,
  `ObjectTypeID` INT NULL,
  PRIMARY KEY (`ObjectID`),
  UNIQUE INDEX `ObjectID_UNIQUE` (`ObjectID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Relationship` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Relationship` (
  `RelationshipID` INT NOT NULL,
  `Type` VARCHAR(45) NULL,
  PRIMARY KEY (`RelationshipID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Species`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Species` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Species` (
  `SpeciesID` INT NOT NULL AUTO_INCREMENT,
  `Species` VARCHAR(45) NULL,
  PRIMARY KEY (`SpeciesID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Status` (
  `StatusID` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `StatusDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`StatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StoryObject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`StoryObject` ;

CREATE TABLE IF NOT EXISTS `mydb`.`StoryObject` (
  `ObjectID` INT NOT NULL,
  `StoryObjectName` VARCHAR(45) NULL,
  `StoryObjectDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`ObjectID`),
  UNIQUE INDEX `StoryObjectID_UNIQUE` (`ObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_StoryObject_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Themes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Themes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Themes` (
  `ObjectID` INT NOT NULL,
  `Themes` VARCHAR(45) NULL,
  PRIMARY KEY (`ObjectID`),
  INDEX `fk_Themes_Object1_idx` (`ObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Themes_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `mydb`.`Object` (`ObjectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
