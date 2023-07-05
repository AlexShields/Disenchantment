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
                             raise_on_warnings=True
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
schema = "testdisenchantment"

# %%
#Define Drop, create and use commands to reset the default schema

dropSchema = "DROP SCHEMA IF EXISTS `"+schema+"` ;"
createSchema= "CREATE SCHEMA IF NOT EXISTS `"+schema+"` ;"
useSchema = "USE `"+schema+"` ;"


# %%
try:
    cursor.execute(dropSchema)
    print("existing database dropped")
except:
    print("no existing database")
try:
    cursor.execute(createSchema)
except:
    print("fail to create schema")
try:
    cursor.execute(useSchema)
    print("Schema "+schema+" is set for use.")
except:
    print("error setting database for use")

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
DEFAULT CHARACTER SET = utf8mb4;"""


# %%
## -----------------------------------------------------
## #Execute initiate episode as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEpisodeTable)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate event as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventTable)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate object as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate eventincludesobject as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventIncludesObjectStatement)
except:
    print("no existing table")
try:
    cursor.execute(createEventIncludesObjectStatement)
    print("Table 'eventincludesobject' initiated.")
except:
    print("Error initiating table 'eventincludesobject'.")

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
DEFAULT CHARACTER SET = utf8mb4;"""


