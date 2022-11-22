#drop schema uniLE
create schema uniLE;
use uniLE;

create table responsavel_financeiro
(
cpf char(11) primary key,
nome varchar(144)
);

create table alunos
(
cpf char(11) primary key,
nome varchar(144),
contrato varchar(144),
cpf_responsavel_financeiro char(11),
foreign key(cpf_responsavel_financeiro) references responsavel_financeiro(cpf)
);

create table professores
(
cpf char(11) primary key,
nome varchar(144),
ddd char(2),
telefone char(9)
);

create table disciplinas
(
cod_disc char(4) primary key,
disciplina varchar(144),
carga_horaria int
);

create table livros
(
isbn varchar(13) primary key,
nome varchar(144),
autor varchar(144),
categoria varchar(144)
);

create table enderecos_aluno
(
pais varchar(144),
cidade varchar(144),
cep char(8),
rua int,
cpf_aluno char(11),
foreign key(cpf_aluno) references alunos(cpf)
);

create table telefones_aluno
(
ddd char(2),
numero char(9),
tipo varchar(72),
cpf_aluno char(11),
foreign key(cpf_aluno) references alunos(cpf)
);

create table professorXdisc
(
cpf_professor char(11),
cod_disc char(4),
foreign key(cpf_professor) references professores(cpf),
foreign key(cod_disc) references disciplinas(cod_disc),
primary key(cpf_professor,cod_disc)
);

create table professor_discXlivro
(
cpf_professor_professor_disc char(11),
cod_disc_professor_disc char(4),
isbn_livro varchar(13),
foreign key(cpf_professor_professor_disc) references professorXdisc(cpf_professor),
foreign key(cod_disc_professor_disc) references professorXdisc(cod_disc),
foreign key(isbn_livro) references livros(isbn),
primary key(cpf_professor_professor_disc, cod_disc_professor_disc, isbn_livro)
);

create table semestre 
(
id_semestre char(4) primary key,
semestre varchar(144)
);

create table matricula #(professor_discXalunosXsemestre)
(
cpf_aluno char(11),
id_semestre char(4),
cod_disc_professor_disc char(4),
cpf_professor_professor_disc char(11),
foreign key(cod_disc_professor_disc) references professorXdisc(cod_disc),
foreign key(cpf_professor_professor_disc) references professorXdisc(cpf_professor),
foreign key(cpf_aluno) references alunos(cpf),
foreign key(id_semestre) references semestre(id_semestre),
primary key(cod_disc_professor_disc, cpf_professor_professor_disc, cpf_aluno, id_semestre)
);
