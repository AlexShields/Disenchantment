# %%
#install connector api using the command below.
!pip install mysql-connector-python

# %%
# Import the MySQL Connector/Python
import mysql.connector as connector

# %%
# Establish connection between Python and MySQL database via connector API
connection=connector.connect(host="localhost",
                             user="DisenchantmentAdmin", # use your own
                             password="Bean", # use your own
                            )
print("Connection between MySQL and Python is established.\n")

# %%
# Create cursor object to communicate with entire MySQL database
cursor = connection.cursor()
print("Cursor is created to communicate with the MySQL using Python.\n")

# %%
#Set Checks
cursor.execute("SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;")
cursor.execute("SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;")
cursor.execute("SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';")

# %%
#Name schema for use Name as 'schema'
schema = "TestDisenchantment"

# %%
#Define Drop, create and use commands to reset the default schema

dropSchema = "DROP SCHEMA IF EXISTS `"+schema+"` ;"
createSchema= "CREATE SCHEMA IF NOT EXISTS `"+schema+"` DEFAULT CHARACTER SET utf8mb3 ;"
useSchema = "USE `"+schema+"` ;"


# %%
try:
    cursor.execute(dropSchema)
    cursor.execute(createSchema)
    cursor.execute(useSchema)
    print("Schema "+schema+" is set for use.")
except:
    print("Error setting "+schema+" for use")

# %%
## -----------------------------------------------------
## Table `episode` statements
## -----------------------------------------------------

dropEpisodeTable = "DROP TABLE IF EXISTS `"+schema+"`.`episode` ;"

