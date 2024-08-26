-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Little_Lemon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Little_Lemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Little_Lemon` ;
USE `Little_Lemon` ;

-- -----------------------------------------------------
-- Table `Little_Lemon`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`Customers` (
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `ContactNumber` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`Bookings` (
  `BookingDate` DATETIME NULL,
  `TableNumber` INT NULL,
  `BookingID` INT NOT NULL,
  `CustomerID` INT NULL,
  INDEX `fk_Bookings_Customers1_idx` (`CustomerID` ASC) VISIBLE,
  PRIMARY KEY (`BookingID`),
  UNIQUE INDEX `BookingID_UNIQUE` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customers1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Little_Lemon`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`Order Delivery Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`Order Delivery Status` (
  `DeliveryStatusID` INT NOT NULL,
  `DeliveryDate` DATETIME NULL,
  `Status` VARCHAR(45) NULL,
  `OrderID` INT NULL,
  PRIMARY KEY (`DeliveryStatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`Staff` (
  `StaffID` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `Role` VARCHAR(45) NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`Orders` (
  `OrderDate` DATETIME NULL,
  `Quantity` INT NULL,
  `TotalCost` INT NULL,
  `OrderID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `DeliveryStatusID` INT NULL,
  `StaffID` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Order Delivery Status1_idx` (`DeliveryStatusID` ASC) VISIBLE,
  INDEX `fk_Orders_Staff1_idx` (`StaffID` ASC) VISIBLE,
  UNIQUE INDEX `BookingID_UNIQUE` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Order Delivery Status1`
    FOREIGN KEY (`DeliveryStatusID`)
    REFERENCES `Little_Lemon`.`Order Delivery Status` (`DeliveryStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Staff1`
    FOREIGN KEY (`StaffID`)
    REFERENCES `Little_Lemon`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Bookings1`
    FOREIGN KEY (`BookingID`)
    REFERENCES `Little_Lemon`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`Menu` (
  `MenuItemID` INT NOT NULL,
  `ItemName` VARCHAR(45) NULL,
  `Category` VARCHAR(45) NULL,
  `Price` INT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`OrderItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`OrderItems` (
  `OrderItemID` INT NOT NULL,
  `OrderID` INT NULL,
  `MenuItemID` INT NULL,
  `Quantity` INT NULL,
  PRIMARY KEY (`OrderItemID`),
  INDEX `fk_OrderItems_Orders1_idx` (`OrderID` ASC) VISIBLE,
  INDEX `fk_OrderItems_Menu1_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `fk_OrderItems_Orders1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `Little_Lemon`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderItems_Menu1`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `Little_Lemon`.`Menu` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
