-- MySQL Script generated by MySQL Workbench
-- Thu Nov  9 13:59:27 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tiendaoptica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tiendaoptica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tiendaoptica` DEFAULT CHARACTER SET utf8 ;
USE `tiendaoptica` ;

-- -----------------------------------------------------
-- Table `tiendaoptica`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendaoptica`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(100) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendaoptica`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendaoptica`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(100) NULL,
  `precio` VARCHAR(45) NULL,
  `stock` INT NULL,
  `categoria_id` INT NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),
  INDEX `fk_categoria_producto_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_categoria_producto`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `tiendaoptica`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendaoptica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendaoptica`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(100) NULL,
  `apellidos` VARCHAR(100) NULL,
  `telefono` VARCHAR(45) NULL,
  `calle` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `depto` VARCHAR(45) NULL,
  `cp` VARCHAR(45) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendaoptica`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendaoptica`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendaoptica`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendaoptica`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(100) NULL,
  `apellidos` VARCHAR(100) NULL,
  `telefono` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `pass` VARCHAR(100) NULL,
  `rol_id` INT NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_rol_usuarios_idx` (`rol_id` ASC),
  CONSTRAINT `fk_rol_usuarios`
    FOREIGN KEY (`rol_id`)
    REFERENCES `tiendaoptica`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendaoptica`.`tipo_documentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendaoptica`.`tipo_documentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendaoptica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendaoptica`.`ventas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL,
  `subtotal` VARCHAR(45) NULL,
  `descuento` VARCHAR(45) NULL,
  `total` VARCHAR(45) NULL,
  `tipo_documento_id` INT NULL,
  `cliente_id` INT NULL,
  `usuario_id` INT NULL,
  `num_documento` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_venta_idx` (`usuario_id` ASC),
  INDEX `fk_cliente_venta_idx` (`cliente_id` ASC),
  INDEX `fk_tipo_documento_venta_idx` (`tipo_documento_id` ASC),
  CONSTRAINT `fk_usuario_venta`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `tiendaoptica`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_venta`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `tiendaoptica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_documento_venta`
    FOREIGN KEY (`tipo_documento_id`)
    REFERENCES `tiendaoptica`.`tipo_documentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiendaoptica`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tiendaoptica`.`detalle_venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `producto_id` INT NULL,
  `venta_id` INT NULL,
  `precio` VARCHAR(45) NULL,
  `cantidad` VARCHAR(45) NULL,
  `importe` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venta_detalle_idx` (`venta_id` ASC),
  INDEX `fk_producto_detalle_idx` (`producto_id` ASC),
  CONSTRAINT `fk_venta_detalle`
    FOREIGN KEY (`venta_id`)
    REFERENCES `tiendaoptica`.`ventas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_detalle`
    FOREIGN KEY (`producto_id`)
    REFERENCES `tiendaoptica`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;