use lol;

/* Tabela de times */
create table times (
id_do_time INT PRIMARY KEY NOT NULL,
nome_do_time VARCHAR(50) NOT NULL
);

/* Tabela de patrocinadores */
create table patrocinadores (
id_da_marca INT PRIMARY KEY NOT NULL,
nome_da_marca VARCHAR(50) NOT NULL,
moeda VARCHAR(10) NOT NULL,
patrocinio REAL NOT NULL,
id_do_time INT NOT NULL
);

/* Tabela de partidas */
CREATE TABLE partidas (
id_da_partida INT PRIMARY KEY NOT NULL,
id_do_anfitriao INT NOT NULL,
id_do_visitante INT NOT NULL,
data_da_partida VARCHAR(50) NOT NULL
);

/* Tabela de personagens */
CREATE TABLE personagens (
id_do_personagem INT(5) PRIMARY KEY NOT NULL,
nome_do_personagem VARCHAR(50) NOT NULL
);

/* Tabela de jogadores */
CREATE TABLE jogadores (
id_do_jogador INT PRIMARY KEY NOT NULL,
nome_do_jogador VARCHAR(50) NOT NULL,
id_do_time INT NOT NULL,
id_do_personagem INT NOT NULL
);

/* Tabela de vencedor */
CREATE TABLE vencedor (
id_da_partida INT PRIMARY KEY NOT NULL,
id_do_time INT NOT NULL,
nome_do_time VARCHAR(50) NOT NULL,
premio REAL NOT NULL
);

/* Tabela de itens */
CREATE TABLE itens (
id_do_item INT PRIMARY KEY NOT NULL,
nome_do_item VARCHAR(50) NOT NULL,
preco INT NOT NULL,
id_do_personagem INT NOT NULL
);

/* 5 */

ALTER TABLE jogadores ADD CONSTRAINT FK_JOGADORES_TIMES FOREIGN KEY
(id_do_time) REFERENCES times(id_do_time) ON DELETE CASCADE;

ALTER TABLE patrocinadores ADD CONSTRAINT FK_TIMES_PATROCINADORES FOREIGN KEY
(id_do_time) REFERENCES times(id_do_time) ON DELETE CASCADE;

ALTER TABLE partidas ADD CONSTRAINT FK_PARTIDAS_VENCEDOR FOREIGN KEY
(id_da_partida) REFERENCES VENCEDOR(id_da_partida) ON DELETE CASCADE;

ALTER TABLE jogador ADD CONSTRAINT FK_JOGADORES_PERSONAGENS FOREIGN KEY
(id_do_personagem) REFERENCES personagens(id_do_personagem) ON DELETE CASCADE;

/* 6 - Joins */
SELECT times.nome_do_time, premio FROM times INNER JOIN vencedor
ON times.id_do_time = vencedor.id_do_time;

SELECT jogadores.nome_do_jogador, nome_do_time FROM jogadores INNER JOIN times
ON jogadores.id_do_time = times.id_do_time;

SELECT personagens.nome_do_personagem, jogadores.nome_do_jogador FROM personagens INNER JOIN jogadores
ON jogadores.id_do_personagem = personagens.id_do_personagem;

SELECT itens.nome_do_item, nome_do_personagem FROM itens INNER JOIN personagens
ON itens.id_do_personagem = personagens.id_do_personagem;

SELECT patrocinadores.nome_da_marca, nome_do_time FROM patrocinadores INNER JOIN times
ON patrocinadores.id_do_time = times.id_do_time;

/* 7 Order By */

SELECT patrocinio FROM patrocinadores ORDER BY patrocinio DESC;

SELECT premio FROM vencedor ORDER BY premio ASC;

SELECT id_do_time, id_da_partida FROM vencedor ORDER BY id_da_partida DESC;

SELECT nome_do_item, preco FROM itens ORDER BY preco DESC;

SELECT id_do_jogador, id_do_personagem FROM jogadores ORDER BY id_do_jogador DESC;

/* 8 Group By */

SELECT id_do_anfitriao, id_do_visitante FROM partidas GROUP BY id_do_anfitriao;

SELECT nome_do_item, id_do_item FROM itens GROUP BY id_do_item;

SELECT nome_do_time, id_do_time FROM times GROUP BY id_do_time;

SELECT nome_do_time, premio FROM vencedor GROUP BY id_do_time;

SELECT id_da_partida, data_da_partida FROM partidas GROUP BY id_da_partida;

/* 9 Join e Order By */

SELECT times.nome_do_time, premio FROM times INNER JOIN vencedor ON times.id_do_time = vencedor.id_do_time ORDER BY premio ASC;

SELECT jogadores.nome_do_jogador, nome_do_time FROM jogadores INNER JOIN times ON jogadores.id_do_time = times.id_do_time ORDER BY id_do_time DESC;

