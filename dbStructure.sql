CREATE DATABASE bdOberon;

USE bdOberon;

-- ==========================
-- Tabelas Principais
-- ==========================

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL
);

CREATE TABLE tipoUsuario (
    idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    tipoUsuario VARCHAR(45) NOT NULL,
    permissoes VARCHAR(255) NOT NULL
)AUTO_INCREMENT = 1000;

CREATE TABLE funcionario (
    idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(45) UNIQUE NOT NULL,
    fkTipoUsuario INT,
    fkEmpresa INT,
    FOREIGN KEY (fkTipoUsuario) REFERENCES tipoUsuario(idTipoUsuario),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE maquina (
    idMaquina INT PRIMARY KEY AUTO_INCREMENT,
    hostname VARCHAR(45) NOT NULL,
    modelo VARCHAR(45),
    macAddress VARCHAR(45),
    sistemaOperacional VARCHAR(45),
    statusAtivo VARCHAR(45),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE componente (
    idComponente INT PRIMARY KEY AUTO_INCREMENT,
    tipoComponente VARCHAR(45) NOT NULL,
    unidadeMedida VARCHAR(45) NOT NULL,
    funcaoMonitorar VARCHAR(45) NOT NULL
);

CREATE TABLE maquinaComponente (
    idMaquinaComponente INT PRIMARY KEY AUTO_INCREMENT,
    capacidadeGb FLOAT,
    nucleosThreads INT,
    velocidadeMhz INT,
    tipoDisco VARCHAR(45),
    fkMaquina INT,
    fkComponente INT,
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina),
    FOREIGN KEY (fkComponente) REFERENCES componente(idComponente)
);

CREATE TABLE parametro (
    idParametro INT PRIMARY KEY AUTO_INCREMENT,
    limite FLOAT NOT NULL,
    tipoParametro VARCHAR(45),
    fkEmpresa INT,
    fkMaquinaComponente INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkMaquinaComponente) REFERENCES maquinaComponente(idMaquinaComponente)
);

CREATE TABLE registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    valor FLOAT NOT NULL,
    horario DATETIME NOT NULL,
    fkMaquinaComponente INT,
    FOREIGN KEY (fkMaquinaComponente) REFERENCES maquinaComponente(idMaquinaComponente)
);

CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    nivel VARCHAR(45),
    valorInicial FLOAT,
    valorFinal FLOAT,
    horarioInicio DATETIME,
    horarioFinal DATETIME,
    fkMaquinaComponente INT,
    fkMaquina INT,
    FOREIGN KEY (fkmaquinaComponente) REFERENCES maquinaComponente(idMaquinaComponente),
    FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
);

