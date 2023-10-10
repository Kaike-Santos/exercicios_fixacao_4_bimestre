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