SELECT personagens.nome_do_personagem, jogadores.nome_do_jogador FROM personagens INNER JOIN jogadores ON jogadores.id_do_personagem = personagens.id_do_personagem ORDER BY id_do_jogador DESC;

/* 10 Funções Matemáticas */
/* ver o valor máximo da tabela premio(vencedor) */
SELECT MAX(premio) FROM vencedor;
/* ver o valor médio da tabela premio(vencedor) */
SELECT AVG(premio) FROM vencedor;
/* ver o valor minimo da tabela preco(itens) */
SELECT MIN(preco) FROM itens;
/* ver o valor médio da tabela preco(itens) */
SELECT AVG(preco) FROM itens;
/* ver o valor máximo da tabela patrocinio(patrocinadores) */
SELECT MAX(patrocinio) FROM patrocinadores;
/* ver o valor minimo da tabela patrocinio(patrocinadores) */
SELECT MIN(patrocinio) FROM patrocinadores;
/* ver o valor médio da tabela patrocinio(patrocinadores) */
SELECT AVG(patrocinio) FROM patrocinadores;

/* 11 Views */
CREATE VIEW maior_patrocinio AS SELECT MAX(patrocinio) FROM patrocinadores;
SELECT * FROM maior_patrocinio;

CREATE VIEW item_mais_caro AS SELECT MAX(preco) FROM itens;
SELECT * FROM item_mais_caro;

CREATE VIEW maior_premio AS SELECT MAX(premio) FROM vencedor;
SELECT * FROM maior_premio;

CREATE VIEW media_preco_itens AS SELECT AVG(preco) FROM itens;
SELECT * FROM media_preco_itens;

CREATE VIEW menor_premio AS SELECT MIN(premio) FROM vencedor;
SELECT * FROM menor_premio;

/* 12 Savepoints */
START transaction;
INSERT INTO personagens VALUES
('316', "K'Sante");
SAVEPOINT novos_personagens;
ROLLBACK TO novos_personagens;

INSERT INTO itens VALUES
('66', 'Coroa da Rainha Despedaçada', '3.000', '316'),
('67', 'Proteção imutavel', '2.800', '316'),
('68', 'Arco de Axitoma', '2,500', '316');
SAVEPOINT novos_itens;
ROLLBACK TO novos_itens;

INSERT INTO times VALUES
('117', 'Flamengo'),
('116', 'Gremio');
SAVEPOINT novos_times;
ROLLBACK TO novos_times;

INSERT INTO partidas VALUES
('16', '116', '117', '16/nov');
SAVEPOINT nova_partida;
ROLLBACK TO nova_partida;

INSERT INTO patrocinadores VALUES
('16', 'Ferrari', 'dolar', '9.000.000', '116');
SAVEPOINT novo_patrocinador;
ROLLBACK TO novo_patrocinador;

/* 13 Usuarios */
CREATE USER paulo@localhost;
CREATE USER marcelo@localhost IDENTIFIED BY '1144';
CREATE USER anne@localhost IDENTIFIED BY '1234';

DROP USER paulo@localhost;
DROP USER marcelo@localhost;
DROP USER anne@localhost;

/* dando a permissão de ver as views para o úsuario paulo */
GRANT ALL ON lol.maior_patrocinio TO paulo@localhost;
GRANT ALL ON lol.item_mais_caro TO paulo@localhost;
GRANT ALL ON lol.maior_premio TO paulo@localhost;
GRANT ALL ON lol.menor_premio TO paulo@localhost;
GRANT ALL ON lol.media_preco_itens TO paulo@localhost;

/* dando a permissão de inserir dados e ver para o úsuario marcelo */
GRANT INSERT ON lol.itens TO marcelo@localhost;
GRANT INSERT ON lol.patrocinadores TO marcelo@localhost;
GRANT INSERT ON lol.times TO marcelo@localhost;
GRANT INSERT ON lol.vencedor TO marcelo@localhost;
GRANT INSERT ON lol.personagens TO marcelo@localhost;
GRANT INSERT ON lol.partidas TO marcelo@localhost;
GRANT INSERT ON lol.jogadores TO marcelo@localhost;

/* dando a permissão de ver os dados para o úsuario anne */
GRANT SELECT ON lol.itens TO anne@localhost;
GRANT SELECT ON lol.patrocinadores TO anne@localhost;
GRANT SELECT ON lol.times TO anne@localhost;
GRANT SELECT ON lol.vencedor TO anne@localhost;
GRANT SELECT ON lol.personagens TO anne@localhost;
GRANT SELECT ON lol.partidas TO anne@localhost;
GRANT SELECT ON lol.jogadores TO anne@localhost;
