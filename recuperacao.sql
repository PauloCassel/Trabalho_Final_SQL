CREATE TABLE vencedor (
id_do_vencedor INT PRIMARY KEY NOT NULL,
id_da_partida INT NOT NULL,
nome_do_time VARCHAR(50) NOT NULL,
premio REAL NOT NULL
);

create table patrocinadores (
id_do_patrocinador INT PRIMARY KEY NOT NULL,
nome_do_patrocinador VARCHAR(50) NOT NULL,
moeda VARCHAR(10) NOT NULL,
patrocinio REAL NOT NULL,
id_do_time INT NOT NULL
);

