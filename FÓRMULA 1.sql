CREATE DATABASE IF NOT EXISTS db_formula1;
USE db_formula1;

CREATE TABLE paises (
    codigo INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE equipes (
    sigla VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cod_pais INT,
    FOREIGN KEY (cod_pais) REFERENCES paises(codigo)
);

CREATE TABLE pilotos (
    num_piloto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cod_pais INT,
    sigla_equipe VARCHAR(10),
    salario DECIMAL(12,2),
    FOREIGN KEY (cod_pais) REFERENCES paises(codigo),
    FOREIGN KEY (sigla_equipe) REFERENCES equipes(sigla)
);

CREATE TABLE corridas (
    sigla_gp VARCHAR(10) PRIMARY KEY,
    nome_gp VARCHAR(100) NOT NULL,
    cod_pais INT,
    qtd_voltas INT,
    FOREIGN KEY (cod_pais) REFERENCES paises(codigo)
);

CREATE TABLE participantes (
    sigla_gp VARCHAR(10),
    num_piloto INT,
    posicao_largada INT,
    PRIMARY KEY (sigla_gp, num_piloto),
    FOREIGN KEY (sigla_gp) REFERENCES corridas(sigla_gp),
    FOREIGN KEY (num_piloto) REFERENCES pilotos(num_piloto)
);

-- Inserção de Paises (10 registros)
INSERT INTO paises (codigo, nome) VALUES
(1, 'Brasil'),
(2, 'Italia'),
(3, 'Franca'),
(4, 'Inglaterra'),
(5, 'Alemanha'),
(6, 'Espanha'),
(7, 'Finlandia'),
(8, 'Australia'),
(9, 'Austria'),
(10, 'Monaco');

-- Inserção de Equipes (10 registros)
INSERT INTO equipes (sigla, nome, cod_pais) VALUES
('FER', 'Ferrari', 2),
('MCL', 'McLaren', 4),
('RBR', 'Red Bull Racing', 5),
('MER', 'Mercedes', 4),
('WIL', 'Williams', 4),
('ALP', 'Alpine', 3),
('AST', 'Aston Martin', 4),
('SAU', 'Sauber', 2),
('HAS', 'Haas', 4),
('LOT', 'Lotus', 3);

-- Inserção de Pilotos (15 registros)
INSERT INTO pilotos(num_piloto, nome, cod_pais, sigla_equipe, salario) VALUES
(1, 'Ayrton Senna', 1, 'MCL', 50000000.00),
(2, 'Nelson Piquet', 1, 'WIL', 30000000.00),
(3, 'Emerson Fittipaldi', 1, 'FER', 20000000.00),
(4, 'Felipe Massa', 1, 'WIL', 10000000.00),
(5, 'Rubens Barrichello', 1, 'FER', 12000000.00),
(6, 'Alberto Ascari', 2, 'FER', 8000000.00),
(7, 'Giuseppe Farina', 2, 'FER', 6000000.00),
(8, 'Michele Alboreto', 2, 'FER', 7000000.00),
(9, 'Alain Prost', 3, 'MCL', 25000000.00),
(10, 'Olivier Panis', 3, 'ALP', 5000000.00),
(11, 'Lewis Hamilton', 4, 'MER', 40000000.00),
(12, 'Max Verstappen', 5, 'RBR', 45000000.00),
(13, 'Fernando Alonso', 6, 'ALP', 15000000.00),
(14, 'Kimi Raikkonen', 7, 'FER', 10000000.00),
(15, 'Mark Webber', 8, 'RBR', 9000000.00);

-- Inserção de Corridas (10 registros)
INSERT INTO corridas(sigla_gp, nome_gp, cod_pais, qtd_voltas) VALUES
('BRA', 'Grande Premio do Brasil', 1, 71),
('ITA', 'Grande Premio da Italia', 2, 53),
('FRA', 'Grande Premio da Franca', 3, 53),
('GBR', 'Grande Premio da Inglaterra', 4, 52),
('GER', 'Grande Premio da Alemanha', 5, 67),
('ESP', 'Grande Premio da Espanha', 6, 66),
('MON', 'Grande Premio de Monaco', 10, 78),
('AUT', 'Grande Premio da Austria', 9, 71),
('BEL', 'Grande Premio da Belgica', 2, 44),
('CAN', 'Grande Premio do Canada', 4, 70);

-- Inserção de Participantes
INSERT INTO participantes(sigla_gp, num_piloto, posicao_largada) VALUES
-- GP do Brasil
('BRA', 1, 1),
('BRA', 4, 2),
('BRA', 5, 3),
('BRA', 11, 4),
('BRA', 12, 5),

-- GP da Italia
('ITA', 6, 1),
('ITA', 7, 2),
('ITA', 8, 3),
('ITA', 12, 4),
('ITA', 11, 5),

-- GP da Franca
('FRA', 9, 1),
('FRA', 10, 2),
('FRA', 1, 3),
('FRA', 11, 4),
('FRA', 12, 5),

-- GP da Inglaterra
('GBR', 11, 1),
('GBR', 1, 2),
('GBR', 12, 3),
('GBR', 9, 4),
('GBR', 4, 5),

-- GP da Alemanha
('GER', 12, 1),
('GER', 11, 2),
('GER', 15, 3),
('GER', 13, 4),
('GER', 14, 5),

-- GP da Espanha
('ESP', 13, 1),
('ESP', 11, 2),
('ESP', 12, 3),
('ESP', 9, 4),
('ESP', 4, 5);

-- Consultas solicitadas
SELECT nome
FROM paises
WHERE nome LIKE 'B%l';

SELECT p.nome
FROM pilotos p
INNER JOIN paises pa
ON p.cod_pais = pa.codigo
WHERE pa.nome IN ('Brasil', 'Italia', 'Franca');

SELECT nome
FROM pilotos;

SELECT nome_gp AS 'Nome do GP', qtd_voltas AS 'Quantidade de Voltas'
FROM corridas;

SELECT p.nome AS 'Nome do Piloto', pa.nome AS 'País'
FROM pilotos p
INNER JOIN paises pa
ON p.cod_pais = pa.codigo;

SELECT nome, salario
FROM pilotos
WHERE salario BETWEEN 7000000 AND 10000000;

SELECT pa.nome AS pais, AVG(p.salario) AS media_salarial
FROM pilotos p
INNER JOIN paises pa
ON p.cod_pais = pa.codigo
GROUP BY pa.codigo, pa.nome;

SELECT DISTINCT salario
FROM pilotos
ORDER BY salario ASC;

SELECT c.nome_gp AS 'Grande Prêmio', p.nome AS 'Piloto', part.posicao_largada AS 'Posição de Largada'
FROM participantes part
INNER JOIN corridas c
ON part.sigla_gp = c.sigla_gp
INNER JOIN pilotos p
ON part.num_piloto = p.num_piloto
ORDER BY c.sigla_gp, part.posicao_largada;