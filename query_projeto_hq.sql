CREATE DATABASE projeto_hq;
USE projeto_hq;

CREATE TABLE  usuario (
id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome_completo VARCHAR(70) NOT NULL,
cpf BIGINT NOT NULL UNIQUE,
pseudonimo VARCHAR(20) NOT NULL UNIQUE,
email VARCHAR(100) NOT NULL UNIQUE,
senha VARCHAR(20) NOT NULL,
img TEXT,
banido BOOL DEFAULT NULL
);

CREATE TABLE historia (
id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR(50) NOT NULL,
class_ind ENUM('L', '14', '16', '18') NOT NULL,
sinopse TINYTEXT,
autor BIGINT UNSIGNED NOT NULL,
capa TEXT,
destaque BOOL,
FOREIGN KEY (autor) REFERENCES usuario(id)
);

CREATE TABLE capitulo (
id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_historia BIGINT UNSIGNED NOT NULL,
titulo_cap VARCHAR(70) NOT NULL,
ordenacao BIGINT NOT NULL,
FOREIGN KEY (id_historia) REFERENCES historia(id)
);


CREATE TABLE paginas (
id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_capitulo BIGINT UNSIGNED NOT NULL,
img_nome TEXT NOT NULL,
ordenacao BIGINT NOT NULL,
FOREIGN KEY (id_capitulo) REFERENCES capitulo(id)
);

CREATE TABLE categoria (
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
categoria VARCHAR(50)
);

INSERT INTO categoria (categoria)
VALUES ('Ação'), ('+18'), ('Aventura'), ('Comédia'), ('Drama'), ('Esportes'), ('Fantasia'), ('Ficção Científica'),
('Infantil'), ('Policial'), ('Romance'), ('Shonen'), ('Shoujo'), ('Survival'), ('Suspense'), ('Terror');

CREATE TABLE historia_categoria (
id_historia BIGINT UNSIGNED NOT NULL,
id_categoria INT UNSIGNED NOT NULL,
FOREIGN KEY (id_historia) REFERENCES historia(id),
FOREIGN KEY (id_categoria) REFERENCES categoria(id),
PRIMARY KEY (id_historia, id_categoria)
);