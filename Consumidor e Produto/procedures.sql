--Selecionar todos os produtos
/*DROP procedure IF EXISTS `selecionarTodosProdutos`; 
DELIMITER //
CREATE PROCEDURE selecionarTodosProdutos()
BEGIN
	select * FROM consumidorproduto.produto;
END;//
DELIMITER ;
CALL selecionarTodosProdutos();*/

--Selecionar os 5 consumidores que mais gastaram dinheiro em compra de produtos
/*DROP procedure IF EXISTS `selecionarConsumidoresQueMaisGastaram`; 
DELIMITER //
CREATE PROCEDURE selecionarConsumidoresQueMaisGastaram()
BEGIN
	select C1.idConsumidor, C1.nome, SUM(C2.quantidade * P1.preço) 'Dinheiro' from `consumidorproduto`.`consumidor` C1 inner join `consumidorproduto`.`compra` C2 on 	C1.idConsumidor = C2.Consumidor_idConsumidor inner join `consumidorproduto`.`produto` P1 on C2.Produto_idProduto = P1.idProduto group by C1.idConsumidor order by SUM(C2.quantidade * P1.preço) desc LIMIT 5;
END;//
DELIMITER ;
CALL selecionarConsumidoresQueMaisGastaram();*/

--Mostrar dados relacionados a venda sobre produtos
/*DROP procedure IF EXISTS `informacoesSobreVendaDeProdutos`; 
DELIMITER //
CREATE PROCEDURE informacoesSobreVendaDeProdutos()
BEGIN
	select P1.idProduto, P1.nome, SUM(C2.quantidade * P1.preço) 'Dinheiro', SUM(C2.quantidade) 'Quantidade vendida' from `consumidorproduto`.`compra` C2 inner join `consumidorproduto`.`produto` P1 on C2.Produto_idProduto = P1.idProduto group by P1.idProduto order by P1.idProduto;
END;//
DELIMITER ;
CALL informacoesSobreVendaDeProdutos();*/

--Cadastrar produto
/*DROP procedure IF EXISTS `cadastrarProduto`; 
DELIMITER //
CREATE PROCEDURE cadastrarProduto(IN nome VARCHAR(45), IN descrição VARCHAR(150), quantidade DECIMAL(3,0), preço DECIMAL(6,2))
BEGIN
	INSERT INTO `consumidorproduto`.`produto` (`idProduto`, `nome`, `descrição`, `quantidade`, `preço`) VALUES (NULL, nome, descrição, quantidade, preço);
    SELECT * from `consumidorproduto`.`produto` P1 where P1.idProduto = LAST_INSERT_ID();
END;//
DELIMITER ;
CALL cadastrarProduto('Produto 6','Descrição do Produto 6',50,'14.99');*/

--Cadastrar consumidor
/*DROP procedure IF EXISTS `cadastrarConsumidor`; 
DELIMITER //
CREATE PROCEDURE cadastrarConsumidor(IN nome VARCHAR(70))
BEGIN
	INSERT INTO `consumidorproduto`.`consumidor` (`idConsumidor`, `nome`) VALUES (NULL, nome);
    SELECT * from `consumidorproduto`.`consumidor` C1 where C1.idConsumidor = LAST_INSERT_ID();
END;//
DELIMITER ;
CALL cadastrarConsumidor('João');*/

--Cadastrar compra
/*DROP procedure IF EXISTS `cadastrarCompra`; 
DELIMITER //
CREATE PROCEDURE cadastrarCompra(IN idConsumidor INT, IN idProduto INT, IN quantidade DECIMAL(3,0))
BEGIN
	INSERT INTO `consumidorproduto`.`compra` (`idCompra`, `Produto_idProduto`, `Consumidor_idConsumidor`, `dataHora`, `quantidade`) VALUES (NULL, idProduto, idConsumidor, now(), quantidade);
    UPDATE `consumidorproduto`.`produto` P1 SET P1.quantidade = (P1.quantidade - quantidade) WHERE P1.idProduto = idProduto;
    Select P1.idProduto, P1.nome, P1.quantidade from `consumidorproduto`.`produto` P1 where P1.idProduto = idProduto;
    Select * from `consumidorproduto`.`compra` C2 where C2.idCompra = LAST_INSERT_ID();
END;//
DELIMITER ;
CALL cadastrarCompra(1,7,2);*/