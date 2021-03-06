-- MySQL Script generated by MySQL Workbench
-- 06/03/17 14:10:10
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dulzura
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dulzura
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dulzura` DEFAULT CHARACTER SET utf8 ;
USE `dulzura` ;

-- -----------------------------------------------------
-- Table `dulzura`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`usuario` (
  `id_usuario` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `pass` VARCHAR(45) NOT NULL,
  `rut` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido_m` VARCHAR(45) NULL,
  `apellido_p` VARCHAR(45) NULL,
  `celular` INT NULL,
  `tipo_usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`horario` (
  `id_horario` INT NOT NULL,
  `horario_semanal` VARCHAR(45) NULL,
  `horario_usuario` DATE NULL,
  `hora_comienzo` TIME(0) NOT NULL,
  `hora_fin` TIME(0) NOT NULL,
  PRIMARY KEY (`id_horario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`actividad` (
  `id_actividad` INT NOT NULL,
  `actividad` VARCHAR(45) NULL,
  `horario_id_horario` INT NOT NULL,
  PRIMARY KEY (`id_actividad`, `horario_id_horario`),
  INDEX `fk_actividad_horario1_idx` (`horario_id_horario` ASC),
  CONSTRAINT `fk_actividad_horario1`
    FOREIGN KEY (`horario_id_horario`)
    REFERENCES `dulzura`.`horario` (`id_horario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`residente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`residente` (
  `id_residente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido_m` VARCHAR(45) NULL,
  `apellido_p` VARCHAR(45) NULL,
  `sexo` VARCHAR(45) NULL,
  `tiempo_r` VARCHAR(45) NULL,
  `observacion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_residente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`dieta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`dieta` (
  `id_dieta` INT NOT NULL,
  `tipo_comida` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `porcion` INT NULL,
  `duracion` TIME(0) NULL,
  PRIMARY KEY (`id_dieta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`medico` (
  `rut_medico` INT NOT NULL,
  `nombre_medico` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `profesion` VARCHAR(45) NULL,
  PRIMARY KEY (`rut_medico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`historial_medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`historial_medico` (
  `id_historial` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `fecha_historial` DATE NULL,
  `fecha_proximo_historial` DATE NULL,
  `medico_rut_medico` INT NOT NULL,
  `residente_id_residente` INT NOT NULL,
  PRIMARY KEY (`id_historial`, `medico_rut_medico`, `residente_id_residente`),
  INDEX `fk_historial_medico_medico1_idx` (`medico_rut_medico` ASC),
  INDEX `fk_historial_medico_residente1_idx` (`residente_id_residente` ASC),
  CONSTRAINT `fk_historial_medico_medico1`
    FOREIGN KEY (`medico_rut_medico`)
    REFERENCES `dulzura`.`medico` (`rut_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historial_medico_residente1`
    FOREIGN KEY (`residente_id_residente`)
    REFERENCES `dulzura`.`residente` (`id_residente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`enfermedad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`enfermedad` (
  `id_enfermedad` INT NOT NULL,
  `nombre_sintoma` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_enfermedad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`receta_tratamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`receta_tratamiento` (
  `id_tratamiento` INT NOT NULL,
  `instrucciones` VARCHAR(45) NULL,
  `severidad` VARCHAR(45) NULL,
  `hora_ingesta` TIME(0) NULL,
  `precio_medicamento` INT NULL,
  `dosis` INT NULL,
  `enfermedad_id_enfermedad` INT NOT NULL,
  PRIMARY KEY (`id_tratamiento`, `enfermedad_id_enfermedad`),
  INDEX `fk_receta_tratamiento_enfermedad1_idx` (`enfermedad_id_enfermedad` ASC),
  CONSTRAINT `fk_receta_tratamiento_enfermedad1`
    FOREIGN KEY (`enfermedad_id_enfermedad`)
    REFERENCES `dulzura`.`enfermedad` (`id_enfermedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`gasto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`gasto` (
  `id_gasto` INT NOT NULL,
  `detalle` VARCHAR(45) NULL,
  `total` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`id_gasto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`boleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`boleta` (
  `id_boleta` INT NOT NULL,
  `fecha` DATE NULL,
  `usuario_id_usuario` INT NOT NULL,
  `gasto_id_gasto` INT NOT NULL,
  PRIMARY KEY (`id_boleta`, `usuario_id_usuario`, `gasto_id_gasto`),
  INDEX `fk_boleta_usuario1_idx` (`usuario_id_usuario` ASC),
  INDEX `fk_boleta_gasto1_idx` (`gasto_id_gasto` ASC),
  CONSTRAINT `fk_boleta_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `dulzura`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_boleta_gasto1`
    FOREIGN KEY (`gasto_id_gasto`)
    REFERENCES `dulzura`.`gasto` (`id_gasto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`dieta_residente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`dieta_residente` (
  `id_dieta_residente` INT NOT NULL,
  `residente_id_residente` INT NOT NULL,
  `dieta_id_dieta` INT NOT NULL,
  PRIMARY KEY (`id_dieta_residente`, `residente_id_residente`, `dieta_id_dieta`),
  INDEX `fk_dieta_residente_residente1_idx` (`residente_id_residente` ASC),
  INDEX `fk_dieta_residente_dieta1_idx` (`dieta_id_dieta` ASC),
  CONSTRAINT `fk_dieta_residente_residente1`
    FOREIGN KEY (`residente_id_residente`)
    REFERENCES `dulzura`.`residente` (`id_residente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dieta_residente_dieta1`
    FOREIGN KEY (`dieta_id_dieta`)
    REFERENCES `dulzura`.`dieta` (`id_dieta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`enfermedad_residente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`enfermedad_residente` (
  `id_enfermedad_residente` INT NOT NULL,
  `residente_id_residente` INT NOT NULL,
  `enfermedad_id_enfermedad` INT NOT NULL,
  PRIMARY KEY (`id_enfermedad_residente`, `residente_id_residente`, `enfermedad_id_enfermedad`),
  INDEX `fk_enfermedad_residente_residente1_idx` (`residente_id_residente` ASC),
  INDEX `fk_enfermedad_residente_enfermedad1_idx` (`enfermedad_id_enfermedad` ASC),
  CONSTRAINT `fk_enfermedad_residente_residente1`
    FOREIGN KEY (`residente_id_residente`)
    REFERENCES `dulzura`.`residente` (`id_residente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enfermedad_residente_enfermedad1`
    FOREIGN KEY (`enfermedad_id_enfermedad`)
    REFERENCES `dulzura`.`enfermedad` (`id_enfermedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`residente_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`residente_usuario` (
  `id_residente_usuario` INT NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  `residente_id_residente` INT NOT NULL,
  PRIMARY KEY (`id_residente_usuario`, `usuario_id_usuario`, `residente_id_residente`),
  INDEX `fk_residente_usuario_usuario1_idx` (`usuario_id_usuario` ASC),
  INDEX `fk_residente_usuario_residente1_idx` (`residente_id_residente` ASC),
  CONSTRAINT `fk_residente_usuario_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `dulzura`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_residente_usuario_residente1`
    FOREIGN KEY (`residente_id_residente`)
    REFERENCES `dulzura`.`residente` (`id_residente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dulzura`.`horario_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dulzura`.`horario_usuario` (
  `id_horario_usuario` INT NOT NULL,
  `horario_id_horario` INT NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_horario_usuario`, `horario_id_horario`, `usuario_id_usuario`),
  INDEX `fk_horario_usuario_horario1_idx` (`horario_id_horario` ASC),
  INDEX `fk_horario_usuario_usuario1_idx` (`usuario_id_usuario` ASC),
  CONSTRAINT `fk_horario_usuario_horario1`
    FOREIGN KEY (`horario_id_horario`)
    REFERENCES `dulzura`.`horario` (`id_horario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_usuario_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `dulzura`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into usuario values(1234,"pipe123","felipe1234","12345678-0","felipe","pino","peña",942791316,"trabajador");