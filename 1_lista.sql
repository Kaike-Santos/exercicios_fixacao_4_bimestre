CREATE DATABASE IF NOT EXISTS FixacaoFuncoes ; 
USE FixacaoFuncoes ;

-- Crie uma tabela nomes com uma coluna nome contendo os seguintes nomes:Roberta Roberto Maria Clara João 
CREATE TABLE Nomes 
(nome VARCHAR(255) NOT NULL);
INSERT INTO Nomes
VALUES 
('Roberta'),
('Roberto'),
('Maria Clara'),
('João');
SELECT * from Nomes;


-- Utilize a função UPPER() para converter todos os nomes para maiúsculas. 
SELECT UPPER(Nome) as NomeMaiusculo 
from Nomes ; 

-- Use a função LENGTH() para determinar o tamanho de cada nome.
SELECT Nome , length(Nome) as TamanhoNome
from Nomes ;

--  Use a função CONCAT() para adicionar "Sr. " antes dos nomes masculinos e "Sra. " antes dos nomes femininos. 
SELECT 
CASE 
WHEN nome LIKE '%o' THEN CONCAT('Sr',Nome) 
WHEN nome LIKE '%a' THEN CONCAT('Sra',Nome) 
END AS NomeConcat
from Nomes;
-- Crie uma tabela produtos com as colunas produto, preco e quantidade. 
drop table produtos; 
CREATE TABLE IF NOT EXISTS Produtos  
(produto VARCHAR(255) NOT NULL, preco decimal(10,3) NOT NULL, quantidade int NOT NULL);
INSERT INTO Produtos
VALUES 
('produto_1', 100.190 , 10),
('produto_2', 200.128 , 5),
('produto_3', 50.098 , 20),
('produto_4', 1000.101 , 2);
select * from produtos ;
-- Utilize a função ROUND() para arredondar os preços para 2 casas decimais.
SELECT ROUND(preco,2) 
FROM produtos;
-- Use a função ABS() para exibir o valor absoluto das quantidades.
SELECT ABS(quantidade)
FROM produtos;
-- Calcule a média dos preços dos produtos utilizando a função AVG().
SELECT ROUND(AVG(preco),2) AS media_preco
FROM produtos;
-- Crie uma tabela eventos com uma coluna data_evento contendo algumas datas.
DROP TABLE IF EXISTS eventos;
CREATE TABLE IF NOT EXISTS eventos 
(evento VARCHAR(255) NOT NULL, data_evento datetime);
INSERT INTO eventos
VALUES 
('evento_1', '2006-10-10 12:30:30'),
('evento_2','2006-10-24 00:40:00'),
('evento_3','2006-10-16 16:56:00'),
('evento_4','2006-10-12 09:15:45'),
('evento_5','2006-10-08 17:43:59'),
('evento_6','2006-10-31 23:58:58');
SELECT * FROM eventos ; 
-- Utilize a função NOW() para inserir a data e hora atual em uma nova linha.
INSERT INTO eventos
VALUES 
('agora' , NOW());
-- Use a função DATEDIFF() para calcular o número de dias entre duas datas.
SELECT evento, DATEDIFF(data_evento, '2006-10-10') AS numero_de_dias
FROM eventos;
-- Utilize a função DAYNAME() para exibir o nome do dia da semana de cada evento.
SELECT evento, data_evento, DAYNAME(data_evento) AS nome_dia_semana
FROM eventos;
-- Em sua tabela produtos, use a função IF() para determinar se um produto está "Em estoque" ou "Fora de estoque" 
-- baseado na quantidade (e.g., se a quantidade for 0, está "Fora de estoque").
SELECT produto , quantidade ,
if(quantidade = 0 , 'fora de estoque' , 'em estoque') as status_estoque 
FROM produtos ;
-- Use a função CASE para classificar os produtos em categorias de preço: "Barato", "Médio" e "Caro".
SELECT produto , preco ,
case 
when preco > 500 then 'caro' 
when preco between 60 and  500 then 'medio' 
else 'barato' 
end as classificacao_produto
FROM produtos ;
-- Crie uma função chamada TOTAL_VALOR que receba preço e quantidade, e retorne o valor total.
delimiter //
CREATE FUNCTION TOTAL_VALOR(preco decimal(10,3), qtt INT) RETURNS INT
NOT DETERMINISTIC
READS SQL DATA 
BEGIN
RETURN preco * qtt;
END;
//
delimiter ;
SELECT TOTAL_VALOR(10,5);
--  Use esta função para calcular o valor total de cada item em sua tabela produtos.
SELECT produto , preco , quantidade , TOTAL_VALOR(preco, quantidade) AS valor_total
FROM Produtos;
-- Conte o número total de produtos usando a função COUNT().
SELECT count(produto) as qtt_produtos
FROM produtos;
-- Determine o produto mais caro usando a função MAX().
SELECT produto , preco 
from produtos 
WHERE preco = (select MAX(PRECO) FROM produtos);
--  Determine o produto mais barato usando a função MIN().
SELECT produto , preco 
from produtos 
WHERE preco = (select min(PRECO) FROM produtos);
-- Calcule a soma total dos produtos em estoque utilizando as funções SUM() e IF().
SELECT SUM( if(quantidade > 0 , preco * quantidade , 0 ) ) as soma_total
from produtos ;
--  Crie uma função que retorno o Fatorial de um número. Ex.: 5! = 5.4.2.1
delimiter //
CREATE FUNCTION fatorial(nmr INT) RETURNS INT
NOT DETERMINISTIC
READS SQL DATA 
BEGIN
    DECLARE resultado INT DEFAULT 1;
    DECLARE i INT;
    SET i = 1;
    
    WHILE i <= nmr DO
        SET resultado = resultado * i;
        SET i = i + 1;
    END WHILE;
    
    RETURN resultado;
END;
//
delimiter ; 
select fatorial(5);
-- Crie uma função que qualcule o exponencial de um número. Ex.: f_exponencial(2, 3) = 2³ = 8
delimiter //
CREATE FUNCTION Exponencial(base INT , expoente INT) RETURNS INT
NOT DETERMINISTIC
READS SQL DATA 
BEGIN
    DECLARE resultado int DEFAULT 1;
    DECLARE i INT;
    SET i = 1;
    
    WHILE i <= expoente DO
        SET resultado = resultado * base;
        SET i = i + 1;
    END WHILE;
    
    RETURN resultado;
END;
//

DELIMITER ;
select Exponencial(2, 3);
--  Crie uma função que verifica se uma palavra é palíndromo ou não. Retorne 1 se for palíndromo ou 0 se não for.
DELIMITER //

CREATE FUNCTION Palindromo(palavra VARCHAR(255)) RETURNS INT
NOT DETERMINISTIC
READS SQL DATA 
BEGIN
    DECLARE palavra_invertida VARCHAR(255);
    
    SET palavra_invertida = REVERSE(palavra);
    
    IF palavra = palavra_invertida THEN
        RETURN 1; -- É um palíndromo
    ELSE
        RETURN 0; -- Não é um palíndromo
    END IF;
END;
//

DELIMITER ;
select palindromo ('ovo');
