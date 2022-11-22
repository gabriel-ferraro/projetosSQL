use northwind;
#Tabela employees
describe employees;

#Listar id, primeiro nome e sobre nome de employees
Select id,  first_name, last_name from employess;

#Listar id e concatenar primeiro nome e sobre nome de employess
Select 	id, 
			concat(first_name,' ', last_name) as Nome
            from employees;
            
#Listar todos os funcionario com id =2 
Select 	id,
			concat(first_name,' ', last_name) as nome
            from employees
            where id =2; 
            
#Listar os empregados com codigos {3,4,6}
Select 	id, 
			first_name 
			from employees            
            where id in (3,4,6);
            #where concat(id = 2, id = 3, id = 4)

#Listar funcionior cujo id seja maior que 3            
Select 	id, 
			first_name 
			from employees            
			where id > 3;
            
 #Listar funcionarios cujo id seja diferente de 3
 Select 	id, 
			first_name 
			from employees            
            where id != 3;
            
#Listar funcionario ordenado por primeiro nome (A-Z)
 Select 	id, 
			first_name 
			from employees            
            order by first_name;
		
#Listar funcionario ordenado por id crescente
Select 	id, 
			first_name 
			from employees            
            order by id;

#Selecionar as vendas (10 primeiros registros)
select * from orders limit 10;
#Selecionar as vendas em ordem de data
select * from orders order by order_date;

#Selecionar as vendas em ordem de data da mais recente 
# para a mais antiga (decrescente)
select * from orders order by order_date desc;

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
insert into teste_datas values ('2020/10/21','2020/10/21 21:41','21:42');
select * from teste_datas;

#Selecionar as 10 primeiras linhas da tabela order_details
select * from order_details limit 10;
#Selecionar id, order_id, product_id e calcular o subtotal (quantity * unit_price)
select 	id,
			order_id,
			product_id,
            (quantity * unit_price) as subtotal
            from order_details;
            
#Total vendido pela empresa
select
			sum(quantity*unit_price)
            from order_details;


#Listar o total faturado por venda
Select
		order_id,
		sum(quantity*unit_price) as faturamento,
        avg(quantity*unit_price) as faturamento_medio
		from order_details
        group by order_id;
        
###############################

select * from inventory_transaction_types;
##
select distinct(transaction_type) from inventory_transactions;
##
select 	it.id,
		it.transaction_type,
        itt.type_name,
        p.product_name
        
        from inventory_transaction_types itt
        inner join inventory_transactions it
			on itt.id=it.transaction_type
		inner join products p
			on p.id=it.product_id;
##

#A tabalea Purchase_orders possui 3 chaves estrangeiras.
#Crie um select que mostre as descricoes ou nomes relativos a essa chaves
#Por exemplo, supplier_id eh o codigo do fornecedor, 
#mostre o nome desse fornecedor no resultado do seu select
#Realize o mesmo para as demais chaves estrangeiras da tabela Purchase_orders

select 
	po.supplier_id, 
    s.first_name
    from purchase_orders po
    inner join suppliers s on po.supplier_id=s.id;
##

select 
	po.supplier_id, 
    sup.first_name
    from purchase_orders po
    inner join suppliers sup
		on po.supplier_id = sup.id;

select 
	po.created_by,
    emp.first_name
    from purchase_orders po
    inner join employees emp
		on po.created_by = emp.id;
        
select
	po.status_id,
	pos.status
    from purchase_orders po
    inner join purchase_order_status pos
		on po.status_id = pos.id;
describe employees;
##

select 	o.id,
		o.order_date,
        o.employee_id,
        e.first_name
        from orders o
		right join employees e on o.employee_id=e.id;
################################### aula 04/11

create view vw_vendas as
select	o.id,
		o.order_date,
		concat(e.first_name, '', e.last_name) as vendedor,
		concat(c.first_name, '', c.last_name) as cliente
        from orders o
        inner join employees e on o.employee_id = e.id
        inner join customers c on o.customer_id = c.id;
        
select * from vw_vendas where month(order_date) = 3;

### alterar a view de vendas, adicionando a situação(código e descrição)
#drop view vw_vendas;
create view vw_vendas as
select	o.id,
		o.order_date,
		concat(e.first_name, '', e.last_name) as vendedor,
		concat(c.first_name, '', c.last_name) as cliente,
        from orders o
        inner join employees e on o.employee_id = e.id
        inner join customers c on o.customer_id = c.id,
        inner join 
        
###

DELIMITER $$
create procedure SP_Set_Privileges(employee int, privilege int)
	begin
		insert into employee_privileges values (employee, privilege);
	end $$
    
DELIMITER ;

call SP_Set_Privileges(1,3);
select * from employee_privileges;

### 
#ATIVIDADE --- com o banco do norte, criar uma stored procedure que receba:
#cpf,nome,email,ddd,telefone
#a chamada ficará: 
#call call_sp_insere_cliente(
#								'1212',
#								'Anderson Silva,
#								'anderson@hotmail.com',
#								'44',
#								'12345678')

#use vento_do_norte;
#drop procedure sp_insere_cliente;
DELIMITER $$
create procedure sp_insere_cliente(cod_cliente char(10), nome varchar(72), email varchar(144))
	begin
		insert into clientes values (cod_cliente,nome,email);
	end $$
    
DELIMITER ;

call sp_insere_cliente(1234567891,'asd','aaa@aaa');
select * from clientes

#store procedure que recebe um valor e retorna seu quadrado TERMINAR

DELIMITER $$
create procedure sp_insere_cliente(cod_cliente char(10), nome varchar(72), email varchar(144))
	begin
		insert into clientes values (cod_cliente,nome,email);
	end $$
    
DELIMITER ;

### 18/11 ###

