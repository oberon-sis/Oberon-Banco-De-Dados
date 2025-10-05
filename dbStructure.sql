DROP DATABASE if exists bdOberon;
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
    hostname VARCHAR(45) NOT NULL,
    modelo VARCHAR(45),
    macAddress VARCHAR(45),
    ip VARCHAR(45) NOT NULL,
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
    FOREIGN KEY (fkMaquina) REFERENCES Maquina(idMaquina),
    FOREIGN KEY (fkComponente) REFERENCES Componente(idComponente)
);

CREATE TABLE Parametro (
    idParametro INT PRIMARY KEY AUTO_INCREMENT,
    limite FLOAT NOT NULL,
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
JOiN Empresa as e 
ON m.fkEmpresa = e.idEmpresa;

CREATE OR REPLACE VIEW ViewParametrosMaquina AS 
SELECT
    MC.idMaquinaComponente,
    C.funcaoMonitorar,
    C.unidadeMedida,
	COALESCE(PE.limite, PP.limite) AS limite_aplicado,

    CASE C.tipoComponente
        WHEN 'CPU' THEN CAST(MC.nucleosThreads AS CHAR)
        WHEN 'RAM' THEN CONCAT(CAST(MC.capacidadeGb AS CHAR), ' GB')
        WHEN 'Disco Duro' THEN CONCAT(CAST(MC.capacidadeGb AS CHAR), ' GB (', MC.tipoDisco, ')')
        ELSE 'N/A'
    END AS atributo_componente,
    CASE
        WHEN PE.limite IS NOT NULL THEN 'Específico'
        WHEN PP.limite IS NOT NULL THEN 'Padrão'
        ELSE 'Não Definido'
    END AS tipo_parametro_usado,
    C.tipoComponente,
	M.idMaquina
FROM
    Maquina AS M
JOIN
    MaquinaComponente AS MC ON M.idMaquina = MC.fkMaquina
JOIN
    Componente AS C ON MC.fkComponente = C.idComponente
LEFT JOIN
    Parametro AS PE ON PE.fkMaquinaComponente = MC.idMaquinaComponente
    AND PE.fkEmpresa IS NULL
LEFT JOIN
    Parametro AS PP ON PP.fkEmpresa = M.fkEmpresa
    AND PP.fkMaquinaComponente IS NULL;