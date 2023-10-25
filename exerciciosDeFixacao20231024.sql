USE exercicios_trigger;

/*Crie um trigger que, após inserir um novo cliente na tabela Clientes, 
insira uma mensagem na tabela Auditoria informando a data e hora da inserção.*/

create trigger inserir_novo_cliente AFTER INSERT on clientes for each row 
INSERT INTO auditoria 
values ('novo cliente adicionado as '); 

/*Antes de excluir um cliente da tabela Clientes, 
crie um trigger que insira uma mensagem na tabela Auditoria informando sobre a tentativa de exclusão.*/

create trigger deletar_cliente before delete on clientes for each row 
INSERT INTO auditoria 
values ('houve uma tentativa de deletar um cliente as '); 
