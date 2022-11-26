use lol;

INSERT INTO personagens VALUES
('318', 'paulo');

INSERT INTO itens VALUES
('72', 'paulo', '3', '318');

INSERT INTO jogadores VALUES
('1030', 'paulo', '118', '318');

INSERT INTO partidas VALUES
('19', '101', '115', '17/nov');

INSERT INTO patrocinadores VALUES
('19', 'paulo', 'dolar', '1', '115');

INSERT INTO times VALUES
('118', 'paulo');

INSERT INTO vencedor VALUES
('16', '116', 'paulo', '1');

/* Teste */

SELECT * FROM vencedor;
SELECT * FROM times;
SELECT * FROM patrocinadores;
SELECT * FROM personagens;
SELECT * FROM jogadores;
SELECT * FROM itens;
SELECT * FROM partidas;
