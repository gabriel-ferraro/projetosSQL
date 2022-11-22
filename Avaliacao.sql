#Atividade avaliativa Banco de Dados

use northwind;

#1. Crie um script para retornar o nome completo, cidade (City), estado (province) dos
#clientes, com os respectivos produtos comprados (código do produto, nome do
#produto, quantidade, preço unitário e subtotal) e o nome completo do vendedor.
#Lembre-se de que a tabela que contem as vendas é a tabela Orders.

select	o.id,
		concat(c.first_name, ' ', c.last_name) as cliente,
        c.city,
        c.state_province,
        p.product_code,
        p.product_name,
        od.quantity,
        od.unit_price,
		(od.quantity * od.unit_price) as subtotal,
        concat(e.first_name, ' ', e.last_name) as vendedor
        from orders o
        inner join customers c on o.customer_id = c.id
        inner join order_details od on od.order_id = o.id
        inner join products p on od.product_id = p.id
		inner join employees e on o.employee_id = e.id
        order by o.id;

#2. Crie um script para retornar os dados dos clientes (customers) para os quais não
#foram registradas vendas (orders)

Select	c.id,
		concat(c.first_name, ' ', c.last_name) as cliente,
		count(o.id) as compras
		from customers c
		left join orders o on c.id = o.customer_id
		where o.id is null 
		group by	cliente,
					c.id
		order by c.id;

#3. Crie um script para alterar o job_title do cliente (customers) para “Owner" do
#cliente cujo id é 23.

update customers 
		set job_title= 'Owner'
		where id = '23';

#4. Crie um script que exclua os privilégios (employee_privileges) do funcionário de id = 9

delete from employee_privileges
			where employee_id=9;

#5. A tabela inventory_transaction_types possui os tipos de movimento que podem ser
#realizados com os produtos em estoque. 
#Purchased é uma compra e soma itens ao estoque
#Sold é venda e subtrai itens ao estoque
#On Hold é uma reserva e subtrai itens ao estoque
#Waste é uma perda e subtrai itens ao estoque
#Os movimentos dos produtos (Compras, vendas e demais transações) estão gravados
#na tabela invetory_transactions.
#Desenvolva uma função que receba a chave do produto e retorne a quantia de itens
#em estoque, dadas as movimentações (inventory_transactions) que o produto sofreu

Create view vw_estoque as
select	it.product_id,
        prod.product_name,
		sum(
			if(transaction_type = 1, it.quantity, -it.quantity )) as estoque
		from inventory_transactions it
		inner join products prod on it.product_id = prod.id;
        
select * from vw_estoque;

#6. Desenvolva uma stored procedure que altere a situação (status_id) da ordem de
#compra (purchase_orders). Este procedimento deve receber o número da ordem
#de compra (purchase_orders) e o id da situação (purchase_order_status). O
#procedimento não deve aceitar situações (status) que não existam na tabela purchase_order_status.

DELIMITER $$
create procedure SP_alterar_situacao_compra (idPO int, idPO_status int)
begin
	update purchase_orders
		set status_id = idPO_status
	where id = idPO;
END $$
DELIMITER ;

select id, status_id from purchase_orders;
call SP_alterar_situacao_compra(146,1);

#7. Desenvolva uma view que será utilizada como base de um relatório de estoque.
#Devem ser retornados os dados sobre os produtos e suas respectivas quantidades em estoque.

create view	vw_relatorio_estoque as
select	it.id as it_id,
		p.product_name,
        p.product_code,
		p.quantity_per_unit,
		it.transaction_created_date,
		itty.type_name,
        it.quantity,
        pod.unit_cost
		from products p
        inner join inventory_transactions it on p.id=it.product_id
        inner join purchase_order_details pod on p.id=pod.product_id
        inner join inventory_transaction_types itty on  it.transaction_type=itty.id
		where transaction_type = 1;

#8. Crie um script que retorne a quantidade total e valor (em moeda) total vendidos
#para cada produto e por cada vendedor.

select	od.product_id, 
		p.product_name,
        od.quantity, 
        od.unit_price,
		(od.quantity * od.unit_price) as total,
        concat(e.first_name, ' ', e.last_name) as vendedor
		from orders o
		inner join customers c on o.customer_id=c.id
		inner join employees e on o.employee_id=e.id
		inner join  order_details od on o.id=od.order_id
        inner join products p on od.product_id=p.id
        order by vendedor;
        
#9. Crie um script que retorne o faturamento (total vendido em moeda) da empresa mês a mês.
        
select	month(o.order_date) as mes, 
        sum(od.quantity * od.unit_price) as faturamento
		from order_details od
		inner join orders o on order_date
		group by mes
		order by mes;
        
#10.Crie um script que retorne a quantidade de clientes atendidos por cada vendedor.
#Adicione os dados do vendedor a esse script.

select	concat(e.first_name, ' ', e.last_name) as vendedor,
		count(c.first_name) as clientes
		from orders o
		inner join customers c on o.customer_id = c.id
		inner join employees e on o.employee_id = e.id
		group by vendedor
		order by vendedor;