# %%
## -----------------------------------------------------
## #Execute initiate duration as new table
## -----------------------------------------------------
try:
    cursor.execute(dropDurationStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""


# %%
## -----------------------------------------------------
## #Execute initiate trait as new table
## -----------------------------------------------------
try:
    cursor.execute(dropDurationStatement)
except:
    print("no existing table")
try:
    cursor.execute(createDurationStatement)
    print("Table 'trait' initiated.")
except:
    print("Error initiating table 'trait'.")

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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate objecthastrait as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectHasTraitStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""


# %%
## -----------------------------------------------------
## #Execute initiate eventaddressesobjecthastrait as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventAddressesObjectHasTraitStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""


# %%
## -----------------------------------------------------
## #Execute initiate relationship as new table
## -----------------------------------------------------
try:
    cursor.execute(dropRelationshipStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""


# %%
## -----------------------------------------------------
## #Execute initiate objecthasrelationshiptoobject as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectHasRelationshipToObjectStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate objectname as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectNameStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""


# %%
## -----------------------------------------------------
## #Execute initiate objectname as new table
## -----------------------------------------------------
try:
    cursor.execute(dropObjectHasObjectNameStatement)
except:
    print("no existing table")
try:
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
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate eventhasexampleofobjectname as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventHasExampleOfObjectNameStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate eventhasothernotes as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventHasOtherNotesStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate wish as new table
## -----------------------------------------------------
try:
    cursor.execute(dropWishStatement)
except:
    print("no existing table")
try:
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
DEFAULT CHARACTER SET = utf8mb4;"""

# %%
## -----------------------------------------------------
## #Execute initiate eventincludesobjecthaswish as new table
## -----------------------------------------------------
try:
    cursor.execute(dropEventIncludesObjectHasWishStatement)
except:
    print("no existing table")
try:
    cursor.execute(createEventIncludesObjectHasWishStatement)
    print("Table 'eventincludesobjecthaswish' initiated.")
except:
    print("Error initiating table 'eventincludesobjecthaswish'.")

# %%
## -----------------------------------------------------
## Placeholder table for view `"""+schema+"""`.`objecttimeline`
## -----------------------------------------------------
createObjectTimelineTempViewStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`objecttimeline` (`ObjectReferenceName` INT, `EventName` INT, `InclusionDescription` INT, `RelationshipType` INT, `EventAddressesObjectRelationshipDescription` INT, `Object2ReferenceName` INT, `ObjectName` INT, `NameType` INT, `EvidenceDescription` INT, `EventIncludesObjectHasWishDescription` INT);"""

# %%
## -----------------------------------------------------
## #Execute initiate objecttimeline as new tempview 
## -----------------------------------------------------
try:
    cursor.execute(createObjectTimelineTempViewStatement)
    print("Temp View for 'objecttimeline' initiated.")
except:
    print("Error initiating temp view of  'objecttimeline'.")

# %%
## -----------------------------------------------------
## Placeholder table for view `"""+schema+"""`.`eventview`
## -----------------------------------------------------
createEventTempViewStatement = """CREATE TABLE IF NOT EXISTS `"""+schema+"""`.`eventview` (`EventName` INT, `InclusionDescription` INT);"""

# %%
## -----------------------------------------------------
## #Execute initiate eventview as new temp view
## -----------------------------------------------------
try:
    cursor.execute(createEventTempViewStatement)
    print("View 'eventview' initiated.")
except:
    print("Error initiating temp view 'eventview'.")

# %%
## -----------------------------------------------------
## procedures list
## -----------------------------------------------------
procedures = []

# %%
SetSchemaForUse = """USE `"""+schema+"""`;"""


# %%
## -----------------------------------------------------
## procedure AddEndDuration
## -----------------------------------------------------
# Drop procedure if it exists
DropAddEndDurationQuery = "DROP PROCEDURE IF EXISTS `" + schema + "`.`AddEndDuration`"
try:
    cursor.execute(DropAddEndDurationQuery)
    print("Dropped AddEndDuration procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEndDuration procedure: {error}")

# Create the AddEndDuration procedure
CreateAddEndDurationQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEndDuration`(
    IN NewDurationID INT,
    IN NewEndEventDescription VARCHAR(255),
    IN NewEndEventIncludesObjectID INT
)
BEGIN
    UPDATE duration
    SET EndEventDescription = IFNULL(NewEndEventDescription, EndEventDescription),
        EndEventIncludesObjectID = IFNULL(NewEndEventIncludesObjectID, EndEventIncludesObjectID)
    WHERE DurationID = NewDurationID AND (NewEndEventDescription IS NOT NULL OR NewEndEventIncludesObjectID IS NOT NULL);
END
"""
try:
    cursor.execute(CreateAddEndDurationQuery)
    print("Created AddEndDuration procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEndDuration procedure: {error}")

# %%

## -----------------------------------------------------
## procedure AddEpisode
## -----------------------------------------------------

# Drop procedure if it exists
# Drop procedure if it exists
DropAddEpisodeQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddEpisode`"
try:
    cursor.execute(DropAddEpisodeQuery)
    print("Dropped AddEpisode procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEpisode procedure: {error}")

# Create the AddEpisode procedure
CreateAddEpisodeQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEpisode`(
    IN NewPart INT,
    IN NewEpisode INT,
    IN NewName VARCHAR(45),
    IN NewSynopsis VARCHAR(255)
)
BEGIN
    INSERT INTO episode (Part, Episode, Name, Synopsis)
    VALUES (NewPart, NewEpisode, NewName, NewSynopsis);
END
"""
try:
    cursor.execute(CreateAddEpisodeQuery)
    print("Created AddEpisode procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEpisode procedure: {error}")

# %%

## -----------------------------------------------------
## procedure AddEvent
## -----------------------------------------------------
# Drop procedure if it exists
DropAddEventQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddEvent`"
try:
    cursor.execute(DropAddEventQuery)
    print("Dropped AddEvent procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEvent procedure: {error}")

# Create the AddEvent procedure
CreateAddEventQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEvent`(
    IN NewEventName VARCHAR(45),
    IN NewEpisodeID INT,
    IN NewEventDescription VARCHAR(255),
    IN NewTimestamp DECIMAL(3, 0)
)
BEGIN
    INSERT INTO event (EventName, EpisodeID, EventDescription, Timestamp)
    VALUES (NewEventName, NewEpisodeID, NewEventDescription, NewTimestamp);
END
"""
try:
    cursor.execute(CreateAddEventQuery)
    print("Created AddEvent procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEvent procedure: {error}")

# %%

## -----------------------------------------------------
## procedure AddEventAddressesObjectHasTrait
## -----------------------------------------------------
# Drop procedure if it exists
DropAddEventAddressesObjectHasTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddEventAddressesObjectHasTrait`"
try:
    cursor.execute(DropAddEventAddressesObjectHasTraitQuery)
    print("Dropped AddEventAddressesObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEventAddressesObjectHasTrait procedure: {error}")

# Create the AddEventAddressesObjectHasTrait procedure
CreateAddEventAddressesObjectHasTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEventAddressesObjectHasTrait`(
    IN NewObjectHasTraitID INT,
    IN NewEventAddressesObjectHasTraitDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    INSERT INTO `{schema}`.`eventaddressesobjecthastrait` (ObjectHasTraitID, EventAddressesObjectHasTraitDescription, EventIncludesObjectID)
    VALUES (NewObjectHasTraitID, NewEventAddressesObjectHasTraitDescription, NewEventIncludesObjectID);
END
"""
try:
    cursor.execute(CreateAddEventAddressesObjectHasTraitQuery)
    print("Created AddEventAddressesObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEventAddressesObjectHasTrait procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddEventAddressesObjectRelationship
## -----------------------------------------------------
# Drop procedure if it exists
DropAddEventAddressesObjectRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddEventAddressesObjectRelationship`"
try:
    cursor.execute(DropAddEventAddressesObjectRelationshipQuery)
    print("Dropped AddEventAddressesObjectRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEventAddressesObjectRelationship procedure: {error}")

# Create the AddEventAddressesObjectRelationship procedure
CreateAddEventAddressesObjectRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEventAddressesObjectRelationship`(
    IN NewObjectHasRelationshipToObjectID INT,
    IN NewEventAddressesObjectRelationshipDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    INSERT INTO `{schema}`.`eventaddressesobjectrelationship` (ObjectHasRelationshipToObjectID, EventAddressesObjectRelationshipDescription, EventIncludesObjectID)
    VALUES (NewObjectHasRelationshipToObjectID, NewEventAddressesObjectRelationshipDescription, NewEventIncludesObjectID);
END
"""
try:
    cursor.execute(CreateAddEventAddressesObjectRelationshipQuery)
    print("Created AddEventAddressesObjectRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEventAddressesObjectRelationship procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddEventHasExampleOfObjectName
## -----------------------------------------------------
# Drop procedure if it exists
DropAddEventHasExampleOfObjectNameQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddEventHasExampleOfObjectName`"
try:
    cursor.execute(DropAddEventHasExampleOfObjectNameQuery)
    print("Dropped AddEventHasExampleOfObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEventHasExampleOfObjectName procedure: {error}")

# Create the AddEventHasExampleOfObjectName procedure
CreateAddEventHasExampleOfObjectNameQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEventHasExampleOfObjectName`(
    IN NewEventHasExampleOfObjectNameID INT,
    IN NewObjectHasNameID INT,
    IN NewEvidenceDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    INSERT INTO `{schema}`.`eventhasexampleofobjectname` (EventHasExampleOfObjectNameID, ObjectHasNameID, EvidenceDescription, EventIncludesObjectID)
    VALUES (NewEventHasExampleOfObjectNameID, NewObjectHasNameID, NewEvidenceDescription, NewEventIncludesObjectID);
END
"""
try:
    cursor.execute(CreateAddEventHasExampleOfObjectNameQuery)
    print("Created AddEventHasExampleOfObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEventHasExampleOfObjectName procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddEventHasOtherNotes
## -----------------------------------------------------
# Drop procedure if it exists
DropAddEventHasOtherNotesQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddEventHasOtherNotes`"
try:
    cursor.execute(DropAddEventHasOtherNotesQuery)
    print("Dropped AddEventHasOtherNotes procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEventHasOtherNotes procedure: {error}")

# Create the AddEventHasOtherNotes procedure
CreateAddEventHasOtherNotesQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEventHasOtherNotes`(
    IN NewEventID INT,
    IN NewNote VARCHAR(255)
)
BEGIN
    INSERT INTO `{schema}`.`eventhasothernotes` (EventID, Note)
    VALUES (NewEventID, NewNote);
END
"""
try:
    cursor.execute(CreateAddEventHasOtherNotesQuery)
    print("Created AddEventHasOtherNotes procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEventHasOtherNotes procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddEventHasWish
## -----------------------------------------------------
# Drop procedure if it exists
DropAddEventHasWishQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddEventHasWish`"
try:
    cursor.execute(DropAddEventHasWishQuery)
    print("Dropped AddEventHasWish procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEventHasWish procedure: {error}")

# Create the AddEventHasWish procedure
CreateAddEventHasWishQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEventHasWish`(
    IN WishIDValue INT,
    IN WishGrantDenyValue VARCHAR(5),
    IN EventIncludesObjectIDValue INT
)
BEGIN
    INSERT INTO `{schema}`.`eventincludesobjecthaswish` (WishID, WishGrantDeny, EventIncludesObjectID)
    VALUES (WishIDValue, WishGrantDenyValue, EventIncludesObjectIDValue);
END
"""
try:
    cursor.execute(CreateAddEventHasWishQuery)
    print("Created AddEventHasWish procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEventHasWish procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddEventIncludesObject
## -----------------------------------------------------

# Drop procedure if it exists
DropAddEventIncludesObjectQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddEventIncludesObject`"
try:
    cursor.execute(DropAddEventIncludesObjectQuery)
    print("Dropped AddEventIncludesObject procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddEventIncludesObject procedure: {error}")

# Create the AddEventIncludesObject procedure
CreateAddEventIncludesObjectQuery = f"""
CREATE PROCEDURE `{schema}`.`AddEventIncludesObject`(
    IN NewEventID INT,
    IN NewObjectID INT,
    IN NewInclusionDescription VARCHAR(45),
    IN NewSequentialID DECIMAL(3, 0)
)
BEGIN
    INSERT INTO `{schema}`.`eventincludesobject` (EventID, ObjectID, InclusionDescription, SequentialID)
    VALUES (NewEventID, NewObjectID, NewInclusionDescription, NewSequentialID);
END
"""
try:
    cursor.execute(CreateAddEventIncludesObjectQuery)
    print("Created AddEventIncludesObject procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddEventIncludesObject procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddObject
## -----------------------------------------------------
# Drop procedure if it exists
DropAddObjectQuery = "DROP PROCEDURE IF EXISTS `{}`.`AddObject`".format(schema)
try:
    cursor.execute(DropAddObjectQuery)
    print("Dropped AddObject procedure successfully.")
except connector.Error as error:
    print("Error dropping AddObject procedure: {}".format(error))

# Create the AddObject procedure
CreateAddObjectQuery = """
CREATE PROCEDURE `{}`.`AddObject`(
    IN NewObjectID INT,
    IN NewObjectTypeID INT,
    IN NewObjectReferenceName VARCHAR(45),
    IN NewObjectDescription VARCHAR(255)
)
BEGIN
    INSERT INTO `{}`.`object` (ObjectID, ObjectTypeID, ObjectReferenceName, ObjectDescription)
    VALUES (NewObjectID, NewObjectTypeID, NewObjectReferenceName, NewObjectDescription);
END
""".format(schema, schema)
try:
    cursor.execute(CreateAddObjectQuery)
    print("Created AddObject procedure successfully.")
except connector.Error as error:
    print("Error creating AddObject procedure: {}".format(error))


# %%
## -----------------------------------------------------
## procedure AddObjectHasObjectName
## ----------------------------------------------------
# Drop procedure if it exists
DropAddObjectHasObjectNameQuery = "DROP PROCEDURE IF EXISTS `{}`.`AddObjectHasObjectName`".format(schema)
try:
    cursor.execute(DropAddObjectHasObjectNameQuery)
    print("Dropped AddObjectHasObjectName procedure successfully.")
except connector.Error as error:
    print("Error dropping AddObjectHasObjectName procedure: {}".format(error))

# Create the AddObjectHasObjectName procedure
CreateAddObjectHasObjectNameQuery = """
CREATE PROCEDURE `{}`.`AddObjectHasObjectName`(
    IN NewObjectHasNameID INT,
    IN NewObjectID INT,
    IN NewObjectNameID INT
)
BEGIN
    INSERT INTO `{}`.`objecthasobjectname` (ObjectHasNameID, ObjectID, ObjectNameID)
    VALUES (NewObjectHasNameID, NewObjectID, NewObjectNameID);
END
""".format(schema, schema)
try:
    cursor.execute(CreateAddObjectHasObjectNameQuery)
    print("Created AddObjectHasObjectName procedure successfully.")
except connector.Error as error:
    print("Error creating AddObjectHasObjectName procedure: {}".format(error))


# %%
## -----------------------------------------------------
## procedure AddObjectHasRelationship
## -----------------------------------------------------

# Drop procedure if it exists
DropAddObjectHasRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddObjectHasRelationship`"
try:
    cursor.execute(DropAddObjectHasRelationshipQuery)
    print("Dropped AddObjectHasRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddObjectHasRelationship procedure: {error}")

# Create the AddObjectHasRelationship procedure
CreateAddObjectHasRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`AddObjectHasRelationship`(
    IN ObjectHasRelationshipToObjectIDValue INT,
    IN Object1IDValue INT,
    IN RelationshipIDValue INT,
    IN Object2IDValue INT,
    IN ExplanationValue VARCHAR(45),
    IN DurationIDValue INT,
    IN RelationshipPriorityIDValue DECIMAL(2, 0),
    IN Object2InheritsTraitsFromObject1Value INT
)
BEGIN
    INSERT INTO `{schema}`.`objecthasrelationshiptoobject` (ObjectHasRelationshipToObjectID, Object1ID, RelationshipID, Object2ID, Explanation, DurationID, RelationshipPriorityID, Object2InheritsTraitsFromObject1)
    VALUES (ObjectHasRelationshipToObjectIDValue, Object1IDValue, RelationshipIDValue, Object2IDValue, ExplanationValue, DurationIDValue, RelationshipPriorityIDValue, Object2InheritsTraitsFromObject1Value);
END
"""
try:
    cursor.execute(CreateAddObjectHasRelationshipQuery)
    print("Created AddObjectHasRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddObjectHasRelationship procedure: {error}")


# %%

## -----------------------------------------------------
## procedure AddObjectHasTrait
## -----------------------------------------------------

# Drop procedure if it exists
DropAddObjectHasTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddObjectHasTrait`"
try:
    cursor.execute(DropAddObjectHasTraitQuery)
    print("Dropped AddObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddObjectHasTrait procedure: {error}")

# Create the AddObjectHasTrait procedure
CreateAddObjectHasTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`AddObjectHasTrait`(
    IN NewObjectHasTraitID INT,
    IN NewObjectID INT,
    IN NewTraitID INT,
    IN NewDurationID INT,
    IN NewObjectHasTraitDescription VARCHAR(255),
    IN NewTraitPriority DECIMAL(2, 0)
)
BEGIN
    INSERT INTO `{schema}`.`objecthastrait` (ObjectHasTraitID, ObjectID, TraitID, DurationID, ObjectHasTraitDescription, TraitPriority)
    VALUES (NewObjectHasTraitID, NewObjectID, NewTraitID, NewDurationID, NewObjectHasTraitDescription, NewTraitPriority);
END
"""
try:
    cursor.execute(CreateAddObjectHasTraitQuery)
    print("Created AddObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddObjectHasTrait procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddObjectName
## -----------------------------------------------------

# Drop procedure if it exists
DropAddObjectNameQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddObjectName`"
try:
    cursor.execute(DropAddObjectNameQuery)
    print("Dropped AddObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddObjectName procedure: {error}")

# Create the AddObjectName procedure
CreateAddObjectNameQuery = f"""
CREATE PROCEDURE `{schema}`.`AddObjectName`(
    IN ObjectNameIDValue INT,
    IN ObjectNameValue VARCHAR(45),
    IN NameTypeValue VARCHAR(45),
    IN NamePriorityValue VARCHAR(45)
)
BEGIN
    INSERT INTO `{schema}`.`objectname` (ObjectNameID, ObjectName, NameType, NamePriority)
    VALUES (ObjectNameIDValue, ObjectNameValue, NameTypeValue, NamePriorityValue);
END
"""
try:
    cursor.execute(CreateAddObjectNameQuery)
    print("Created AddObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddObjectName procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddRelationship
## -----------------------------------------------------

# Drop procedure if it exists
DropAddRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddRelationship`"
try:
    cursor.execute(DropAddRelationshipQuery)
    print("Dropped AddRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddRelationship procedure: {error}")

# Create the AddRelationship procedure
CreateAddRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`AddRelationship`(
    IN NewRelationshipID INT,
    IN NewRelationshipType VARCHAR(45),
    IN NewRelationshipTypeUniversalDescription VARCHAR(255)
)
BEGIN
    INSERT INTO `{schema}`.`relationship` (RelationshipID, RelationshipType, RelationshipTypeUniversalDescription)
    VALUES (NewRelationshipID, NewRelationshipType, NewRelationshipTypeUniversalDescription);
END
"""
try:
    cursor.execute(CreateAddRelationshipQuery)
    print("Created AddRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddRelationship procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddStartDuration
## -----------------------------------------------------

# Drop procedure if it exists
DropAddStartDurationQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddStartDuration`"
try:
    cursor.execute(DropAddStartDurationQuery)
    print("Dropped AddStartDuration procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddStartDuration procedure: {error}")

# Create the AddStartDuration procedure
CreateAddStartDurationQuery = f"""
CREATE PROCEDURE `{schema}`.`AddStartDuration`(
    IN NewStartEventIncludesObjectID INT,
    IN NewStartEventDescription VARCHAR(255)
)
BEGIN
    INSERT INTO `{schema}`.`duration` (StartEventDescription, StartEventIncludesObjectID)
    VALUES (NewStartEventDescription, NewStartEventIncludesObjectID);
END
"""
try:
    cursor.execute(CreateAddStartDurationQuery)
    print("Created AddStartDuration procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddStartDuration procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddTrait
## -----------------------------------------------------

# Drop procedure if it exists
DropAddTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddTrait`"
try:
    cursor.execute(DropAddTraitQuery)
    print("Dropped AddTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddTrait procedure: {error}")

# Create the AddTrait procedure
CreateAddTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`AddTrait`(
    IN NewTraitID INT,
    IN NewTraitName VARCHAR(45),
    IN NewTraitUniversalDescription VARCHAR(45)
)
BEGIN
    INSERT INTO `{schema}`.`trait` (TraitID, TraitName, TraitUniversalDescription)
    VALUES (NewTraitID, NewTraitName, NewTraitUniversalDescription);
END
"""
try:
    cursor.execute(CreateAddTraitQuery)
    print("Created AddTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddTrait procedure: {error}")


# %%
## -----------------------------------------------------
## procedure AddWish
## -----------------------------------------------------

# Drop procedure if it exists
DropAddWishQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`AddWish`"
try:
    cursor.execute(DropAddWishQuery)
    print("Dropped AddWish procedure successfully.")
except connector.Error as error:
    print(f"Error dropping AddWish procedure: {error}")

# Create the AddWish procedure
CreateAddWishQuery = f"""
CREATE PROCEDURE `{schema}`.`AddWish`(
    IN WishQuoteValue VARCHAR(255),
    IN DescriptionValue VARCHAR(255),
    IN CurrentStatusDescriptionValue VARCHAR(255)
)
BEGIN
    INSERT INTO `{schema}`.`wish` (WishQuote, Description, CurrentStatusDescription)
    VALUES (WishQuoteValue, DescriptionValue, CurrentStatusDescriptionValue);
END
"""
try:
    cursor.execute(CreateAddWishQuery)
    print("Created AddWish procedure successfully.")
except connector.Error as error:
    print(f"Error creating AddWish procedure: {error}")

# %%
## -----------------------------------------------------
## procedure DeleteDuration
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteDurationQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteDuration`"
try:
    cursor.execute(DropDeleteDurationQuery)
    print("Dropped DeleteDuration procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteDuration procedure: {error}")

# Create the DeleteDuration procedure
CreateDeleteDurationQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteDuration`(
    IN DurationIDToDelete INT
)
BEGIN
    DELETE FROM `{schema}`.`duration`
    WHERE DurationID = DurationIDToDelete;
END
"""
try:
    cursor.execute(CreateDeleteDurationQuery)
    print("Created DeleteDuration procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteDuration procedure: {error}")


# %%
## -----------------------------------------------------
## procedure DeleteEpisode
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteEpisodeQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteEpisode`"
try:
    cursor.execute(DropDeleteEpisodeQuery)
    print("Dropped DeleteEpisode procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteEpisode procedure: {error}")

# Create the DeleteEpisode procedure
CreateDeleteEpisodeQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteEpisode`(
    IN DeleteEpisodeID INT
)
BEGIN
    DELETE FROM `{schema}`.`episode`
    WHERE EpisodeID = DeleteEpisodeID;
END
"""
try:
    cursor.execute(CreateDeleteEpisodeQuery)
    print("Created DeleteEpisode procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteEpisode procedure: {error}")


# %%
## -----------------------------------------------------
## procedure DeleteEvent
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteEventQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteEvent`"
try:
    cursor.execute(DropDeleteEventQuery)
    print("Dropped DeleteEvent procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteEvent procedure: {error}")

# Create the DeleteEvent procedure
CreateDeleteEventQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteEvent`(
    IN EventIDToDelete INT
)
BEGIN
    DELETE FROM `{schema}`.`event`
    WHERE EventID = EventIDToDelete;
END
"""
try:
    cursor.execute(CreateDeleteEventQuery)
    print("Created DeleteEvent procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteEvent procedure: {error}")


# %%
## -----------------------------------------------------
## procedure DeleteEventAddressesObjectHasTrait
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteEventAddressesObjectHasTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteEventAddressesObjectHasTrait`"
try:
    cursor.execute(DropDeleteEventAddressesObjectHasTraitQuery)
    print("Dropped DeleteEventAddressesObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteEventAddressesObjectHasTrait procedure: {error}")

# Create the DeleteEventAddressesObjectHasTrait procedure
CreateDeleteEventAddressesObjectHasTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteEventAddressesObjectHasTrait`(
    IN DeleteEventAddressesObjectHasTraitID INT
)
BEGIN
    DELETE FROM `{schema}`.`eventaddressesobjecthastrait`
    WHERE EventAddressesObjectHasTraitID = DeleteEventAddressesObjectHasTraitID;
END
"""
try:
    cursor.execute(CreateDeleteEventAddressesObjectHasTraitQuery)
    print("Created DeleteEventAddressesObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteEventAddressesObjectHasTrait procedure: {error}")



# %%
## -----------------------------------------------------
## procedure DeleteEventAddressesObjectRelationship
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteEventAddressesObjectRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteEventAddressesObjectRelationship`"
try:
    cursor.execute(DropDeleteEventAddressesObjectRelationshipQuery)
    print("Dropped DeleteEventAddressesObjectRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteEventAddressesObjectRelationship procedure: {error}")

# Create the DeleteEventAddressesObjectRelationship procedure
CreateDeleteEventAddressesObjectRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteEventAddressesObjectRelationship`(
    IN DeleteEventAddressesObjectRelationshipID INT
)
BEGIN
    DELETE FROM `{schema}`.`eventaddressesobjectrelationship`
    WHERE EventAddressesObjectRelationshipID = DeleteEventAddressesObjectRelationshipID;
END
"""
try:
    cursor.execute(CreateDeleteEventAddressesObjectRelationshipQuery)
    print("Created DeleteEventAddressesObjectRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteEventAddressesObjectRelationship procedure: {error}")



# %%
## -----------------------------------------------------
## procedure DeleteEventHasExampleOfObjectName
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteEventHasExampleOfObjectNameQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteEventHasExampleOfObjectName`"
try:
    cursor.execute(DropDeleteEventHasExampleOfObjectNameQuery)
    print("Dropped DeleteEventHasExampleOfObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteEventHasExampleOfObjectName procedure: {error}")

# Create the DeleteEventHasExampleOfObjectName procedure
CreateDeleteEventHasExampleOfObjectNameQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteEventHasExampleOfObjectName`(
    IN EventHasExampleOfObjectNameIDToDelete INT
)
BEGIN
    DELETE FROM `{schema}`.`eventhasexampleofobjectname`
    WHERE EventHasExampleOfObjectNameID = EventHasExampleOfObjectNameIDToDelete;
END
"""
try:
    cursor.execute(CreateDeleteEventHasExampleOfObjectNameQuery)
    print("Created DeleteEventHasExampleOfObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteEventHasExampleOfObjectName procedure: {error}")



# %%
## -----------------------------------------------------
## procedure DeleteEventHasOtherNotes
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteEventHasOtherNotesQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteEventHasOtherNotes`"
try:
    cursor.execute(DropDeleteEventHasOtherNotesQuery)
    print("Dropped DeleteEventHasOtherNotes procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteEventHasOtherNotes procedure: {error}")

# Create the DeleteEventHasOtherNotes procedure
CreateDeleteEventHasOtherNotesQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteEventHasOtherNotes`(
    IN DeleteEventHasOtherNotesID INT
)
BEGIN
    DELETE FROM `{schema}`.`eventhasothernotes`
    WHERE EventHasOtherNotesID = DeleteEventHasOtherNotesID;
END
"""
try:
    cursor.execute(CreateDeleteEventHasOtherNotesQuery)
    print("Created DeleteEventHasOtherNotes procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteEventHasOtherNotes procedure: {error}")


# %%
## -----------------------------------------------------
## procedure DeleteEventHasWish
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteEventHasWishQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteEventHasWish`"
try:
    cursor.execute(DropDeleteEventHasWishQuery)
    print("Dropped DeleteEventHasWish procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteEventHasWish procedure: {error}")

# Create the DeleteEventHasWish procedure
CreateDeleteEventHasWishQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteEventHasWish`(
    IN DeleteEventHasWishID INT
)
BEGIN
    DELETE FROM `{schema}`.`eventincludesobjecthaswish`
    WHERE EventHasWishID = DeleteEventHasWishID;
END
"""
try:
    cursor.execute(CreateDeleteEventHasWishQuery)
    print("Created DeleteEventHasWish procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteEventHasWish procedure: {error}")

# %%
## -----------------------------------------------------
## procedure DeleteObject
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteObjectQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteObject`"
try:
    cursor.execute(DropDeleteObjectQuery)
    print("Dropped DeleteObject procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteObject procedure: {error}")

# Create the DeleteObject procedure
CreateDeleteObjectQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteObject`(
    IN ObjectIDToDelete INT
)
BEGIN
    DELETE FROM `{schema}`.`object`
    WHERE ObjectID = ObjectIDToDelete;
END
"""
try:
    cursor.execute(CreateDeleteObjectQuery)
    print("Created DeleteObject procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteObject procedure: {error}")

# %%
## -----------------------------------------------------
## procedure DeleteObjectHasRelationship
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteObjectHasRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteObjectHasRelationship`"
try:
    cursor.execute(DropDeleteObjectHasRelationshipQuery)
    print("Dropped DeleteObjectHasRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteObjectHasRelationship procedure: {error}")

# Create the DeleteObjectHasRelationship procedure
CreateDeleteObjectHasRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteObjectHasRelationship`(
    IN DeleteObjectHasRelationshipToObjectID INT
)
BEGIN
    DELETE FROM `{schema}`.`objecthasrelationshiptoobject`
    WHERE ObjectHasRelationshipToObjectID = DeleteObjectHasRelationshipToObjectID;
END
"""
try:
    cursor.execute(CreateDeleteObjectHasRelationshipQuery)
    print("Created DeleteObjectHasRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteObjectHasRelationship procedure: {error}")


# %%
## -----------------------------------------------------
## procedure DeleteObjectHasTrait
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteObjectHasTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteObjectHasTrait`"
try:
    cursor.execute(DropDeleteObjectHasTraitQuery)
    print("Dropped DeleteObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteObjectHasTrait procedure: {error}")

# Create the DeleteObjectHasTrait procedure
CreateDeleteObjectHasTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteObjectHasTrait`(
    IN ObjectHasTraitIDToDelete INT
)
BEGIN
    DELETE FROM `{schema}`.`objecthastrait`
    WHERE ObjectHasTraitID = ObjectHasTraitIDToDelete;
END
"""
try:
    cursor.execute(CreateDeleteObjectHasTraitQuery)
    print("Created DeleteObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteObjectHasTrait procedure: {error}")



# %%
## -----------------------------------------------------
## procedure DeleteObjectName
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteObjectNameQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteObjectName`"
try:
    cursor.execute(DropDeleteObjectNameQuery)
    print("Dropped DeleteObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteObjectName procedure: {error}")

# Create the DeleteObjectName procedure
CreateDeleteObjectNameQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteObjectName`(
    IN DeleteObjectNameID INT
)
BEGIN
    DELETE FROM `{schema}`.`objectname`
    WHERE ObjectNameID = DeleteObjectNameID;
END
"""
try:
    cursor.execute(CreateDeleteObjectNameQuery)
    print("Created DeleteObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteObjectName procedure: {error}")


# %%
## -----------------------------------------------------
## procedure DeleteRelationship
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteRelationship`"
try:
    cursor.execute(DropDeleteRelationshipQuery)
    print("Dropped DeleteRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteRelationship procedure: {error}")

# Create the DeleteRelationship procedure
CreateDeleteRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteRelationship`(
    IN DeleteRelationshipID INT
)
BEGIN
    DELETE FROM `{schema}`.`relationship`
    WHERE RelationshipID = DeleteRelationshipID;
END
"""
try:
    cursor.execute(CreateDeleteRelationshipQuery)
    print("Created DeleteRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteRelationship procedure: {error}")


# %%
## -----------------------------------------------------
## procedure DeleteTrait
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteTrait`"
try:
    cursor.execute(DropDeleteTraitQuery)
    print("Dropped DeleteTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteTrait procedure: {error}")

# Create the DeleteTrait procedure
CreateDeleteTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteTrait`(
    IN TraitIDToDelete INT
)
BEGIN
    DELETE FROM `{schema}`.`trait`
    WHERE TraitID = TraitIDToDelete;
END
"""
try:
    cursor.execute(CreateDeleteTraitQuery)
    print("Created DeleteTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteTrait procedure: {error}")

# %%
## -----------------------------------------------------
## procedure DeleteWish
## -----------------------------------------------------

# Drop procedure if it exists
DropDeleteWishQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`DeleteWish`"
try:
    cursor.execute(DropDeleteWishQuery)
    print("Dropped DeleteWish procedure successfully.")
except connector.Error as error:
    print(f"Error dropping DeleteWish procedure: {error}")

# Create the DeleteWish procedure
CreateDeleteWishQuery = f"""
CREATE PROCEDURE `{schema}`.`DeleteWish`(
    IN DeleteWishID INT
)
BEGIN
    DELETE FROM `{schema}`.`wish`
    WHERE WishID = DeleteWishID;
END
"""
try:
    cursor.execute(CreateDeleteWishQuery)
    print("Created DeleteWish procedure successfully.")
except connector.Error as error:
    print(f"Error creating DeleteWish procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyDuration
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyDurationQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyDuration`"
try:
    cursor.execute(DropModifyDurationQuery)
    print("Dropped ModifyDuration procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyDuration procedure: {error}")

# Create the ModifyDuration procedure
CreateModifyDurationQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyDuration`(
    IN NewDurationID INT,
    IN NewStartEventDescription VARCHAR(255),
    IN NewEndEventDescription VARCHAR(255),
    IN NewStartEventIncludesObjectID INT,
    IN NewEndEventIncludesObjectID INT
)
BEGIN
    UPDATE `{schema}`.`duration`
    SET
        StartEventDescription = IF(NewStartEventDescription IS NOT NULL, NewStartEventDescription, StartEventDescription),
        EndEventDescription = IF(NewEndEventDescription IS NOT NULL, NewEndEventDescription, EndEventDescription),
        StartEventIncludesObjectID = IF(NewStartEventIncludesObjectID IS NOT NULL, NewStartEventIncludesObjectID, StartEventIncludesObjectID),
        EndEventIncludesObjectID = IF(NewEndEventIncludesObjectID IS NOT NULL, NewEndEventIncludesObjectID, EndEventIncludesObjectID)
    WHERE DurationID = NewDurationID;
END
"""
try:
    cursor.execute(CreateModifyDurationQuery)
    print("Created ModifyDuration procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyDuration procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyEpisode
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyEpisodeQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyEpisode`"
try:
    cursor.execute(DropModifyEpisodeQuery)
    print("Dropped ModifyEpisode procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyEpisode procedure: {error}")

# Create the ModifyEpisode procedure
CreateModifyEpisodeQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyEpisode`(
    IN ModifyEpisodeID INT,
    IN NewPart INT,
    IN NewEpisode INT,
    IN NewName VARCHAR(45),
    IN NewSynopsis VARCHAR(255)
)
BEGIN
    UPDATE `{schema}`.`episode`
    SET
        Part = IF(NewPart IS NOT NULL, NewPart, Part),
        Episode = IF(NewEpisode IS NOT NULL, NewEpisode, Episode),
        Name = IF(NewName IS NOT NULL, NewName, Name),
        Synopsis = IF(NewSynopsis IS NOT NULL, NewSynopsis, Synopsis)
    WHERE EpisodeID = ModifyEpisodeID;
END
"""
try:
    cursor.execute(CreateModifyEpisodeQuery)
    print("Created ModifyEpisode procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyEpisode procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyEvent
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyEventQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyEvent`"
try:
    cursor.execute(DropModifyEventQuery)
    print("Dropped ModifyEvent procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyEvent procedure: {error}")

# Create the ModifyEvent procedure
CreateModifyEventQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyEvent`(
    IN EventIDToUpdate INT,
    IN NewEventName VARCHAR(45),
    IN NewEpisodeID INT,
    IN NewEventDescription VARCHAR(255),
    IN NewTimestamp DECIMAL(3, 0)
)
BEGIN
    UPDATE `{schema}`.`event`
    SET EventName = IFNULL(NewEventName, EventName),
        EpisodeID = IFNULL(NewEpisodeID, EpisodeID),
        EventDescription = IFNULL(NewEventDescription, EventDescription),
        Timestamp = IFNULL(NewTimestamp, Timestamp)
    WHERE EventID = EventIDToUpdate;
END
"""
try:
    cursor.execute(CreateModifyEventQuery)
    print("Created ModifyEvent procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyEvent procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyEventAddressesObjectHasTrait
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyEventAddressesObjectHasTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyEventAddressesObjectHasTrait`"
try:
    cursor.execute(DropModifyEventAddressesObjectHasTraitQuery)
    print("Dropped ModifyEventAddressesObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyEventAddressesObjectHasTrait procedure: {error}")

# Create the ModifyEventAddressesObjectHasTrait procedure
CreateModifyEventAddressesObjectHasTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyEventAddressesObjectHasTrait`(
    IN ModifyEventAddressesObjectHasTraitID INT,
    IN NewObjectHasTraitID INT,
    IN NewEventAddressesObjectHasTraitDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    UPDATE `{schema}`.`eventaddressesobjecthastrait`
    SET ObjectHasTraitID = IFNULL(NewObjectHasTraitID, ObjectHasTraitID),
        EventAddressesObjectHasTraitDescription = IFNULL(NewEventAddressesObjectHasTraitDescription, EventAddressesObjectHasTraitDescription),
        EventIncludesObjectID = IFNULL(NewEventIncludesObjectID, EventIncludesObjectID)
    WHERE EventAddressesObjectHasTraitID = ModifyEventAddressesObjectHasTraitID;
END
"""
try:
    cursor.execute(CreateModifyEventAddressesObjectHasTraitQuery)
    print("Created ModifyEventAddressesObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyEventAddressesObjectHasTrait procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyEventAddressesObjectRelationship
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyEventAddressesObjectRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyEventAddressesObjectRelationship`"
try:
    cursor.execute(DropModifyEventAddressesObjectRelationshipQuery)
    print("Dropped ModifyEventAddressesObjectRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyEventAddressesObjectRelationship procedure: {error}")

# Create the ModifyEventAddressesObjectRelationship procedure
CreateModifyEventAddressesObjectRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyEventAddressesObjectRelationship`(
    IN ModifyEventAddressesObjectRelationshipID INT,
    IN NewObjectHasRelationshipToObjectID INT,
    IN NewEventAddressesObjectRelationshipDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    UPDATE `{schema}`.`eventaddressesobjectrelationship`
    SET ObjectHasRelationshipToObjectID = IFNULL(NewObjectHasRelationshipToObjectID, ObjectHasRelationshipToObjectID),
        EventAddressesObjectRelationshipDescription = IFNULL(NewEventAddressesObjectRelationshipDescription, EventAddressesObjectRelationshipDescription),
        EventIncludesObjectID = IFNULL(NewEventIncludesObjectID, EventIncludesObjectID)
    WHERE EventAddressesObjectRelationshipID = ModifyEventAddressesObjectRelationshipID;
END
"""
try:
    cursor.execute(CreateModifyEventAddressesObjectRelationshipQuery)
    print("Created ModifyEventAddressesObjectRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyEventAddressesObjectRelationship procedure: {error}")




# %%
## -----------------------------------------------------
## procedure ModifyEventHasExampleOfObjectName
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyEventHasExampleOfObjectNameQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyEventHasExampleOfObjectName`"
try:
    cursor.execute(DropModifyEventHasExampleOfObjectNameQuery)
    print("Dropped ModifyEventHasExampleOfObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyEventHasExampleOfObjectName procedure: {error}")

# Create the ModifyEventHasExampleOfObjectName procedure
CreateModifyEventHasExampleOfObjectNameQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyEventHasExampleOfObjectName`(
    IN EventHasExampleOfObjectNameIDToUpdate INT,
    IN NewObjectHasNameID INT,
    IN NewEvidenceDescription VARCHAR(255),
    IN NewEventIncludesObjectID INT
)
BEGIN
    UPDATE `{schema}`.`eventhasexampleofobjectname`
    SET ObjectHasNameID = IFNULL(NewObjectHasNameID, ObjectHasNameID),
        EvidenceDescription = IFNULL(NewEvidenceDescription, EvidenceDescription),
        EventIncludesObjectID = IFNULL(NewEventIncludesObjectID, EventIncludesObjectID)
    WHERE EventHasExampleOfObjectNameID = EventHasExampleOfObjectNameIDToUpdate;
END
"""
try:
    cursor.execute(CreateModifyEventHasExampleOfObjectNameQuery)
    print("Created ModifyEventHasExampleOfObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyEventHasExampleOfObjectName procedure: {error}")




# %%
## -----------------------------------------------------
## procedure ModifyEventHasOtherNotes
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyEventHasOtherNotesQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyEventHasOtherNotes`"
try:
    cursor.execute(DropModifyEventHasOtherNotesQuery)
    print("Dropped ModifyEventHasOtherNotes procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyEventHasOtherNotes procedure: {error}")

# Create the ModifyEventHasOtherNotes procedure
CreateModifyEventHasOtherNotesQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyEventHasOtherNotes`(
    IN ModifyEventHasOtherNotesID INT,
    IN NewEventID INT,
    IN NewNote VARCHAR(255)
)
BEGIN
    UPDATE `{schema}`.`eventhasothernotes`
    SET EventID = IFNULL(NewEventID, EventID),
        Note = IFNULL(NewNote, Note)
    WHERE EventHasOtherNotesID = ModifyEventHasOtherNotesID;
END
"""
try:
    cursor.execute(CreateModifyEventHasOtherNotesQuery)
    print("Created ModifyEventHasOtherNotes procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyEventHasOtherNotes procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyEventHasWish
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyEventHasWishQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyEventHasWish`"
try:
    cursor.execute(DropModifyEventHasWishQuery)
    print("Dropped ModifyEventHasWish procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyEventHasWish procedure: {error}")

# Create the ModifyEventHasWish procedure
CreateModifyEventHasWishQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyEventHasWish`(
    IN EventHasWishIDValue INT,
    IN WishIDValue INT,
    IN WishGrantDenyValue VARCHAR(5),
    IN EventIncludesObjectIDValue INT
)
BEGIN
    UPDATE `{schema}`.`eventincludesobjecthaswish`
    SET
        WishID = WishIDValue,
        WishGrantDeny = WishGrantDenyValue,
        EventIncludesObjectID = EventIncludesObjectIDValue
    WHERE EventHasWishID = EventHasWishIDValue;
END
"""
try:
    cursor.execute(CreateModifyEventHasWishQuery)
    print("Created ModifyEventHasWish procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyEventHasWish procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyEventIncludesObject
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyEventIncludesObjectQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyEventIncludesObject`"
try:
    cursor.execute(DropModifyEventIncludesObjectQuery)
    print("Dropped ModifyEventIncludesObject procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyEventIncludesObject procedure: {error}")

# Create the ModifyEventIncludesObject procedure
CreateModifyEventIncludesObjectQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyEventIncludesObject`(
    IN ModifyEventIncludesObjectID INT,
    IN NewEventID INT,
    IN NewObjectID INT,
    IN NewInclusionDescription VARCHAR(45),
    IN NewSequentialID DECIMAL(3,0)
)
BEGIN
    UPDATE `{schema}`.`eventincludesobject`
    SET EventID = IFNULL(NewEventID, EventID),
        ObjectID = IFNULL(NewObjectID, ObjectID),
        InclusionDescription = IFNULL(NewInclusionDescription, InclusionDescription),
        SequentialID = IFNULL(NewSequentialID, SequentialID)
    WHERE EventIncludesObjectID = ModifyEventIncludesObjectID;
END
"""
try:
    cursor.execute(CreateModifyEventIncludesObjectQuery)
    print("Created ModifyEventIncludesObject procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyEventIncludesObject procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyObject
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyObjectQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyObject`"
try:
    cursor.execute(DropModifyObjectQuery)
    print("Dropped ModifyObject procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyObject procedure: {error}")

# Create the ModifyObject procedure
CreateModifyObjectQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyObject`(
    IN ObjectIDToUpdate INT,
    IN NewObjectTypeID INT,
    IN NewObjectReferenceName VARCHAR(45),
    IN NewObjectDescription VARCHAR(255)
)
BEGIN
    UPDATE `{schema}`.`object`
    SET ObjectTypeID = IFNULL(NewObjectTypeID, ObjectTypeID),
        ObjectReferenceName = IFNULL(NewObjectReferenceName, ObjectReferenceName),
        ObjectDescription = IFNULL(NewObjectDescription, ObjectDescription)
    WHERE ObjectID = ObjectIDToUpdate;
END
"""
try:
    cursor.execute(CreateModifyObjectQuery)
    print("Created ModifyObject procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyObject procedure: {error}")


# %%
## -----------------------------------------------------
## procedure ModifyObjectHasObjectName
## -----------------------------------------------------

# Drop procedure if it exists
DropModifyObjectHasObjectNameQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyObjectHasObjectName`"
try:
    cursor.execute(DropModifyObjectHasObjectNameQuery)
    print("Dropped ModifyObjectHasObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyObjectHasObjectName procedure: {error}")

# Create the ModifyObjectHasObjectName procedure
CreateModifyObjectHasObjectNameQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyObjectHasObjectName`(
    IN ObjectHasNameIDToUpdate INT,
    IN NewObjectID INT,
    IN NewObjectNameID INT
)
BEGIN
    UPDATE `{schema}`.`objecthasobjectname`
    SET ObjectID = IFNULL(NewObjectID, ObjectID),
        ObjectNameID = IFNULL(NewObjectNameID, ObjectNameID)
    WHERE ObjectHasNameID = ObjectHasNameIDToUpdate;
END
"""
try:
    cursor.execute(CreateModifyObjectHasObjectNameQuery)
    print("Created ModifyObjectHasObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyObjectHasObjectName procedure: {error}")


# %%
# -----------------------------------------------------
## procedure ModifyObjectHasRelationship
# -----------------------------------------------------

# Drop procedure if it exists
DropModifyObjectHasRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyObjectHasRelationship`"
try:
    cursor.execute(DropModifyObjectHasRelationshipQuery)
    print("Dropped ModifyObjectHasRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyObjectHasRelationship procedure: {error}")

# Create the ModifyObjectHasRelationship procedure
CreateModifyObjectHasRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyObjectHasRelationship`(
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
    UPDATE `{schema}`.`objecthasrelationshiptoobject`
    SET
        Object1ID = Object1IDValue,
        RelationshipID = RelationshipIDValue,
        Object2ID = Object2IDValue,
        Explanation = ExplanationValue,
        DurationID = DurationIDValue,
        RelationshipPriorityID = RelationshipPriorityIDValue,
        Object2InheritsTraitsFromObject1 = Object2InheritsTraitsFromObject1Value
    WHERE ObjectHasRelationshipToObjectID = ObjectHasRelationshipToObjectIDValue;
END
"""
try:
    cursor.execute(CreateModifyObjectHasRelationshipQuery)
    print("Created ModifyObjectHasRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyObjectHasRelationship procedure: {error}")



# %%
# -----------------------------------------------------
## procedure ModifyObjectHasTrait
# -----------------------------------------------------

# Drop procedure if it exists
DropModifyObjectHasTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyObjectHasTrait`"
try:
    cursor.execute(DropModifyObjectHasTraitQuery)
    print("Dropped ModifyObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyObjectHasTrait procedure: {error}")

# Create the ModifyObjectHasTrait procedure
CreateModifyObjectHasTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyObjectHasTrait`(
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
END
"""
try:
    cursor.execute(CreateModifyObjectHasTraitQuery)
    print("Created ModifyObjectHasTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyObjectHasTrait procedure: {error}")


# %%
# -----------------------------------------------------
## procedure ModifyObjectName
# -----------------------------------------------------

# Drop procedure if it exists
DropModifyObjectNameQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyObjectName`"
try:
    cursor.execute(DropModifyObjectNameQuery)
    print("Dropped ModifyObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyObjectName procedure: {error}")

# Create the ModifyObjectName procedure
CreateModifyObjectNameQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyObjectName`(
    IN ObjectNameIDValue INT,
    IN ObjectNameValue VARCHAR(45),
    IN NameTypeValue VARCHAR(45),
    IN NamePriorityValue VARCHAR(45)
)
BEGIN
    UPDATE `{schema}`.`objectname`
    SET
        ObjectName = ObjectNameValue,
        NameType = NameTypeValue,
        NamePriority = NamePriorityValue
    WHERE ObjectNameID = ObjectNameIDValue;
END
"""
try:
    cursor.execute(CreateModifyObjectNameQuery)
    print("Created ModifyObjectName procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyObjectName procedure: {error}")



# %%
# -----------------------------------------------------
## procedure ModifyRelationship
# -----------------------------------------------------

# Drop procedure if it exists
DropModifyRelationshipQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyRelationship`"
try:
    cursor.execute(DropModifyRelationshipQuery)
    print("Dropped ModifyRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyRelationship procedure: {error}")

# Create the ModifyRelationship procedure
CreateModifyRelationshipQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyRelationship`(
    IN ModifyRelationshipID INT,
    IN NewRelationshipType VARCHAR(45),
    IN NewRelationshipTypeUniversalDescription VARCHAR(255)
)
BEGIN
    UPDATE `{schema}`.`relationship`
    SET RelationshipType = IFNULL(NewRelationshipType, RelationshipType),
        RelationshipTypeUniversalDescription = IFNULL(NewRelationshipTypeUniversalDescription, RelationshipTypeUniversalDescription)
    WHERE RelationshipID = ModifyRelationshipID;
END
"""
try:
    cursor.execute(CreateModifyRelationshipQuery)
    print("Created ModifyRelationship procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyRelationship procedure: {error}")


# %%
# -----------------------------------------------------
## procedure ModifyTrait
# -----------------------------------------------------

# Drop procedure if it exists
DropModifyTraitQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyTrait`"
try:
    cursor.execute(DropModifyTraitQuery)
    print("Dropped ModifyTrait procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyTrait procedure: {error}")

# Create the ModifyTrait procedure
CreateModifyTraitQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyTrait`(
    IN TraitIDToUpdate INT,
    IN NewTraitName VARCHAR(45),
    IN NewTraitUniversalDescription VARCHAR(45)
)
BEGIN
    UPDATE trait
    SET TraitName = IFNULL(NewTraitName, TraitName),
        TraitUniversalDescription = IFNULL(NewTraitUniversalDescription, TraitUniversalDescription)
    WHERE TraitID = TraitIDToUpdate;
END
"""
try:
    cursor.execute(CreateModifyTraitQuery)
    print("Created ModifyTrait procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyTrait procedure: {error}")



# %%
# -----------------------------------------------------
## procedure ModifyWish
# -----------------------------------------------------

# Drop procedure if it exists
DropModifyWishQuery = f"DROP PROCEDURE IF EXISTS `{schema}`.`ModifyWish`"
try:
    cursor.execute(DropModifyWishQuery)
    print("Dropped ModifyWish procedure successfully.")
except connector.Error as error:
    print(f"Error dropping ModifyWish procedure: {error}")

# Create the ModifyWish procedure
CreateModifyWishQuery = f"""
CREATE PROCEDURE `{schema}`.`ModifyWish`(
    IN WishIDValue INT,
    IN WishQuoteValue VARCHAR(255),
    IN DescriptionValue VARCHAR(255),
    IN CurrentStatusDescriptionValue VARCHAR(255)
)
BEGIN
    UPDATE `{schema}`.`wish`
    SET
        WishQuote = IFNULL(WishQuoteValue, WishQuote),
        Description = IFNULL(DescriptionValue, Description),
        CurrentStatusDescription = IFNULL(CurrentStatusDescriptionValue, CurrentStatusDescription)
    WHERE WishID = WishIDValue;
END
"""
try:
    cursor.execute(CreateModifyWishQuery)
    print("Created ModifyWish procedure successfully.")
except connector.Error as error:
    print(f"Error creating ModifyWish procedure: {error}")


# %%
##-----------------------------------------------------
## Views
##-----------------------------------------------------

views = []

# %%
## -----------------------------------------------------
## View `"""+schema+"""`.`objecttimeline`
## -----------------------------------------------------
"""+schema+"""
ObjectTimelineViewStatement = """
DROP VIEW IF EXISTS `"""+schema+"""`.`objecttimeline` ;
USE `"""+schema+"""`;
CREATE  OR REPLACE VIEW """+schema+""".objecttimeline AS
SELECT o.ObjectReferenceName AS ObjectReferenceName, e.EventName AS EventName, eio.InclusionDescription AS InclusionDescription, r.RelationshipType, eaor.EventAddressesObjectRelationshipDescription, o2.ObjectReferenceName AS Object2ReferenceName, n.ObjectName, n.NameType, eheoo.EvidenceDescription, eiohw.EventIncludesObjectHasWishDescription
FROM  """+schema+""".object o
LEFT JOIN """+schema+""".eventincludesobject eio ON o.ObjectID = eio.ObjectID
LEFT JOIN """+schema+""".objecthasrelationshiptoobject ohrto ON o.ObjectID = ohrto.Object1ID
LEFT JOIN """+schema+""".object o2 ON o2.ObjectID = ohrto.Object2ID
LEFT JOIN """+schema+""".relationship r ON ohrto.RelationshipID = r.RelationshipID
LEFT JOIN """+schema+""".event e ON eio.EventID = e.EventID
LEFT JOIN """+schema+""".eventaddressesobjectrelationship eaor ON eio.EventIncludesObjectID = eaor.EventIncludesObjectID
LEFT JOIN """+schema+""".eventhasexampleofobjectname eheoo ON eio.EventIncludesObjectID = eheoo.EventIncludesObjectID
LEFT JOIN """+schema+""".eventincludesobjecthaswish eiohw ON eio.EventIncludesObjectID = eiohw.EventIncludesObjectID
LEFT JOIN """+schema+""".eventaddressesobjecthastrait eaoht ON eio.EventIncludesObjectID = eaoht.EventIncludesObjectID
LEFT JOIN """+schema+""".objecthastrait aht ON eaoht.ObjectHasTraitID = aht.ObjectHasTraitID
LEFT JOIN """+schema+""".trait t ON aht.TraitID = t.TraitID
LEFT JOIN """+schema+""".objecthasobjectname oho ON eheoo.ObjectHasNameID = oho.ObjectHasNameID
LEFT JOIN """+schema+""".objectname n ON oho.ObjectNameID = n.ObjectNameID
LEFT JOIN """+schema+""".wish w ON eiohw.WishID = w.WishID
ORDER BY eio.SequentialID;
## -----------------------------------------------------
## View `"""+schema+"""`.`eventview`
## -----------------------------------------------------
DROP TABLE IF EXISTS `"""+schema+"""`.`eventview`;
DROP VIEW IF EXISTS `"""+schema+"""`.`eventview` ;
USE `"""+schema+"""`;
CREATE  OR REPLACE VIEW """+schema+""".eventview AS
SELECT e.EventName, eio.InclusionDescription
FROM event e
LEFT JOIN eventincludesobject eio ON e.EventID = eio.EventID;
"""


# %%
## -----------------------------------------------------
## View `"""+schema+"""`.`eventview`
## -----------------------------------------------------

eventview = """
DROP TABLE IF EXISTS `"""+schema+"""`.`eventview`;
DROP VIEW IF EXISTS `"""+schema+"""`.`eventview` ;
USE `"""+schema+"""`;
CREATE  OR REPLACE VIEW """+schema+""".eventview AS
SELECT e.EventName, eio.InclusionDescription
FROM event e
LEFT JOIN eventincludesobject eio ON e.EventID = eio.EventID;
"""
cursor.close()
connection.close()


