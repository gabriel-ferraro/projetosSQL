#exemplo date
#Selecionar employee_id e mes da venda
select 	employee_id, 
			day(order_date) as order_day,
			month(order_date) as order_month,
            year(order_date) as order_year,
            dayofweek('2020/10/21') as order_day_of_week,
            weekofyear('2020/10/21') as semana_do_ano
            #dia da semana
            #semana do ano
            from orders;

#EXEMPLO DE CAMPOS 
#DO TIPO DATE, DATETIME E TIME
#Datas (com hora e sem hora)
drop table teste_datas;
create table teste_datas
(
	dt1 date, #O campo tera  AAAA/MM/DD
    dt2 datetime,#O campo tera  AAAA/MM/DD HH:mm:ss
    hora time #O campo tera  HH:mm:ss
);
#########################################################

#Exemplo inner join 

select	nomeTabela1atributo1, #que é chave primária da tabela primária
		nomeTabela2atributo2,
		from nomeTabela1 alias#PK da tabela primária
		inner join nomeTabela2 alias #FK na tabela secundária que herdou a chave acima
		on nomeTabela1.atributo1 = nomeTabela2.atributo2;
        
#########################################################        

#Exemplo de view que retorna o nome completo do vendedor, as vendas, o nome completo do cliente 
#e a data das vendas. Usando northwind, tabelas orders(para vendas e data da venda) e  customers(nome completo
#do cliente) e nome do vendedor completo do vendedor (emplyoees)

#exemplo view 1
create view vw_vendas as 
select 	o.id,
		o.order_date,
        concat(e.first_name, ' ', e.last_name) as vendedor,
        concat(c.first_name, ' ', c.last_name) as cliente
        from orders o
        inner join employees e on o.employee_id = e.id
        inner join customers c on o.customer_id = c.id;

#usando a view:
#select * from vw_vendas where  cliente = 'Karen Toh';
#select * from vw_vendas where month(order_date) = 1;

#########################################################

#view de vendas retornando o nome dos vendedores, clientes, data da venda e id do vendedor
#exemplo view 2
create view vw_vendas as 
select 	o.id,
		o.order_date,
        concat(e.first_name, ' ', e.last_name) as vendedor,
        concat(c.first_name, ' ', c.last_name) as cliente
        from orders o
        inner join employees e on o.employee_id = e.id
        inner join customers c on o.customer_id = c.id;
        
#########################################################

#STORED PROCEDURES - APLICAÇÃO DE PROCESSOS LÓGICOS E SENSIBILIZAÇÃO DOS DADOS NO BD (SÃO ARMAZENADAS NO SGBD)
#Exemplo: Criar uma stored procedure altere as permissões de um funcionário a partir do id do funcionário 
#(employees) e do id da permissão  (privileges)
SP_set_privileges
DELIMITER $$
create procedure SP_set_privileges(employee int, privilege int)
	begin
		insert into employee_privileges values(employee, privilege);
	END $$
DELIMITER ;

call SP_set_privileges(3,3);
select * from employee_privileges;
#########################################################
        
#Exemplo função recebe valor e retorna classificação da idade

DELIMITER $$
create function set_idade(_idade int)
returns varchar(20)
DETERMINISTIC
begin
	declare _result varchar(20);
    if _idade<=17 and _idade>=1 then
		set _result='menor idade';
        elseif _idade>=18 and _idade<=124 then
			set _result='maior idade';
		elseif _idade>=125 then
			set _result='muito alto';
		elseif _idade<1 then
			set _result='muito baixo';
	end if;
	return _result;
end $$
DELIMITER ;

select set_idade(-5)

#########################################################
