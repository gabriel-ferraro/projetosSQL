#drop database vento_do_norte
create database vento_do_norte;
use vento_do_norte;

create table clientes
(
cpf char(11) primary key,
nome varchar(144),
email varchar(144)
);

create table metodos_pagamento
(
metodos_pagamento varchar(20),
cpf_cliente char(11),
foreign key(cpf_cliente) references clientes(cpf)
);

create table enderecos
(
rua varchar(72),
numero char(10),
CEP varchar(72),
bairro varchar(72),
cidade varchar(72),
complemento varchar(144),
cpf_cliente char(11),
foreign key(cpf_cliente) references clientes(cpf)
);

create table telefones
(
DDD char(2),
numero char(10),
tipo varchar(20),
cpf_cliente char(11),
foreign key(cpf_cliente) references clientes(cpf)
);

create table pessoa_juridica
(
cnpj char(14) primary key,
razao_social varchar(144),
nome_fantasia varchar(144)
);

create table enderecos_pessoa_juridica
(
rua varchar(72),
numero char(10),
CEP varchar(72),
bairro varchar(72),
cidade varchar(72),
uf char(2),
cnpj_PJ char(14), 
foreign key(cnpj_PJ) references pessoa_juridica(cnpj)
);

create table pessoa_contato
(
email varchar(144) primary key,
nome varchar(144),
cnpj_PJ char(14),
foreign key(cnpj_PJ) references pessoa_juridica(cnpj)
);

create table telefones_pessoa_contato
(
DDD char(2),
numero char(10),
tipo varchar(20),
email_pessoa_contato varchar(144),
foreign key(email_pessoa_contato) references pessoa_contato(email)
);

create table categoria
(
categoria char(4) primary key,
descricao varchar(144)
);

create table produtos
(
cod_produto char(10) primary key,
cod_categoria char(4),
cod_barras char(10),
nome varchar(72),
descricao varchar(72),
preco_lista numeric(9,2),
foreign key(cod_categoria) references categoria(categoria)
);

create table fornecedor_produto #(pessoa_juridicaXprodutos)
(
cod_produto char(10),
cnpj_PJ char(14),
foreign key(cod_produto) references produtos(cod_produto),
foreign key(cnpj_PJ) references pessoa_juridica(cnpj)
);

create table funcionarios
(
cpf char(11) primary key,
nome varchar(72),
email varchar(72),
telefone char(9)
);

create table compras #(pessoa_juridicaXfuncionarios)
(
numero_pedido int primary key,
cod_fornecedor char(14),
cpf_funcionario char(11),
data_compra date,
foreign key(cod_fornecedor) references pessoa_juridica(cnpj), 
foreign key(cpf_funcionario) references funcionarios(cpf)
);

create table produtos_comprados #(comprasXprodutos)
(
cod_produto_produtos char(10),
numero_pedido_compras int,
qtde int,
preco numeric(9,2),
foreign key(numero_pedido_compras) references compras(numero_pedido),
foreign key(cod_produto_produtos) references produtos(cod_produto)
);