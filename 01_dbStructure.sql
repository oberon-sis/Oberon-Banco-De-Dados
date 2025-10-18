DROP DATABASE IF EXISTS bdOberon;
CREATE SCHEMA IF NOT EXISTS `bdOberon` DEFAULT CHARACTER SET utf8;
USE `bdOberon`;

-- -----------------------------------------------------
-- Tabela: TipoComponente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS TipoComponente (
    idTipoComponente INT NOT NULL AUTO_INCREMENT,
    tipoComponete VARCHAR(45) NOT NULL,
    unidadeMedida VARCHAR(45) NOT NULL,
    funcaoMonitorar VARCHAR(45) NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (idTipoComponente)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela: TipoUsuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS TipoUsuario (
    idTipoUsuario INT NOT NULL AUTO_INCREMENT,
    tipoUsuario ENUM('Administrador', 'Gerente', 'Colaborador') NOT NULL UNIQUE,
    permissoes VARCHAR(255) NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (idTipoUsuario)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela: Empresa.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Empresa (
    idEmpresa INT NOT NULL AUTO_INCREMENT,
    razaoSocial VARCHAR(45) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    statusAprovacao ENUM('Em analise', 'Aprovado', 'Rejeitado') NOT NULL DEFAULT 'Em analise',
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (idEmpresa)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela: Funcionario (PK Composta)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Funcionario (
    idFuncionario INT NOT NULL AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    fkTipoUsuario INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkCriadoPor INT NOT NULL, 
    fkEditadoPor INT NULL,
    PRIMARY KEY (idFuncionario, fkEmpresa),
        CONSTRAINT fk_Funcionario_copy1_nivelAcesso1
    FOREIGN KEY (fkTipoUsuario)
        REFERENCES TipoUsuario (idTipoUsuario),
        CONSTRAINT fk_USUARIO_EMPRESA1 FOREIGN KEY (fkEmpresa)
        REFERENCES Empresa (idEmpresa),
        CONSTRAINT fk_Funcionario_fkCriadoPor FOREIGN KEY (fkCriadoPor) REFERENCES Funcionario (idFuncionario),
        CONSTRAINT fk_Funcionario_fkEditadoPor FOREIGN KEY (fkEditadoPor) REFERENCES Funcionario (idFuncionario)
) ENGINE = InnoDB;
-- -----------------------------------------------------
-- Tabela: Maquina (PK Composta)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Maquina (
    idMaquina INT NOT NULL AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    macAddress VARCHAR(45) NOT NULL,
    status ENUM('Online', 'Offline', 'Pendente', 'Manutencao') NOT NULL DEFAULT 'Pendente',
    hostname VARCHAR(45) NULL,
    modelo VARCHAR(100) NULL,
    sistemaOperacional VARCHAR(45) NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkCriadoPor INT NOT NULL, 
    fkEditadoPor INT NULL,
    PRIMARY KEY (idMaquina, fkEmpresa),
        CONSTRAINT fk_Maquina_Empresa1
    FOREIGN KEY (fkEmpresa)
        REFERENCES Empresa (idEmpresa),
        CONSTRAINT fk_Maquina_fkCriadoPor FOREIGN KEY (fkCriadoPor) REFERENCES Funcionario (idFuncionario),
        CONSTRAINT fk_Maquina_fkEditadoPor FOREIGN KEY (fkEditadoPor) REFERENCES Funcionario (idFuncionario)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela: Componente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Componente (
    idComponente INT NOT NULL AUTO_INCREMENT,
    fkMaquina INT NOT NULL,
    capacidadeGb FLOAT NULL,
    nucleosThreads INT NULL,
    velocidadeMhz INT NULL,
    tipoDisco VARCHAR(45) NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkCriadoPor INT NOT NULL, 
    fkEditadoPor INT NULL,
    PRIMARY KEY (idComponente, fkMaquina),
        CONSTRAINT fk_MaquinaComponente_MAQUINA1
    FOREIGN KEY (fkMaquina)
        REFERENCES Maquina (idMaquina),
        CONSTRAINT fk_Componente_fkCriadoPor FOREIGN KEY (fkCriadoPor) REFERENCES Funcionario (idFuncionario),
        CONSTRAINT fk_Componente_fkEditadoPor FOREIGN KEY (fkEditadoPor) REFERENCES Funcionario (idFuncionario)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela: Parametro (PK Composta)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Parametro (
    idParametro INT NOT NULL AUTO_INCREMENT,
    fkTipoComponente INT NOT NULL,
    fkEmpresa INT NOT NULL,
    fkComponente INT NOT NULL,
    limite FLOAT NOT NULL,
    identificador VARCHAR(45) NOT NULL,
    origemParametro VARCHAR(45) NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkCriadoPor INT NOT NULL, 
    fkEditadoPor INT NULL,
    PRIMARY KEY (`idParametro`, `fkTipoComponente`, `fkEmpresa`, `fkComponente`),
        CONSTRAINT fk_Parametro_fkCriadoPor FOREIGN KEY (fkCriadoPor) REFERENCES Funcionario (idFuncionario),
        CONSTRAINT fk_Parametro_fkEditadoPor FOREIGN KEY (fkEditadoPor) REFERENCES Funcionario (idFuncionario)
) ENGINE = InnoDB;

---
--- Tabelas de Log e Auditoria
---

-- -----------------------------------------------------
-- Tabela: Registro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Registro (
    idRegistro INT NOT NULL AUTO_INCREMENT,
    fkComponente INT NOT NULL,
    valor FLOAT NOT NULL,
    horario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idRegistro, fkComponente),
        CONSTRAINT fk_REGISTRO_MaquinaComponente1
    FOREIGN KEY (fkComponente)
        REFERENCES Componente (idComponente)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela: Alerta (PK Composta)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Alerta (
    idAlerta INT NOT NULL AUTO_INCREMENT,
    fkRegistro INT NOT NULL,
    fkParametro INT NOT NULL,
    descricao VARCHAR(45) NOT NULL,
    nivel ENUM('Informativo', 'Atencao', 'Critico', 'Emergencia') NOT NULL DEFAULT 'Informativo',
    PRIMARY KEY (idAlerta, fkRegistro, fkParametro),
        CONSTRAINT fk_ALERTA_REGISTRO1
    FOREIGN KEY (fkRegistro)
        REFERENCES Registro (idRegistro),
        CONSTRAINT fk_Alerta_Parametro1
    FOREIGN KEY (fkParametro)
        REFERENCES Parametro (idParametro)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela: SessaoUsuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS SessaoUsuario (
    idSessaoUsuario INT NOT NULL AUTO_INCREMENT,
    fkFuncionario INT NOT NULL,
    horarioLogin DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    horarioLogout DATETIME NULL,
    PRIMARY KEY (idSessaoUsuario, fkFuncionario),
        CONSTRAINT fk_SessaoUsuario_Funcionario1
    FOREIGN KEY (fkFuncionario)
        REFERENCES Funcionario (idFuncionario)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela: LogAuditoria (PK Composta)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS LogAuditoria (
    idLogAuditoria INT NOT NULL AUTO_INCREMENT,
    fkSessaoUsuario INT NOT NULL,
    acao VARCHAR(45) NOT NULL,
    statusAcao VARCHAR(45) NOT NULL,
    tabelaAfetada VARCHAR(45) NOT NULL,
    idAfetado INT NOT NULL,
    valorAntigo TEXT,
    valorNovo TEXT,
    horario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idLogAuditoria, fkSessaoUsuario),
        CONSTRAINT fk_LogAuditoria_SessaoUsuario1
    FOREIGN KEY (fkSessaoUsuario)
        REFERENCES SessaoUsuario (idSessaoUsuario)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela: TokenRecuperacao (PK Composta)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS TokenRecuperacao (
    idTokenRecuperacao INT NOT NULL AUTO_INCREMENT,
    fkUsuario INT NOT NULL,
    hashToken VARCHAR(255) NOT NULL,
    horarioExpiracao DATETIME NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fkCriadoPor INT NOT NULL, 
    PRIMARY KEY (idTokenRecuperacao, fkUsuario),
        CONSTRAINT fk_TOKEN_USUARIO1
    FOREIGN KEY (fkUsuario)
        REFERENCES Funcionario (idFuncionario),
        CONSTRAINT fk_TokenRecuperacao_fkCriadoPor FOREIGN KEY (fkCriadoPor) REFERENCES Funcionario (idFuncionario)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela: LogSistema (PK Composta)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS LogSistema (
    idLogSistema INT NOT NULL AUTO_INCREMENT,
    fkMaquina INT NOT NULL,
    horarioInicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    horarioFinal DATETIME NULL,
    tipoAcesso ENUM('AgenteJava', 'AgentePython') NOT NULL,
    PRIMARY KEY (idLogSistema, fkMaquina),
        CONSTRAINT fk_LOG_ACESSO_MAQUINA1
    FOREIGN KEY (fkMaquina)
        REFERENCES Maquina (idMaquina)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela: LogDetalheEvento (PK Composta)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS LogDetalheEvento (
    idLogDetalheEvento INT NOT NULL AUTO_INCREMENT,
    fkLogSistema INT NOT NULL,
    eventoCaptura VARCHAR(45) NOT NULL,
    horario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descricao VARCHAR(45) NOT NULL,
    PRIMARY KEY (idLogDetalheEvento, fkLogSistema),
        CONSTRAINT fk_ACOES_LOG_ACESSO1
    FOREIGN KEY (fkLogSistema)
        REFERENCES LogSistema (idLogSistema)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela: Incidente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Incidente (
    idIncidente INT NOT NULL AUTO_INCREMENT,
    chaveJira VARCHAR(20) NOT NULL UNIQUE,
    titulo VARCHAR(45) NOT NULL,
    descricao VARCHAR(45) NOT NULL,
    categoria ENUM('Hardware', 'Software', 'Rede', 'Seguranca', 'Performance') NOT NULL,
    status ENUM('Aberto', 'EmAndamento', 'Resolvido', 'Fechado', 'Rejeitado') NOT NULL DEFAULT 'Aberto',
    severidade ENUM('Baixa', 'Media', 'Alta', 'Critica') NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkLogDetalheEvento INT NOT NULL,
    fkCriadoPor INT NOT NULL, 
    fkEditadoPor INT NULL,
    PRIMARY KEY (idIncidente, fkLogDetalheEvento),
        CONSTRAINT fk_Incidente_LogDetalheEvento1
    FOREIGN KEY (fkLogDetalheEvento)
        REFERENCES LogDetalheEvento (idLogDetalheEvento),
        CONSTRAINT fk_Incidente_fkCriadoPor FOREIGN KEY (fkCriadoPor) REFERENCES Funcionario (idFuncionario),
        CONSTRAINT fk_Incidente_fkEditadoPor FOREIGN KEY (fkEditadoPor) REFERENCES Funcionario (idFuncionario)
) ENGINE = InnoDB;

-- ******************************************************
-- A. CRIAÇÃO DE DADOS DE SISTEMA (Sem Triggers Ativos)
-- ******************************************************

INSERT INTO TipoComponente (tipoComponete, unidadeMedida, funcaoMonitorar) VALUES
('CPU', '%', 'Processamento'), ('RAM', '%', 'Memória'), ('DISCO', '%', 'Armazenamento'), ('REDE', 'MB/s', 'Tráfego');

INSERT INTO TipoUsuario (tipoUsuario, permissoes) VALUES
('Administrador', 'Total'), ('Gerente', 'Visualização e Configuração de Equipe'), ('Colaborador', 'Visualização Própria');

INSERT INTO Empresa (razaoSocial, cnpj, statusAprovacao) VALUES
('Oberon Sistemas S.A.', '00000000000001', 'Aprovado'), -- ID 1: OBERON
('TechVision Segurança', '12345678000199', 'Aprovado'), -- ID 2
('InovaCFTV Soluções', '98765432000155', 'Aprovado'), -- ID 3
('AlphaMonitor', '10101010101010', 'Aprovado'), -- ID 4
('BetaCFTV', '20202020202020', 'Aprovado'), -- ID 5
('SPTech Solutions', '30303030303030', 'Aprovado'), -- ID 6
('DeltaTech', '40404040404040', 'Aprovado'); -- ID 7

-- A2. CRIAÇÃO DO FUNCIONÁRIO DE SISTEMA (ID 1)
-- O trigger BEFORE INSERT preenche fkCriadoPor = 1
INSERT INTO Funcionario (nome, cpf, email, senha, fkEmpresa, fkTipoUsuario, fkCriadoPor) VALUES
('Sistema Oberon', '99999999999', 'sistema@oberon.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 1, 1, 1);



