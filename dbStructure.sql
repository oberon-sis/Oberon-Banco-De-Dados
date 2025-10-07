CREATE DATABASE bdOberon;

USE bdOberon;

CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL
);

CREATE TABLE TipoUsuario (
    idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    tipoUsuario VARCHAR(45) NOT NULL,
    permissoes VARCHAR(255) NOT NULL
)AUTO_INCREMENT = 1000;

CREATE TABLE Funcionario (
    idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(45) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tokenReset VARCHAR(100),
    tokenExpira DATETIME,
    fkTipoUsuario INT,
    fkEmpresa INT,
    FOREIGN KEY (fkTipoUsuario) REFERENCES TipoUsuario(idTipoUsuario),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Maquina (
    idMaquina INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    hostname VARCHAR(45),
    modelo VARCHAR(45),
    macAddress VARCHAR(45) UNIQUE,
    ip VARCHAR(45),
    sistemaOperacional VARCHAR(45),
    status VARCHAR(45),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Componente (
    idComponente INT PRIMARY KEY AUTO_INCREMENT,
    tipoComponente VARCHAR(45) NOT NULL,
    unidadeMedida VARCHAR(45) NOT NULL,
    funcaoMonitorar VARCHAR(45) NOT NULL
);

CREATE TABLE MaquinaComponente (
    idMaquinaComponente INT PRIMARY KEY AUTO_INCREMENT,
    capacidadeGb FLOAT,
    nucleosThreads INT,
    velocidadeMhz INT,
    tipoDisco VARCHAR(45),
    fkMaquina INT,
    fkComponente INT,
    origemParametro VARCHAR(45), 
    FOREIGN KEY (fkMaquina) REFERENCES Maquina(idMaquina),
    FOREIGN KEY (fkComponente) REFERENCES Componente(idComponente)
);

CREATE TABLE ParametroEspecifico (
    idParametro INT PRIMARY KEY AUTO_INCREMENT,
    limite FLOAT NOT NULL,
    fkMaquinaComponente INT UNIQUE,
    FOREIGN KEY (fkMaquinaComponente) REFERENCES MaquinaComponente(idMaquinaComponente)
);

CREATE TABLE ParametroPadrao (
    limite FLOAT NOT NULL,
    fkEmpresa INT NOT NULL,
    fkComponente INT NOT NULL, 
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkComponente) REFERENCES Componente(idComponente),
    PRIMARY KEY (fkEmpresa, fkComponente) 
);

CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    valor FLOAT NOT NULL,
    horario DATETIME NOT NULL,
    fkMaquinaComponente INT,
    FOREIGN KEY (fkMaquinaComponente) REFERENCES MaquinaComponente(idMaquinaComponente)
);

CREATE TABLE Alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    nivel VARCHAR(45),
    valorInicial FLOAT,
    valorFinal FLOAT,
    horarioInicio DATETIME,
    horarioFinal DATETIME,
    fkMaquinaComponente INT,
    fkMaquina INT,
    FOREIGN KEY (fkmaquinaComponente) REFERENCES MaquinaComponente(idMaquinaComponente),
    FOREIGN KEY (fkMaquina) REFERENCES Maquina(idMaquina)
);

CREATE OR REPLACE VIEW viewDadosMaquina AS
SELECT 
    m.idMaquina,
    m.nome,
    m.hostname,
    m.modelo,
    m.ip,
    m.sistemaOperacional,
    e.razaoSocial,
    m.macAddress
FROM Maquina as m 
JOIN Empresa as e 
ON m.fkEmpresa = e.idEmpresa;



INSERT INTO TipoUsuario(tipoUsuario, permissoes) VALUES
('Colaborador', 'editar_info;ver_paineis;ver_alertas;ver_suporte'),
('Administrador', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas'),
('Gestor', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas;gerir_empresa');

INSERT INTO Componente (tipoComponente, unidadeMedida, funcaoMonitorar) VALUES
('CPU', '%', 'cpu porcentagem'),
('RAM', '%', 'ram porcentagem'),
('DISCO', '%', 'disco porcentagem'),
('REDE', 'Mbps', 'rede taxa'),
('GPU', '%', 'Uso de processamento gráfico');
    
CREATE OR REPLACE VIEW ViewParametrosMaquina AS
SELECT
    mc.idMaquinaComponente,
    c.funcaoMonitorar AS tipo,
    c.unidadeMedida AS unidade,
    mc.fkMaquina AS idMaquina,
    mc.origemParametro,
    c.idComponente AS fkComponente,
    COALESCE(
        CASE
            WHEN mc.origemParametro = 'ESPECIFICO' THEN pe.limite
            ELSE NULL
        END,
        CASE 
            WHEN mc.origemParametro = 'EMPRESA' THEN pp.limite
            ELSE NULL
        END
    ) AS limite_base_db
FROM MaquinaComponente mc
JOIN Componente c ON mc.fkComponente = c.idComponente
JOIN Maquina m ON mc.fkMaquina = m.idMaquina
LEFT JOIN ParametroEspecifico pe ON mc.idMaquinaComponente = pe.fkMaquinaComponente
LEFT JOIN ParametroPadrao pp ON m.fkEmpresa = pp.fkEmpresa AND mc.fkComponente = pp.fkComponente;
