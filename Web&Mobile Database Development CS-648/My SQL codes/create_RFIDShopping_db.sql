-- MySQL Script generated by MySQL Workbench
-- Tue Mar 26 12:46:14 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- DATABASE my_RFIDShopping_db
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `my_RFIDShopping_db` ;
CREATE DATABASE IF NOT EXISTS `my_RFIDShopping_db` ;
USE my_RFIDShopping_db;

-- -----------------------------------------------------
-- Table `my_RFIDShopping_db`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_RFIDShopping_db`.`Customers` (
  `Customer_Id` INT NOT NULL AUTO_INCREMENT,
  `Customer_name` VARCHAR(64) NOT NULL,
  `RFID_ID` VARCHAR(45) NULL,
  `password` VARCHAR(128) NOT NULL,
  `e_mail` VARCHAR(128) NULL,
  `phone_number` VARCHAR(45) NULL,
  PRIMARY KEY (`Customer_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_RFIDShopping_db`.`Ways_to_pay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_RFIDShopping_db`.`Ways_to_pay` (
  `payment_way` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`payment_way`),
  UNIQUE INDEX `payment_way_UNIQUE` (`payment_way` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_RFIDShopping_db`.`Receipts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_RFIDShopping_db`.`Receipts` (
  `Receipt_Id` INT NOT NULL AUTO_INCREMENT,
  `Customer_Id` INT NOT NULL,
  `sum_of_price` DECIMAL(9,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `payment_way` VARCHAR(32) NULL,
  `date` DATE NULL,
  PRIMARY KEY (`Receipt_Id`),
  INDEX `receipt_fk_payment_idx` (`payment_way` ASC) VISIBLE,
  CONSTRAINT `receipt_fk_payment`
    FOREIGN KEY (`payment_way`)
    REFERENCES `my_RFIDShopping_db`.`Ways_to_pay` (`payment_way`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_RFIDShopping_db`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_RFIDShopping_db`.`Categories` (
  `category` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`category`),
  UNIQUE INDEX `catefory_UNIQUE` (`category` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_RFIDShopping_db`.`NutritionFacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_RFIDShopping_db`.`NutritionFacts` (
  `NutritionFacts_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `serving_size` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `serving_per_container` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `calories` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `saturated_fat` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `trans_fat` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `sodium` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `potassium` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `cholesterol` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `dietary_fiber` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  `sugars` DECIMAL(8,4) UNSIGNED NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`NutritionFacts_Id`),
  UNIQUE INDEX `NutritionFacts_Id_UNIQUE` (`NutritionFacts_Id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_RFIDShopping_db`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_RFIDShopping_db`.`Products` (
  `Product_Id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(128) NOT NULL,
  `price` DECIMAL(9,2) NOT NULL DEFAULT 0.00,
  `ingredients` VARCHAR(1024) NULL,
  `category` VARCHAR(64) NOT NULL,
  `NutritionFacts_Id` INT UNSIGNED NULL,
  PRIMARY KEY (`Product_Id`),
  UNIQUE INDEX `product_name_UNIQUE` (`product_name` ASC) VISIBLE,
  INDEX `products_fk_nutritionfacts_idx` (`NutritionFacts_Id` ASC) VISIBLE,
  INDEX `products_fk_categories_idx` (`category` ASC) VISIBLE,
  CONSTRAINT `products_fk_categories`
    FOREIGN KEY (`category`)
    REFERENCES `my_RFIDShopping_db`.`Categories` (`category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `products_fk_nutritionfacts`
    FOREIGN KEY (`NutritionFacts_Id`)
    REFERENCES `my_RFIDShopping_db`.`NutritionFacts` (`NutritionFacts_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_RFIDShopping_db`.`Customers_to_Receipts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_RFIDShopping_db`.`Customers_to_Receipts` (
  `CToR_Id` INT NOT NULL AUTO_INCREMENT,
  `Customer_Id` INT NOT NULL,
  `Recipt_Id` INT NOT NULL,
  PRIMARY KEY (`CToR_Id`),
  INDEX `CToR_fk_customer_idx` (`Customer_Id` ASC) VISIBLE,
  INDEX `CToR_fk_receipts_idx` (`Recipt_Id` ASC) VISIBLE,
  CONSTRAINT `CToR_fk_customers`
    FOREIGN KEY (`Customer_Id`)
    REFERENCES `my_RFIDShopping_db`.`Customers` (`Customer_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CToR_fk_receipts`
    FOREIGN KEY (`Recipt_Id`)
    REFERENCES `my_RFIDShopping_db`.`Receipts` (`Receipt_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_RFIDShopping_db`.`Receipts_to_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_RFIDShopping_db`.`Receipts_to_Products` (
  `RToP_Id` INT NOT NULL AUTO_INCREMENT,
  `Receipt_Id` INT NULL,
  `Product_Id` INT NULL,
  `Quantity` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`RToP_Id`),
  INDEX `RToP_fk_receipt_idx` (`Receipt_Id` ASC) VISIBLE,
  INDEX `RToP_fk_products_idx` (`Product_Id` ASC) VISIBLE,
  CONSTRAINT `RToP_fk_receipts`
    FOREIGN KEY (`Receipt_Id`)
    REFERENCES `my_RFIDShopping_db`.`Receipts` (`Receipt_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `RToP_fk_products`
    FOREIGN KEY (`Product_Id`)
    REFERENCES `my_RFIDShopping_db`.`Products` (`Product_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert lookup data into tables
INSERT INTO Categories (category) VALUES
('Grocery'),
('Household Essentials'),
('School & Office Supplies'),
('Electronics'),
('Kitchen & Dining')
;

INSERT INTO Ways_to_pay (payment_way) VALUES
('Credit card'),
('Debit card'),
('Cash')
;

-- Insert primary data into the tables
INSERT INTO Customers (Customer_Id, Customer_name , RFID_ID, password, e_mail, phone_number) VALUES
(1, 'Allan','4F42227534835423F', '0000', 'allan.sherwood@yahoo.com', '201-653-4472'),
(2, 'Barry','4F42227534835421A', '1111', 'barryz@gmail.com', '619-653-4472'),
(3, 'Christine','2F42227534725421B', '2222', 'christineb@gmail.com', '619-111-2233')
;

INSERT INTO Receipts (Receipt_Id, Customer_Id, sum_of_price, payment_way) VALUES
(1, '1','120.0', 'Credit card'),
(2, '1','56.5', 'Debit card'),
(3, '2','12.79', 'Cash'),
(4, '3','21', 'Cash')
;

INSERT INTO NutritionFacts (NutritionFacts_Id, serving_size, serving_per_container, calories, saturated_fat, trans_fat, sodium, potassium, cholesterol, dietary_fiber, sugars ) VALUES
(1, '41','8', '200', '12', '0', '0.035', '0', '0.01', '1', '23'),
(2, '41','8', '200', '12', '0', '0.035', '0', '0.01', '1', '23'),
(3, '41','8', '200', '12', '0', '0.035', '0', '0.01', '1', '23')
;

INSERT INTO Products (Product_Id, product_name, price, ingredients,category,NutritionFacts_Id) VALUES
(1, 'HERSHEYS \'KISSES Classic Bag 12oz','3.59','CANE SUGAR; MILK; CHOCOLATE; COCOA BUTTER; MILK FAT; LECITHIN (SOY); NATURAL FLAVOR.','Grocery','1'),
(2, 'Scott Tube Free Toilet Pape 24 rolls','10.99',NULL,'Household Essentials',NULL)
;
 
-- Insert linking data into the tables
INSERT INTO Customers_to_Receipts (Customer_Id, Recipt_Id) VALUES
(1,1),
(1,2),
(2,3),
(3,4)
;
INSERT INTO Receipts_to_Products (Receipt_Id, Product_Id, Quantity) VALUES
(1,1, 1),
(1,2, 2),
(2,1, 6),
(3,1, 5)
;

CREATE USER 'myrs_user' IDENTIFIED BY 'root';

GRANT ALL ON `my_RFIDShopping_db`.* TO 'myrs_user';