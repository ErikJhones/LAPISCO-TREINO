DROP DATABASE IF EXISTS roteiro;
CREATE DATABASE roteiro;
USE roteiro;


CREATE TABLE tbNovela(
	codigo_novela INT,
	nome_novela VARCHAR(30) NOT NULL,
	data_primeiro_capitulo DATE,
	data_ultimo_capitulo DATE,
	horario_exibicao TIME,
	CONSTRAINT pk_tbNovela PRIMARY KEY (codigo_novela)
);

CREATE TABLE tbAtor(
	codigo_ator INT,
	nome_ator VARCHAR(20) NOT NULL,
	idade INT,
	cidade_ator VARCHAR(20),
	salario_ator FLOAT,
	sexo_ator CHAR(1),
	CONSTRAINT pk_tbAtor PRIMARY KEY (codigo_ator)
);
CREATE TABLE tbCapitulo(
	codigo_capitulo INT,
	nome_capitulo VARCHAR(50) NOT NULL,
	data_exibicao_capitulo DATE,
	codigo_novela INT,
	CONSTRAINT pk_tbCapitulo PRIMARY KEY (codigo_capitulo),
	CONSTRAINT fk_tbCapitulo_tbNovela FOREIGN KEY (codigo_novela)
	REFERENCES tbNovela (codigo_novela) ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE tbPersonagem(
	codigo_personagem INT,
	nome_personagem VARCHAR(50) NOT NULL,
	idade_personagem INT,
	situacao_fnanceira_personagem VARCHAR(20),
	codigo_ator INT,
	CONSTRAINT pk_tbPersonagem PRIMARY KEY (codigo_personagem),
	CONSTRAINT fk_tbPersonagem_tbAtor FOREIGN KEY (codigo_ator)
	REFERENCES tbAtor (codigo_ator) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbNovelaPersonagem(
	codigo_personagem INT,
	codigo_novela INT,
	CONSTRAINT pk_tbNovelaPersonagem PRIMARY KEY (codigo_personagem,codigo_novela),
	CONSTRAINT fk_tbNovelaPersonagem_tbPersonagem FOREIGN KEY (codigo_personagem)
	REFERENCES tbPersonagem (codigo_personagem) ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT fk_tbNovelaPersonagem_tbNovela FOREIGN KEY (codigo_novela)
	REFERENCES tbNovela (codigo_novela) ON DELETE CASCADE
	ON UPDATE CASCADE
);

/*question one*/
INSERT INTO tbNovela (codigo_novela, nome_novela, data_primeiro_capitulo, data_ultimo_capitulo, horario_exibicao) 
VALUES (1,'Usurpadora', '2019-02-01', '2019-03-02', NULL),
(2,'Maria do bairro', '2017-03-21', '2018-03-02', '21:00:00'),
(3,'rei do gado', '2010-12-01', '2011-04-05', '21:00:00');

INSERT INTO tbCapitulo (codigo_capitulo, nome_capitulo, data_exibicao_capitulo, codigo_novela) 
VALUES (1,'matando o filho', '2019-02-01', 1),
(2,'rua de baixo', '2017-03-21' , 2),
(3,'sofrendo', '2010-12-01', 3);

INSERT INTO tbAtor (codigo_ator, nome_ator, idade, cidade_ator, salario_ator, sexo_ator) 
VALUES (1,'xico', 23, 'icó', 234.23,'m'),
(2,'maria', 12, 'são paulo', 214.6,'f'),
(3,'zé', 65, 'mossoró', 34.76,'m');

INSERT INTO tbPersonagem (codigo_personagem, nome_personagem, idade_personagem, situacao_fnanceira_personagem, codigo_ator) 
VALUES (1,'Pai', 24, 'pobre', 1),
(2,'filha', 9, 'rico', 2),
(3,'tio', 70, 'pobre', 3);

INSERT INTO tbNovelapersonagem (codigo_personagem, codigo_novela ) 
VALUES (1,1),
(2,2),
(3,3);

/**end question one*/

SELECT * FROM tbNovela;
SELECT * FROM tbCapitulo;
SELECT * FROM tbAtor;
SELECT * FROM tbPersonagem;
SELECT * FROM tbNovelapersonagem;

SELECT * FROM tbNovela WHERE horario_exibicao IS NULL; /*question two NOVELA POR CAMPO HORA EXIBIÇAO VAZIO*/
SELECT nome_ator FROM tbAtor WHERE cidade_ator LIKE 'm%'; /*question tree selecionando ator pela letra m inicial da cidade*/
SELECT * FROM tbAtor ORDER BY nome_ator ASC; /*question fuor ordenando nome por ordem crescente ASC OU DESC*/ 
SELECT nome_novela, (SELECT COUNT(*) FROM tbCapitulo WHERE codigo_novela = tbNovela.codigo_novela) AS totalCapitulos FROM tbNovela; /*question 5 select from novels the totally chapters*/
SELECT nome_novela FROM tbNovela WHERE (SELECT COUNT(*) FROM tbCapitulo WHERE codigo_novela = tbNovela.codigo_novela) >= 40; /*question 6 select from novels than totally chapters is > 40*/

 