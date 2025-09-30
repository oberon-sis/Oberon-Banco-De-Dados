CREATE DATABASE bdOberon;

USE bdOberon;

-- ==========================
-- Tabelas Principais
-- ==========================

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
    senha VARCHAR(45) NOT NULL,
    fkTipoUsuario INT,
    fkEmpresa INT,
    FOREIGN KEY (fkTipoUsuario) REFERENCES TipoUsuario(idTipoUsuario),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Maquina (
    idMaquina INT PRIMARY KEY AUTO_INCREMENT,
    hostname VARCHAR(45) NOT NULL,
    modelo VARCHAR(45),
    macAddress VARCHAR(45),
    sistemaOperacional VARCHAR(45),
    statusAtivo VARCHAR(45),
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
    FOREIGN KEY (fkMaquina) REFERENCES Maquina(idMaquina),
    FOREIGN KEY (fkComponente) REFERENCES Componente(idComponente)
);

CREATE TABLE Parametro (
    idParametro INT PRIMARY KEY AUTO_INCREMENT,
    limite FLOAT NOT NULL,
    tipoParametro VARCHAR(45),
    fkEmpresa INT,
    fkMaquinaComponente INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkMaquinaComponente) REFERENCES MaquinaComponente(idMaquinaComponente)
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

