#Trabalho prático de Banco de Dados com o BD Northwind

use northwind;

#1. Retornar os dados sobre os produtos comprados por cada cliente (Id do cliente,
#nome completo do cliente, id do produto, nome do produto, quantidade comprada,preço pago)

select	c.id,
		concat(c.first_name, ' ', c.last_name);
        
#17. Desenvolva uma view que retorne um relatório com as médias vendidas diariamente 
#(considere os dados do vendedor, do cliente, do produto e a data da venda)

#orders->customers
#orders->employees
#orders->order_details
#order_details-products

create view vw_relatorio_vendas as
select	o.order_date,
		concat(e.first_name, ' ', e.last_name) as employee,
		concat(c.first_name, ' ', c.last_name) as customer,
        p.product_name,
        avg(od.quantity * od.unit_price) as average_subtotal
		from orders o
        inner join customers c on o.customer_id = c.id
        inner join employees e on o.employee_id = e.id
        inner join order_details od on o.id = od.order_id
        inner join products p on od.product_id = p.id
        group by o.order_date,
				 employee,
				 customer,
				 p.product_name;
                 
		select * from vw_relatorio_vendas
        
#18. Mini desafio: Desenvolva uma stored procedure que receba duas datas e realize o seguinte procedimento
#a. A segunda data deve ser maior que a primeira, Caso contrário, retorne um erro
#b. Retornar um relatório de vendas (utilize a View de vendas) que estejam entre as datas informadas (intervalo fechado)

DELIMITER $$
create procedure SP_relatorio_de_vendas(dt_ini date, dt_fin date)
begin
	if dt_ini>=dt_fin then select'Erro!';
    else
		select * from vw_relatorio_vendas where order_date between dt_ini and dt_fin order by order_date;
	end if;
end $$
delimiter ;

call SP_relatorio_de_vendas('2006-01-15','2006-02-23')