createEpisodeTable= """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`episode` (
  `EpisodeID` INT NOT NULL AUTO_INCREMENT,
  `Part` INT NULL DEFAULT NULL,
  `Episode` INT NULL DEFAULT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Synopsis` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`EpisodeID`),
  UNIQUE INDEX `EpisodeID_UNIQUE` (`EpisodeID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""


# %%
## -----------------------------------------------------
## #Execute initiate episode as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEpisodeTable)
    cursor.execute(createEpisodeTable)
    print("Table 'episode' initiated.")
except:
    print("Error initiating table 'episode'.")

# %%
## -----------------------------------------------------
## #Table 'event' statements
## -----------------------------------------------------
dropEventTable = """DROP TABLE IF EXISTS `"""+schema+"""`.`event` ;"""

createEventTable = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`event` (
  `EventID` INT NOT NULL AUTO_INCREMENT,
  `EventName` VARCHAR(45) CHARACTER SET 'armscii8' NULL DEFAULT NULL,
  `EpisodeID` INT NOT NULL,
  `EventDescription` VARCHAR(255) NULL DEFAULT NULL,
  `Timestamp` DECIMAL(3,0) NULL DEFAULT NULL,
  PRIMARY KEY (`EventID`),
  INDEX `fk_Event_Episodes_idx` (`EpisodeID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Episodes`
    FOREIGN KEY (`EpisodeID`)
    REFERENCES `"""+schema+"""`.`episode` (`EpisodeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""

# %%
## -----------------------------------------------------
## #Execute initiate event as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventTable)
    cursor.execute(createEventTable)
    print("Table 'event' initiated.")
except:
    print("Error initiating table 'event'.")

# %%
## -----------------------------------------------------
## Table `Object` statements
## -----------------------------------------------------

dropObjectStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`object` ;"""
createObjectStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`object` (
  `ObjectID` INT NOT NULL AUTO_INCREMENT,
  `ObjectTypeID` INT NOT NULL,
  `ObjectReferenceName` VARCHAR(45) NULL DEFAULT NULL,
  `ObjectDescription` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`ObjectID`),
  UNIQUE INDEX `ObjectID_UNIQUE` (`ObjectID` ASC) VISIBLE,
  UNIQUE INDEX `ObjectReferenceName_UNIQUE` (`ObjectReferenceName` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""

# %%
## -----------------------------------------------------
## #Execute initiate object as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectStatement)
    cursor.execute(createObjectStatement)
    print("Table 'event' initiated.")
except:
    print("Error initiating table 'event'.")

# %%
## -----------------------------------------------------
## Table eventincludesobject
## -----------------------------------------------------
dropEventIncludesObjectStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`eventincludesobject` ;"""
createEventIncludesObjectStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`eventincludesobject` (
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
    REFERENCES `"""+schema+"""`.`event` (`EventID`),
  CONSTRAINT `fk_EventIncludesObject_Object1`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `"""+schema+"""`.`object` (`ObjectID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""

# %%
## -----------------------------------------------------
## #Execute initiate eventincludesobject as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventIncludesObjectStatement)
    cursor.execute(createEventIncludesObjectStatement)
    print("Table 'event' initiated.")
except:
    print("Error initiating table 'event'.")

# %%
## -----------------------------------------------------
## Table duration`
## -----------------------------------------------------
dropDurationStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`duration` ;"""
createDurationStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`duration` (
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
    REFERENCES `"""+schema+"""`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_duration_eventincludesobject2`
    FOREIGN KEY (`EndEventIncludesObjectID`)
    REFERENCES `"""+schema+"""`.`eventincludesobject` (`EventIncludesObjectID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""


# %%
## -----------------------------------------------------
## #Execute initiate duration as new table
## -----------------------------------------------------
try:
    cursor.execute(dropDurationStatement)
    cursor.execute(createDurationStatement)
    print("Table 'duration' initiated.")
except:
    print("Error initiating table 'duration'.")

# %%

## -----------------------------------------------------
## Table trait
## -----------------------------------------------------
dropTraitStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`trait` ;"""
createTraitStatement = """CREATE TABLE IF NOT EXISTS '"""+schema+"""`.`trait` (
  `TraitID` INT NOT NULL,
  `TraitName` VARCHAR(45) NULL DEFAULT NULL,
  `TraitUniversalDescription` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`TraitID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""


# %%
## -----------------------------------------------------
## #Execute initiate trait as new table
## -----------------------------------------------------
try:
    cursor.execute(dropDurationStatement)
    cursor.execute(createDurationStatement)
    print("Table 'trait' initiated.")
except:
    print("Error initiating table 'duration'.")

# %%
## -----------------------------------------------------
## Table objecthastrait`
## -----------------------------------------------------
dropObjectHasTraitStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`objecthastrait` ;"""
createObjectHasTraitStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`objecthastrait` (
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
    REFERENCES `"""+schema+"""`.`duration` (`DurationID`),
  CONSTRAINT `fk_ObjectHasTrait_Object2`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `"""+schema+"""`.`object` (`ObjectID`),
  CONSTRAINT `fk_ObjectHasTrait_Trait1`
    FOREIGN KEY (`TraitID`)
    REFERENCES `"""+schema+"""`.`trait` (`TraitID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""

# %%
## -----------------------------------------------------
## #Execute initiate objecthastrait as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectHasTraitStatement)
    cursor.execute(createObjectHasTraitStatement)
    print("Table 'objecthastrait' initiated.")
except:
    print("Error initiating table 'objecthastrait'.")


# %%
## -----------------------------------------------------
## Table eventaddressesobjecthastrait`
## -----------------------------------------------------

dropEventAddressesObjectHasTraitStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`eventaddressesobjecthastrait` ;"""
createEventAddressesObjectHasTraitStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`eventaddressesobjecthastrait` (
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
    REFERENCES `"""+schema+"""`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_Event_Addresses_Object_Has_Trait_Object_Has_Trait1`
    FOREIGN KEY (`ObjectHasTraitID`)
    REFERENCES `"""+schema+"""`.`objecthastrait` (`ObjectHasTraitID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""


# %%
## -----------------------------------------------------
## #Execute initiate eventaddressesobjecthastrait as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventAddressesObjectHasTraitStatement)
    cursor.execute(createEventAddressesObjectHasTraitStatement)
    print("Table 'eventaddressesobjecthastrait' initiated.")
except:
    print("Error initiating table 'eventaddressesobjecthastrait'.")


# %%
## -----------------------------------------------------
## Table relationship
## -----------------------------------------------------
dropRelationshipStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`relationship` ;"""
createRelationshipStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`relationship` (
  `RelationshipID` INT NOT NULL,
  `RelationshipType` VARCHAR(45) NULL DEFAULT NULL,
  `RelationshipTypeUniversalDescription` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`RelationshipID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""


# %%
## -----------------------------------------------------
## #Execute initiate relationship as new table
## -----------------------------------------------------
try:
    cursor.execute(dropRelationshipStatement)
    cursor.execute(createRelationshipStatement)
    print("Table 'relationship' initiated.")
except:
    print("Error initiating table 'relationship'.")


# %%
## -----------------------------------------------------
## Table objecthasrelationshiptoobject
## -----------------------------------------------------
dropObjectHasRelationshipToObjectStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`objecthasrelationshiptoobject` ;"""

createObjectHasRelationshipToObjectStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`objecthasrelationshiptoobject` (
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
    REFERENCES `"""+schema+"""`.`object` (`ObjectID`),
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Object2b`
    FOREIGN KEY (`Object2ID`)
    REFERENCES `"""+schema+"""`.`object` (`ObjectID`),
  CONSTRAINT `fk_Event_Establishes_Object_Relationship_To_Object_Rel1b`
    FOREIGN KEY (`RelationshipID`)
    REFERENCES `"""+schema+"""`.`relationship` (`RelationshipID`),
  CONSTRAINT `fk_Object_Has_Relationship_To_Object_Duration1b`
    FOREIGN KEY (`DurationID`)
    REFERENCES `"""+schema+"""`.`duration` (`DurationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""


# %%
## -----------------------------------------------------
## #Execute initiate objecthasrelationshiptoobject as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectHasRelationshipToObjectStatement)
    cursor.execute(createObjectHasRelationshipToObjectStatement)
    print("Table 'objecthasrelationshiptoobject' initiated.")
except:
    print("Error initiating table 'objecthasrelationshiptoobject'.")

# %%
## -----------------------------------------------------
## Table objectname
## -----------------------------------------------------
dropObjectNameStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`objectname` ;"""

createObjectNameStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`objectname` (
  `ObjectNameID` INT NOT NULL,
  `ObjectName` VARCHAR(45) NULL DEFAULT NULL,
  `NameType` VARCHAR(45) NULL DEFAULT NULL,
  `NamePriority` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ObjectNameID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""

# %%
## -----------------------------------------------------
## #Execute initiate objectname as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectNameStatement)
    cursor.execute(createObjectNameStatement)
    print("Table 'objectname' initiated.")
except:
    print("Error initiating table 'objectname'.")

# %%
## -----------------------------------------------------
## Table objecthasobjectname
## -----------------------------------------------------
dropObjectHasObjectNameStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`objecthasobjectname` ;"""

createObjectHasObjectNameStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`objecthasobjectname` (
  `ObjectHasNameID` INT NOT NULL,
  `ObjectID` INT NOT NULL,
  `ObjectNameID` INT NOT NULL,
  PRIMARY KEY (`ObjectHasNameID`),
  INDEX `fk_Object_Has_Name_Object1_idx` (`ObjectID` ASC) VISIBLE,
  INDEX `fk_Object_Has_ObjectName_ObjectName1_idx` (`ObjectNameID` ASC) VISIBLE,
  CONSTRAINT `fk_Object_Has_Name_Object1a`
    FOREIGN KEY (`ObjectID`)
    REFERENCES `"""+schema+"""`.`object` (`ObjectID`),
  CONSTRAINT `fk_Object_Has_ObjectName_ObjectName1a`
    FOREIGN KEY (`ObjectNameID`)
    REFERENCES `"""+schema+"""`.`objectname` (`ObjectNameID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""


# %%
## -----------------------------------------------------
## #Execute initiate objectname as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectHasObjectNameStatement)
    cursor.execute(createObjectHasObjectNameStatement)
    print("Table 'objecthasobjectname' initiated.")
except:
    print("Error initiating table 'objecthasobjectname'.")

# %%
## -----------------------------------------------------
## #Execute initiate objecthasrelationshiptoobject as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectHasRelationshipToObjectStatement)
    cursor.execute(createObjectHasRelationshipToObjectStatement)
    print("Table 'objecthasrelationshiptoobject' initiated.")
except:
    print("Error initiating table 'objecthasrelationshiptoobject'.")

# %%
## -----------------------------------------------------
## Table eventhasexampleofobjectname
## -----------------------------------------------------
dropEventHasExampleOfObjectNameStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`eventhasexampleofobjectname` ;"""

createEventHasExampleOfObjectNameStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`eventhasexampleofobjectname` (
  `EventHasExampleOfObjectNameID` INT NOT NULL AUTO_INCREMENT,
  `ObjectHasNameID` INT NOT NULL,
  `EvidenceDescription` VARCHAR(255) NULL DEFAULT NULL,
  `EventIncludesObjectID` INT NOT NULL,
  PRIMARY KEY (`EventHasExampleOfObjectNameID`),
  INDEX `fk_Event_Has_Example_Of_ObjectName_Object_Has_ObjectName1_idx` (`ObjectHasNameID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Example_Of_ObjectName_Event_Includes_Object1_idx` (`EventIncludesObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Has_Example_Of_ObjectName_Event_Includes_Object1a`
    FOREIGN KEY (`EventIncludesObjectID`)
    REFERENCES `"""+schema+"""`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_Event_Has_Example_Of_ObjectName_Object_Has_ObjectName1a`
    FOREIGN KEY (`ObjectHasNameID`)
    REFERENCES `"""+schema+"""`.`objecthasobjectname` (`ObjectHasNameID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""

# %%
## -----------------------------------------------------
## #Execute initiate eventhasexampleofobjectname as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventHasExampleOfObjectNameStatement)
    cursor.execute(createEventHasExampleOfObjectNameStatement)
    print("Table 'eventhasexampleofobjectname' initiated.")
except:
    print("Error initiating table 'eventhasexampleofobjectname'.")

# %%
## -----------------------------------------------------
## Table eventhasothernotes`
## -----------------------------------------------------
dropEventHasOtherNotesStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`eventhasothernotes` ;"""

createEventHasOtherNotesStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`eventhasothernotes` (
  `EventHasOtherNotesID` INT NOT NULL AUTO_INCREMENT,
  `EventID` INT NOT NULL,
  `Note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`EventHasOtherNotesID`),
  INDEX `fk_table1_Events1_idx` (`EventID` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Events1`
    FOREIGN KEY (`EventID`)
    REFERENCES `"""+schema+"""`.`event` (`EventID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""

# %%
## -----------------------------------------------------
## #Execute initiate eventhasothernotes as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventHasOtherNotesStatement)
    cursor.execute(createEventHasOtherNotesStatement)
    print("Table 'eventhasothernotes' initiated.")
except:
    print("Error initiating table 'eventhasothernotes'.")

# %%
## -----------------------------------------------------
## Table wish
## -----------------------------------------------------
dropWishStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`wish` ;"""

createWishStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`wish` (
  `WishID` INT NOT NULL AUTO_INCREMENT,
  `WishQuote` VARCHAR(255) NULL DEFAULT NULL,
  `Description` VARCHAR(255) NULL DEFAULT NULL,
  `CurrentStatusDescription` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`WishID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;"""

# %%
## -----------------------------------------------------
## #Execute initiate wish as new table
## -----------------------------------------------------
try:
    cursor.execute(dropWishStatement)
    cursor.execute(createWishStatement)
    print("Table 'wish' initiated.")
except:
    print("Error initiating table 'wish'.")

# %%
## -----------------------------------------------------
## Table eventincludesobjecthaswish
## -----------------------------------------------------

dropEventIncludesObjectHasWishStatement = """DROP TABLE IF EXISTS `"""+schema+"""`.`eventincludesobjecthaswish` ;"""

createEventIncludesObjectHasWishStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`eventincludesobjecthaswish` (
  `EventHasWishID` INT NOT NULL AUTO_INCREMENT,
  `WishID` INT NOT NULL,
  `WishGrantDeny` VARCHAR(5) NULL DEFAULT NULL,
  `EventIncludesObjectID` INT NOT NULL,
  `EventIncludesObjectHasWishDescription` VARCHAR(255) NULL,
  PRIMARY KEY (`EventHasWishID`),
  INDEX `fk_Event_Has_Wish_Wish1_idx` (`WishID` ASC) VISIBLE,
  INDEX `fk_Event_Has_Wish_Event_Includes_Object1_idx` (`EventIncludesObjectID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Has_Wish_Event_Includes_Object1`
    FOREIGN KEY (`EventIncludesObjectID`)
    REFERENCES `"""+schema+"""`.`eventincludesobject` (`EventIncludesObjectID`),
  CONSTRAINT `fk_Event_Has_Wish_Wish1`
    FOREIGN KEY (`WishID`)
    REFERENCES `"""+schema+"""`.`wish` (`WishID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `"""+schema+"""` ;"""

# %%
## -----------------------------------------------------
## #Execute initiate eventincludesobjecthaswish as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventIncludesObjectHasWishStatement)
    cursor.execute(createEventIncludesObjectHasWishStatement)
    print("Table 'eventincludesobjecthaswish' initiated.")
except:
    print("Error initiating table 'eventincludesobjecthaswish'.")

# %%
## -----------------------------------------------------
## Placeholder table for view `"""+schema+"""`.`objecttimeline`
## -----------------------------------------------------
createObjectTimelineViewStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`objecttimeline` (`ObjectReferenceName` INT, `EventName` INT, `InclusionDescription` INT, `RelationshipType` INT, `EventAddressesObjectRelationshipDescription` INT, `Object2ReferenceName` INT, `ObjectName` INT, `NameType` INT, `EvidenceDescription` INT, `EventIncludesObjectHasWishDescription` INT);"""

# %%
## -----------------------------------------------------
## #Execute initiate objecttimeline as new view
## -----------------------------------------------------
try:
    cursor.execute(createObjectTimelineViewStatement)
    print("View 'objecttimeline' initiated.")
except:
    print("Error initiating table 'objecttimeline'.")

# %%
## -----------------------------------------------------
## Placeholder table for view `"""+schema+"""`.`eventview`
## -----------------------------------------------------
createEventViewStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`eventview` (`EventName` INT, `InclusionDescription` INT);"""

# %%
## -----------------------------------------------------
## #Execute initiate eventview as new view
## -----------------------------------------------------
try:
    cursor.execute(createEventViewStatement)
    print("View 'eventview' initiated.")
except:
    print("Error initiating table 'eventview'.")

# %%
## -----------------------------------------------------
## procedure AddEndDuration
## -----------------------------------------------------

createAddEndDurationProcedureStatement = """

USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEndDuration`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEndDuration`(
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

"""

# %%

## -----------------------------------------------------
## procedure AddEpisode
## -----------------------------------------------------

createAddEpisodeStatement = """

USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEpisode`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEpisode`(
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
"""

# %%

## -----------------------------------------------------
## procedure AddEvent
## -----------------------------------------------------

createAddEventStatement = """

USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEvent`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEvent`(
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
"""

# %%

## -----------------------------------------------------
## procedure AddEventAddressesObjectHasTrait
## -----------------------------------------------------

createAddEventAddressesObjectHasTrait = """

USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEventAddressesObjectHasTrait`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEventAddressesObjectHasTrait`(
    IN NewObjectHasTraitID INT,
    IN NewEventAddressesObjectHasTraitDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    INSERT INTO `"""+schema+"""`.`eventaddressesobjecthastrait` (ObjectHasTraitID, EventAddressesObjectHasTraitDescription, EventIncludesObjectID)
    VALUES (NewObjectHasTraitID, NewEventAddressesObjectHasTraitDescription, NewEventIncludesObjectID);
END$$

DELIMITER ;
"""

# %%
## -----------------------------------------------------
## procedure AddEventAddressesObjectRelationship
## -----------------------------------------------------
createAddEventAddressesObjectRelationship = """USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEventAddressesObjectRelationship`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEventAddressesObjectRelationship`(
    IN NewObjectHasRelationshipToObjectID INT,
    IN NewEventAddressesObjectRelationshipDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    INSERT INTO `"""+schema+"""`.`eventaddressesobjectrelationship` (ObjectHasRelationshipToObjectID, EventAddressesObjectRelationshipDescription, EventIncludesObjectID)
    VALUES (NewObjectHasRelationshipToObjectID, NewEventAddressesObjectRelationshipDescription, NewEventIncludesObjectID);
END$$

DELIMITER ;
"""

# %%
## -----------------------------------------------------
## procedure AddEventHasExampleOfObjectName
## -----------------------------------------------------
createAddEventHasExampleOfObjectName = """
USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEventHasExampleOfObjectName`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEventHasExampleOfObjectName`(
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
"""

# %%
## -----------------------------------------------------
## procedure AddEventHasOtherNotes
## -----------------------------------------------------
createAddEventHasOtherNotes = """
USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEventHasOtherNotes`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEventHasOtherNotes`(
    IN NewEventID INT,
    IN NewNote VARCHAR(255)
)
BEGIN
    INSERT INTO `"""+schema+"""`.`eventhasothernotes` (EventID, Note)
    VALUES (NewEventID, NewNote);
END$$

DELIMITER ;
"""

# %%
## -----------------------------------------------------
## procedure AddEventHasWish
## -----------------------------------------------------
createAddEventHasWish = """
USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEventHasWish`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEventHasWish`(
    IN WishIDValue INT,
    IN WishGrantDenyValue VARCHAR(5),
    IN EventIncludesObjectIDValue INT
)
BEGIN
    INSERT INTO `"""+schema+"""`.`eventincludesobjecthaswish` (WishID, WishGrantDeny, EventIncludesObjectID)
    VALUES (WishIDValue, WishGrantDenyValue, EventIncludesObjectIDValue);
END$$

DELIMITER ;
"""

# %%
## -----------------------------------------------------
## procedure AddEventIncludesObject
## -----------------------------------------------------
createAddEventIncludesObject = """
USE `"""+schema+"""`;
DROP procedure IF EXISTS `"""+schema+"""`.`AddEventIncludesObject`;

DELIMITER $$
USE `"""+schema+"""`$$
CREATE DEFINER=`CapstoneAuthor`@`%` PROCEDURE `AddEventIncludesObject`(
    IN NewEventID INT,
    IN NewObjectID INT,
    IN NewInclusionDescription VARCHAR(45),
    IN NewSequentialID DECIMAL(3,0)
)
BEGIN
    INSERT INTO `"""+schema+"""`.`eventincludesobject` (EventID, ObjectID, InclusionDescription, SequentialID)
    VALUES (NewEventID, NewObjectID, NewInclusionDescription, NewSequentialID);
END$$

DELIMITER ;
"""


