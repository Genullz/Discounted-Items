-- MySQL Script generated by MySQL Workbench
-- Fri Apr 12 14:15:31 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema discounted-items
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema discounted-items
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `discounted-items` DEFAULT CHARACTER SET utf8mb3 ;
USE `discounted-items` ;

-- -----------------------------------------------------
-- Table `discounted-items`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discounted-items`.`categories` (
  `CategoryID` BIGINT NOT NULL,
  `CategoryName` TEXT NOT NULL,
  `Description` TEXT NOT NULL,
  PRIMARY KEY (`CategoryID`),
  UNIQUE INDEX `CategoryID_UNIQUE` (`CategoryID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `discounted-items`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discounted-items`.`products` (
  `ProductID` BIGINT NOT NULL,
  `ProductName` TEXT NOT NULL,
  `CategoryID` BIGINT NULL DEFAULT NULL,
  `QuantityPerUnit` TEXT NULL DEFAULT NULL,
  `UnitPrice` DOUBLE NULL DEFAULT NULL,
  `UnitsInStock` BIGINT NULL DEFAULT NULL,
  `UnitsOnOrder` BIGINT NULL DEFAULT NULL,
  `ReorderLevel` BIGINT NULL DEFAULT NULL,
  `Discontinued` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE INDEX `ProductID_UNIQUE` (`ProductID` ASC) VISIBLE,
  INDEX `CategoryID_idx` (`CategoryID` ASC) VISIBLE,
  CONSTRAINT `CategoryID`
    FOREIGN KEY (`CategoryID`)
    REFERENCES `discounted-items`.`categories` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `discounted-items`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discounted-items`.`orders` (
  `OrderID` BIGINT NOT NULL,
  `CustomerID` TEXT NULL,
  `EmployeeID` INT NULL,
  `OrderDate` TEXT NULL DEFAULT NULL,
  `RequiredDate` TEXT NOT NULL,
  `ShippedDate` TEXT NOT NULL,
  `ShipVia` BIGINT NULL DEFAULT NULL,
  `Freight` DOUBLE NULL DEFAULT NULL,
  `ShipName` TEXT NULL DEFAULT NULL,
  `ShipAddress` TEXT NULL DEFAULT NULL,
  `ShipCity` TEXT NULL DEFAULT NULL,
  `ShipRegion` TEXT NULL DEFAULT NULL,
  `ShipPostalCode` TEXT NULL DEFAULT NULL,
  `ShipCountry` TEXT NULL DEFAULT NULL,
  `OrderSubtotal` DOUBLE NULL DEFAULT NULL,
  `OrderTotal` DOUBLE NOT NULL,
  PRIMARY KEY (`OrderID`),
  UNIQUE INDEX `OrderID_UNIQUE` (`OrderID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `discounted-items`.`orderdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discounted-items`.`orderdetails` (
  `UnitPrice` DOUBLE NULL DEFAULT NULL,
  `Quantity` BIGINT NULL DEFAULT NULL,
  `Discount` DOUBLE NULL DEFAULT NULL,
  `SalePrice` DOUBLE NULL DEFAULT NULL,
  `Subtotal` DOUBLE NULL DEFAULT NULL,
  `Order` TEXT NULL DEFAULT NULL,
  `ProductID` BIGINT NULL,
  `orders_OrderID` BIGINT NOT NULL,
  INDEX `ProductID_idx` (`ProductID` ASC) VISIBLE,
  INDEX `fk_orderdetails_orders1_idx` (`orders_OrderID` ASC) VISIBLE,
  CONSTRAINT `ProductID`
    FOREIGN KEY (`ProductID`)
    REFERENCES `discounted-items`.`products` (`ProductID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orderdetails_orders1`
    FOREIGN KEY (`orders_OrderID`)
    REFERENCES `discounted-items`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `discounted-items`.`categories_has_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discounted-items`.`categories_has_orders` (
  `categories_CategoryID` BIGINT NOT NULL,
  `orders_OrderID` BIGINT NOT NULL,
  PRIMARY KEY (`categories_CategoryID`, `orders_OrderID`),
  INDEX `fk_categories_has_orders_orders1_idx` (`orders_OrderID` ASC) VISIBLE,
  INDEX `fk_categories_has_orders_categories1_idx` (`categories_CategoryID` ASC) VISIBLE,
  CONSTRAINT `fk_categories_has_orders_categories1`
    FOREIGN KEY (`categories_CategoryID`)
    REFERENCES `discounted-items`.`categories` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categories_has_orders_orders1`
    FOREIGN KEY (`orders_OrderID`)
    REFERENCES `discounted-items`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
