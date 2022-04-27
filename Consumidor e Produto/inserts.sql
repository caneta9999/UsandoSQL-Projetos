INSERT INTO `consumidorproduto`.`consumidor` (`idConsumidor`, `nome`) VALUES (NULL, 'André'), (NULL, 'Maria'), (NULL, 'Carlos'), (NULL, 'Ana'), (NULL, 'Larissa'), (NULL, 'Lucas'), (NULL, 'Fernando'), (NULL, 'Fernanda'), (NULL, 'Marcos'), (NULL, 'Clara');
INSERT INTO `consumidorproduto`.`produto` (`idProduto`, `nome`, `descrição`, `quantidade`, `preço`) VALUES (NULL, 'Produto 1', 'Descrição do Produto 1', '30', '49.99'), ('Descrição', 'Produto 2', 'Descrição do Produto 2', '60', '9.99'), (NULL, 'Produto 3', 'Descrição do Produto 3', '100', '5.99'), (NULL, 'Produto 4', 'Descrição do Produto 4', '10', '125'), (NULL, 'Produto 5', 'Descrição do Produto 5', '10', '200');
INSERT INTO `consumidorproduto`.`compra` (`idCompra`, `Produto_idProduto`, `Consumidor_idConsumidor`, `dataHora`, `quantidade`) VALUES (NULL, '6', '4', now(), '2'), (NULL, '6', '3', now(), '2'), (NULL, '8', '5', now(), '4'), (NULL, '10', '8', now(), '1'), (NULL, '10', '3', now(), '1'), (NULL, '8', '2', now(), '3'), (NULL, '6', '5', now(), '1'), (NULL, '10', '10', now(), '1'), (NULL, '9', '5', now(), '1'), (NULL, '8', '7', now(), '2'), (NULL, '10', '7', now(), '1'), (NULL, '6', '1', now(), '1'), (NULL, '10', '6', now(), '1'), (NULL, '8', '6', now(), '2'), (NULL, '6', '4', now(), '1');