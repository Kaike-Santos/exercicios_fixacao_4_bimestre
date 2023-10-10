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
