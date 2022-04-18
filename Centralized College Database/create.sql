CREATE SCHEMA IF NOT EXISTS `centralizedCollege` DEFAULT CHARACTER SET utf8 ;
USE `centralizedCollege` ;

CREATE TABLE IF NOT EXISTS `centralizedCollege`.`Faculdades` (
  `idFaculdades` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `numeroUnidade` DECIMAL(3,0) NOT NULL,
  `estado` CHAR(2) NOT NULL,
  `detalhesLocalizacao` VARCHAR(150) NOT NULL,
  `dataCriacao` DATE NOT NULL,
  `descricao` VARCHAR(250) NULL,
  PRIMARY KEY (`idFaculdades`));

CREATE TABLE IF NOT EXISTS `centralizedCollege`.`Departamentos` (
  `idDepartamentos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `detalhesLocalizacao` VARCHAR(75) NOT NULL,
  `dataCriacao` DATE NOT NULL,
  `descricao` VARCHAR(250) NULL,
  `Faculdades_idFaculdades` INT NOT NULL,
  PRIMARY KEY (`idDepartamentos`),
  INDEX `fk_Departamentos_Faculdades_idx` (`Faculdades_idFaculdades` ASC) ,
  CONSTRAINT `fk_Departamentos_Faculdades`
    FOREIGN KEY (`Faculdades_idFaculdades`)
    REFERENCES `centralizedCollege`.`Faculdades` (`idFaculdades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `centralizedCollege`.`Cursos` (
  `idCursos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `dataCriacao` DATE NOT NULL,
  `ativo` DECIMAL(1,0) NOT NULL,
  `descricao` VARCHAR(250) NULL,
  `Departamentos_idDepartamentos` INT NOT NULL,
  PRIMARY KEY (`idCursos`),
  INDEX `fk_Cursos_Departamentos1_idx` (`Departamentos_idDepartamentos` ASC) ,
  CONSTRAINT `fk_Cursos_Departamentos1`
    FOREIGN KEY (`Departamentos_idDepartamentos`)
    REFERENCES `centralizedCollege`.`Departamentos` (`idDepartamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `centralizedCollege`.`Pessoas` (
  `idPessoas` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  `cpf` DECIMAL(11,0) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `numeroCelular` DECIMAL(11,0) NOT NULL,
  `numeroTelefoneFixo` DECIMAL(10,0) NOT NULL,
  `tipo` DECIMAL(1,0) NOT NULL,
  PRIMARY KEY (`idPessoas`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  UNIQUE INDEX `numeroCelular_UNIQUE` (`numeroCelular` ASC) ,
  UNIQUE INDEX `numeroTelefoneFixo_UNIQUE` (`numeroTelefoneFixo` ASC) );
 
CREATE TABLE IF NOT EXISTS `centralizedCollege`.`Alunos` (
  `idAlunos` INT NOT NULL AUTO_INCREMENT,
  `Departamentos_idDepartamentos` INT NOT NULL,
  `matricula` DECIMAL(8,0) NOT NULL,
  `Pessoas_idPessoas` INT NOT NULL,
  PRIMARY KEY (`idAlunos`),
  INDEX `fk_Alunos_Departamentos1_idx` (`Departamentos_idDepartamentos` ASC) ,
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC) ,
  INDEX `fk_Alunos_Pessoas1_idx` (`Pessoas_idPessoas` ASC) ,
  CONSTRAINT `fk_Alunos_Departamentos1`
    FOREIGN KEY (`Departamentos_idDepartamentos`)
    REFERENCES `centralizedCollege`.`Departamentos` (`idDepartamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alunos_Pessoas1`
    FOREIGN KEY (`Pessoas_idPessoas`)
    REFERENCES `centralizedCollege`.`Pessoas` (`idPessoas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
CREATE TABLE IF NOT EXISTS `centralizedCollege`.`Estudos` (
  `idEstudos` INT NOT NULL AUTO_INCREMENT,
  `Alunos_idAlunos` INT NOT NULL,
  `Cursos_idCursos` INT NOT NULL,
  `dataInicio` DATE NOT NULL,
  `dataFinal` DATE NOT NULL,
  `nota` DECIMAL(3,1) NOT NULL,
  PRIMARY KEY (`idEstudos`),
  INDEX `fk_Alunos_has_Cursos_Cursos1_idx` (`Cursos_idCursos` ASC) ,
  INDEX `fk_Alunos_has_Cursos_Alunos1_idx` (`Alunos_idAlunos` ASC) ,
  CONSTRAINT `fk_Alunos_has_Cursos_Alunos1`
    FOREIGN KEY (`Alunos_idAlunos`)
    REFERENCES `centralizedCollege`.`Alunos` (`idAlunos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alunos_has_Cursos_Cursos1`
    FOREIGN KEY (`Cursos_idCursos`)
    REFERENCES `centralizedCollege`.`Cursos` (`idCursos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `centralizedCollege`.`Professores` (
  `idProfessores` INT NOT NULL AUTO_INCREMENT,
  `Pessoas_idPessoas` INT NOT NULL,
  PRIMARY KEY (`idProfessores`),
  INDEX `fk_Professores_Pessoas1_idx` (`Pessoas_idPessoas` ASC) ,
  CONSTRAINT `fk_Professores_Pessoas1`
    FOREIGN KEY (`Pessoas_idPessoas`)
    REFERENCES `centralizedCollege`.`Pessoas` (`idPessoas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `centralizedCollege`.`Lecionamentos` (
  `idLecionamentos` INT NOT NULL AUTO_INCREMENT,
  `Cursos_idCursos` INT NOT NULL,
  `Professores_idProfessores` INT NOT NULL,
  `dataInicio` DATE NOT NULL,
  `dataFinal` DATE NULL,
  `diaSemana` DECIMAL(1,0) NOT NULL,
  `periodo` DECIMAL(1,0) NOT NULL,
  `cargaHoraria` DECIMAL(1,0) NOT NULL,
  INDEX `fk_Cursos_has_Professores_Professores1_idx` (`Professores_idProfessores` ASC) ,
  INDEX `fk_Cursos_has_Professores_Cursos1_idx` (`Cursos_idCursos` ASC) ,
  PRIMARY KEY (`idLecionamentos`),
  CONSTRAINT `fk_Cursos_has_Professores_Cursos1`
    FOREIGN KEY (`Cursos_idCursos`)
    REFERENCES `centralizedCollege`.`Cursos` (`idCursos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_has_Professores_Professores1`
    FOREIGN KEY (`Professores_idProfessores`)
    REFERENCES `centralizedCollege`.`Professores` (`idProfessores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);