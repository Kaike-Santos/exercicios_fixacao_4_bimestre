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

/*Após atualizar o nome de um cliente na tabela Clientes,
 insira uma mensagem na tabela Auditoria mostrando o nome antigo e o novo nome.*/

create trigger atualizar_nome_cliente after UPDATE on clientes for each row 
INSERT INTO auditoria 
values ('houve uma alteração no nome de um cliente , o nome antigo era ', old.nome ,'e agora é ', NEW.nome);

/*Não permita que o nome do cliente seja atualizado para uma string vazia ou NULL.
 Se alguém tentar fazer isso, o trigger deve impedir a atualização e inserir uma mensagem na tabela Auditoria.*/
 
 delimiter //
create trigger barrar_nome_nulo BEFORE UPDATE on clientes for each row 
if NEW.nome is null or NEW.nome = '' then 
set NEW.nome = OLD.nome;
INSERT INTO auditoria values ('houve uma tentativa de colocar um nome nulo de um cliente , o nome permanece o mesmo');  
end if;
//
delimiter ; 

/*Em uma loja, ao inserir um novo pedido na tabela Pedidos,
o estoque do produto em questão, presente na tabela Produtos, deve ser decrementado.
Se o estoque ficar abaixo de 5 unidades, uma mensagem deve ser inserida na tabela Auditoria.*/

DELIMITER //
create trigger decrementar_estoque after insert on pedidos for each row 
BEGIN
UPDATE produtos 
set quantidade = quantidade - 1;

if quantidade.produto < 5 then 
INSERT INTO auditoria 
values ('o produto tem apenas ', quantidade ,'unidades restantes');
end if ;
end;
//
DELIMITER ;
