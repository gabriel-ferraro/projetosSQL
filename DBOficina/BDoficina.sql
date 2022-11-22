create schema oficina;
use oficina;
create table clientes
(
cpf char(11) primary key, 
nome varchar(144),
Email varchar(144)
);
create table automoveis
(
placa char(8) primary key,
ano int,
modelo varchar(72),
cor varchar(72),
cpfCliente char(11),
foreign key(cpfCliente) references clientes(cpf) 
);
#criar a table serviços
create table servicos
(
cod_servico char(10) primary key,
servico varchar(144),
preco decimal(9,2)
);
#criar tabela ordem de servicos
create table ordemServicos
(
num_ordem_servicos char(10) primary key,
placa char(8),
data_realizacao date,
observacoes text,
foreign key(placa) references automoveis (placa)
);
#criar tabela detalhes_ordens_servicos 
create table  detalhes_ordens_servicos
(
num_ordem_servico char(10),
cod_servico char(10),
observacoes text,
foreign key(num_ordem_servico) references ordemServicos(num_ordem_servicos),
foreign key(cod_servico) references servicos(cod_servico)
);
#criar a tabela contas a receber
create table contas_receber 
(
num_titulo_receber int primary key,
valor numeric(9,2),
situacao text,
cpf char(11),
foreign key(cpf) references clientes(cpf)
);

