CREATE SCHEMA IF NOT EXISTS `ConsumidorProduto` DEFAULT CHARACTER SET utf8 ;
USE `ConsumidorProduto`;

CREATE TABLE IF NOT EXISTS `ConsumidorProduto`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descrição` VARCHAR(150) NOT NULL,
  `quantidade` DECIMAL(3,0) NOT NULL,
  `preço` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`idProduto`));
  
CREATE TABLE IF NOT EXISTS `ConsumidorProduto`.`Consumidor` (
  `idConsumidor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`idConsumidor`));
 
CREATE TABLE IF NOT EXISTS `ConsumidorProduto`.`Compra` (
  `idCompra` INT NOT NULL AUTO_INCREMENT,
  `Produto_idProduto` INT NOT NULL,
  `Consumidor_idConsumidor` INT NOT NULL,
  `dataHora` DATETIME NOT NULL,
  `quantidade` DECIMAL(3,0) NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `fk_Produto_has_Consumidor_Consumidor1_idx` (`Consumidor_idConsumidor` ASC),
  INDEX `fk_Produto_has_Consumidor_Produto_idx` (`Produto_idProduto` ASC),
  CONSTRAINT `fk_Produto_has_Consumidor_Produto`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ConsumidorProduto`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Consumidor_Consumidor1`
    FOREIGN KEY (`Consumidor_idConsumidor`)
    REFERENCES `ConsumidorProduto`.`Consumidor` (`idConsumidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);