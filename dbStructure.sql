CREATE DATABASE bdOberon;
USE bdOberon;

-- =========================
-- Criação das Tabelas
-- =========================

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL
);

CREATE TABLE funcionario (
    idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nomeFuncionario VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE nivelAcesso (
    idNivelAcesso INT PRIMARY KEY AUTO_INCREMENT,
    tipoAcesso VARCHAR(45) NOT NULL,
    permissoes VARCHAR(255),
    fkFuncionario INT NOT NULL,
    FOREIGN KEY (fkFuncionario) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE maquina (
    idMaquina INT PRIMARY KEY AUTO_INCREMENT,
    nomeMaquina VARCHAR(100) NOT NULL,
    enderecoIp VARCHAR(45) UNIQUE NOT NULL,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE componente (
    idComponente INT PRIMARY KEY AUTO_INCREMENT,
    tipoComponente VARCHAR(45) NOT NULL,
    unidadeMedida VARCHAR(20) NOT NULL,
    funcaoMonitorada VARCHAR(100) NOT NULL
);

CREATE TABLE maquinaComponente (
    idMaquinaComponente INT PRIMARY KEY AUTO_INCREMENT,
    capacidade VARCHAR(45),
    fkMaquina INT NOT NULL,
    fkComponente INT NOT NULL,
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkComponente) REFERENCES componente(idComponente)
);

CREATE TABLE parametro (
    idParametro INT PRIMARY KEY AUTO_INCREMENT,
    limite VARCHAR(45) NOT NULL,
    fkMaquinaComponente INT NOT NULL,
    FOREIGN KEY (fkMaquinaComponente) REFERENCES maquinaComponente(idMaquinaComponente)
);

CREATE TABLE registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    valor VARCHAR(45) NOT NULL,
    horario DATETIME NOT NULL,
    fkMaquinaComponente INT NOT NULL,
    FOREIGN KEY (fkMaquinaComponente) REFERENCES maquinaComponente(idMaquinaComponente)
);

CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL,
    nivel VARCHAR(45) NOT NULL,
    valorInicial VARCHAR(45),
    valorFinal VARCHAR(45),
    horarioInicio DATETIME NOT NULL,
    horarioFinal DATETIME,
    fkMaquinaComponente INT NOT NULL,
    FOREIGN KEY (fkMaquinaComponente) REFERENCES maquinaComponente(idMaquinaComponente)
);

-- =========================
-- Criação das Views
-- =========================

-- View 1: Funcionários + Empresa + Nível de Acesso
CREATE VIEW vwFuncionariosDetalhes AS
SELECT 
    f.idFuncionario,
    f.nomeFuncionario,
    f.email,
    e.razaoSocial AS nomeEmpresa,
    n.tipoAcesso,
    n.permissoes
FROM funcionario f
JOIN empresa e ON f.fkEmpresa = e.idEmpresa
LEFT JOIN nivelAcesso n ON f.idFuncionario = n.fkFuncionario;

-- View 2: Máquinas e sua situação geral
CREATE VIEW vwMaquinasSituacao AS
SELECT
    m.idMaquina,
    m.nomeMaquina,
    m.enderecoIp,
    e.razaoSocial AS nomeEmpresa
FROM maquina m
JOIN empresa e ON m.fkEmpresa = e.idEmpresa;

-- View 3: Máquinas e seus componentes
CREATE VIEW vwMaquinaComponentes AS
SELECT 
    mc.idMaquinaComponente,
    m.nomeMaquina,
    c.tipoComponente,
    c.unidadeMedida,
    c.funcaoMonitorada,
    mc.capacidade
FROM maquinaComponente mc
JOIN maquina m ON mc.fkMaquina = m.idMaquina
JOIN componente c ON mc.fkComponente = c.idComponente;

-- View 4: Parâmetros e limites por componente
CREATE VIEW vwParametrosLimites AS
SELECT
    p.idParametro,
    m.nomeMaquina,
    c.tipoComponente,
    p.limite
FROM parametro p
JOIN maquinaComponente mc ON p.fkMaquinaComponente = mc.idMaquinaComponente
JOIN maquina m ON mc.fkMaquina = m.idMaquina
JOIN componente c ON mc.fkComponente = c.idComponente;

-- View 5: Registros + limites + diferença
CREATE VIEW vwRegistrosMonitoramento AS
SELECT 
    m.nomeMaquina,
    c.tipoComponente,
    r.valor AS valorCapturado,
    p.limite,
    r.horario,
    CASE 
        WHEN CAST(r.valor AS DECIMAL) > CAST(REPLACE(p.limite, '%', '') AS DECIMAL) 
        THEN 'Acima do Limite'
        ELSE 'Normal'
    END AS statusRegistro
FROM registro r
JOIN maquinaComponente mc ON r.fkMaquinaComponente = mc.idMaquinaComponente
JOIN maquina m ON mc.fkMaquina = m.idMaquina
JOIN componente c ON mc.fkComponente = c.idComponente
JOIN parametro p ON mc.idMaquinaComponente = p.fkMaquinaComponente;

-- View 6: Histórico de alertas
CREATE VIEW vwHistoricoAlertas AS
SELECT
    m.nomeMaquina,
    c.tipoComponente,
    a.descricao,
    a.nivel,
    a.valorInicial,
    a.valorFinal,
    a.horarioInicio,
    a.horarioFinal,
    CASE 
        WHEN a.horarioFinal IS NOT NULL 
        THEN TIMESTAMPDIFF(MINUTE, a.horarioInicio, a.horarioFinal)
        ELSE NULL
    END AS duracaoMinutos
FROM alerta a
JOIN maquinaComponente mc ON a.fkMaquinaComponente = mc.idMaquinaComponente
JOIN maquina m ON mc.fkMaquina = m.idMaquina
JOIN componente c ON mc.fkComponente = c.idComponente;

-- =========================
-- Consultas nas Views
-- =========================

SELECT * FROM vwFuncionariosDetalhes;
SELECT * FROM vwMaquinasSituacao;
SELECT * FROM vwMaquinaComponentes;
SELECT * FROM vwParametrosLimites;
SELECT * FROM vwRegistrosMonitoramento;
SELECT * FROM vwHistoricoAlertas;

