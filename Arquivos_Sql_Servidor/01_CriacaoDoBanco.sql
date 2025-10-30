-- ======================================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS bdOberon
-- ======================================================

SET time_zone = '-03:00';

DROP DATABASE IF EXISTS bdOberon;
CREATE SCHEMA IF NOT EXISTS `bdOberon` DEFAULT CHARACTER SET utf8;
USE `bdOberon`;

-- ======================================================
-- 2. CRIAÇÃO DAS TABELAS
-- ======================================================

-- Tabela: TipoComponente
CREATE TABLE IF NOT EXISTS TipoComponente (
    idTipoComponente INT PRIMARY KEY AUTO_INCREMENT,
    tipoComponete ENUM("CPU", "RAM", "DISCO", "REDE") NOT NULL,
    unidadeMedida VARCHAR(45) NOT NULL,
    funcaoMonitorar VARCHAR(45) NOT NULL
) ENGINE = InnoDB;

-- Tabela: TipoUsuario
CREATE TABLE IF NOT EXISTS TipoUsuario (
    idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    tipoUsuario ENUM("Colaborador", "Gestor", "Administrador", "Suporte", "Super Administrador") NOT NULL,
    permissoes VARCHAR(255) NOT NULL
) AUTO_INCREMENT = 1000  ENGINE = InnoDB;

-- Tabela: Empresa
CREATE TABLE IF NOT EXISTS Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(45) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkEditadoPor INT NULL 
) ENGINE = InnoDB;

-- Tabela: Funcionario
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
    fkCriadoPor INT NULL,
    fkEditadoPor INT NULL,
    PRIMARY KEY (idFuncionario),
    
    CONSTRAINT fk_Funcionario_TipoUsuario FOREIGN KEY (fkTipoUsuario)
        REFERENCES TipoUsuario (idTipoUsuario)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    
    -- ALTERADO: Ao deletar uma Empresa, todos os seus Funcionários devem ser deletados (CASCADE)
    CONSTRAINT fk_Funcionario_Empresa FOREIGN KEY (fkEmpresa)
        REFERENCES Empresa (idEmpresa)
        ON DELETE CASCADE ON UPDATE NO ACTION,
    
    -- FKs de auditoria com ON DELETE SET NULL (Manter o log, remover a referência)
    CONSTRAINT fk_Funcionario_CriadoPor FOREIGN KEY (fkCriadoPor)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT fk_Funcionario_EditadoPor FOREIGN KEY (fkEditadoPor)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- alter table para que o relacionamento entre a empresa e usario não quebre
ALTER TABLE Empresa ADD CONSTRAINT fk_editado_por_empresa FOREIGN KEY (fkEditadoPor) 
    REFERENCES Funcionario (idFuncionario)
    ON DELETE SET NULL ON UPDATE NO ACTION;

-- Tabela: Maquina
CREATE TABLE IF NOT EXISTS Maquina (
    idMaquina INT NOT NULL AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    macAddress VARCHAR(45) NOT NULL,
    status ENUM('Online', 'Offline', 'Pendente', 'Manutenção') NOT NULL DEFAULT 'Pendente',
    ip VARCHAR(45) NULL,
    hostname VARCHAR(45) NULL,
    modelo VARCHAR(45) NULL,
    sistemaOperacional VARCHAR(45) NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkCriadoPor INT NULL,
    fkEditadoPor INT NULL,
    PRIMARY KEY (idMaquina),
    
    -- ALTERADO: Ao deletar uma Empresa, todas as suas Máquinas devem ser deletadas (CASCADE)
    CONSTRAINT fk_Maquina_Empresa FOREIGN KEY (fkEmpresa)
        REFERENCES Empresa (idEmpresa)
        ON DELETE CASCADE ON UPDATE NO ACTION,
    
    -- FKs de auditoria com ON DELETE SET NULL
    CONSTRAINT fk_Maquina_CriadoPor FOREIGN KEY (fkCriadoPor)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT fk_Maquina_EditadoPor FOREIGN KEY (fkEditadoPor)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- Tabela: Componente
CREATE TABLE IF NOT EXISTS Componente (
    idComponente INT NOT NULL AUTO_INCREMENT,
    fkMaquina INT NOT NULL,
    fkTipoComponente INT NOT NULL,
    origemParametro VARCHAR(45) NOT NULL DEFAULT 'OBERON',
    capacidadeGb FLOAT NULL,
    nucleosThreads INT NULL,
    velocidadeMhz INT NULL,
    tipoDisco VARCHAR(45) NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkCriadoPor INT NULL,
    fkEditadoPor INT NULL,
    PRIMARY KEY (idComponente),
    
    -- ALTERADO: Ao deletar uma Máquina, todos os seus Componentes devem ser deletados (CASCADE)
    CONSTRAINT fk_Componente_Maquina FOREIGN KEY (fkMaquina)
        REFERENCES Maquina (idMaquina)
        ON DELETE CASCADE ON UPDATE NO ACTION,
        
    CONSTRAINT fk_Componente_TipoComponente FOREIGN KEY (fkTipoComponente)
        REFERENCES TipoComponente (idTipoComponente)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    
    -- FKs de auditoria com ON DELETE SET NULL
    CONSTRAINT fk_Componente_CriadoPor FOREIGN KEY (fkCriadoPor)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT fk_Componente_EditadoPor FOREIGN KEY (fkEditadoPor)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- Tabela: Parametro
CREATE TABLE IF NOT EXISTS Parametro (
    idParametro INT NOT NULL AUTO_INCREMENT,
    fkTipoComponente INT NOT NULL,
    fkComponente INT NULL,
    fkEmpresa INT NULL,
    limite FLOAT NOT NULL,
    identificador ENUM("Atenção", "Alerta" ,"Critico") NOT NULL,
    origemParametro ENUM("EMPRESA", "OBERON", "ESPECÍFICO")NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dataEdicao DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    fkCriadoPor INT NULL,
    fkEditadoPor INT NULL,
    PRIMARY KEY (idParametro),
    
    CONSTRAINT fk_Parametro_TipoComponente FOREIGN KEY (fkTipoComponente)
        REFERENCES TipoComponente (idTipoComponente)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
        
    -- ALTERADO: Ao deletar um Componente (parâmetro ESPECIFICO), seu Parâmetro deve ser deletado (CASCADE)
    CONSTRAINT fk_Parametro_Componente FOREIGN KEY (fkComponente)
        REFERENCES Componente (idComponente)
        ON DELETE CASCADE ON UPDATE NO ACTION,

    -- NOVO: Ao deletar uma Empresa (parâmetro EMPRESA), seu Parâmetro deve ser deletado (CASCADE)
    CONSTRAINT fk_Parametro_Empresa FOREIGN KEY (fkEmpresa)
        REFERENCES Empresa (idEmpresa)
        ON DELETE CASCADE ON UPDATE NO ACTION,
    
    -- FKs de auditoria com ON DELETE SET NULL
    CONSTRAINT fk_Parametro_CriadoPor FOREIGN KEY (fkCriadoPor)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT fk_Parametro_EditadoPor FOREIGN KEY (fkEditadoPor)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- Tabela: Registro
CREATE TABLE IF NOT EXISTS Registro (
    idRegistro INT NOT NULL AUTO_INCREMENT,
    fkComponente INT NOT NULL,
    valor FLOAT NOT NULL,
    horario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idRegistro),
    
    -- ALTERADO: Ao deletar um Componente, todos os seus Registros devem ser deletados (CASCADE)
    CONSTRAINT fk_REGISTRO_Componente FOREIGN KEY (fkComponente)
        REFERENCES Componente (idComponente)
        ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabela: Alerta
CREATE TABLE IF NOT EXISTS Alerta (
	idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    fkRegistro INT NOT NULL,
    fkParametro INT NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    nivel ENUM('ATENÇÃO', 'ALERTA', 'CRITICO') NOT NULL DEFAULT 'ATENÇÃO',

    -- ALTERADO: Ao deletar um Registro, o Alerta correspondente deve ser deletado (CASCADE)
    CONSTRAINT fk_ALERTA_REGISTRO FOREIGN KEY (fkRegistro)
        REFERENCES Registro (idRegistro)
        ON DELETE CASCADE ON UPDATE NO ACTION,
        
    -- ALTERADO: Ao deletar um Parâmetro, os Alertas baseados nele devem ser deletados (CASCADE)
    CONSTRAINT fk_Alerta_Parametro FOREIGN KEY (fkParametro)
        REFERENCES Parametro (idParametro)
        ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;



-- Tabela: LogAuditoria
CREATE TABLE IF NOT EXISTS LogAuditoria (
	idLogAuditoria INT PRIMARY KEY auto_increment,
    fkFuncionario INT NOT NULL,
    horario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    idAfetado INT NOT NULL,
    acao VARCHAR(20) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    tabelaAfetada VARCHAR(45) NOT NULL,
    valorAntigo JSON NULL,
    valorNovo JSON NULL,
    
    -- ALTERADO: Se o Funcionário for deletado, a referência no Log deve ser removida (SET NULL), mas o campo fkFuncionario foi mantido NOT NULL.
    -- Mantendo NO ACTION (Melhor para logs: garante que o log sempre tem um autor ou exige que a deleção seja manual/programática)
    CONSTRAINT fk_LogAuditoria_SessaoUsuario FOREIGN KEY (fkFuncionario)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- Tabela: TokenRecuperacao
CREATE TABLE IF NOT EXISTS TokenRecuperacao (
    fkFuncionario INT NOT NULL,
    hashToken VARCHAR(255) NOT NULL,
    horarioExpiracao DATETIME NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    
    CONSTRAINT pk_composta_token PRIMARY KEY (fkFuncionario, hashToken),
    
    -- ALTERADO: Ao deletar um Funcionário, o Token de Recuperação deve ser deletado (CASCADE)
    CONSTRAINT fk_TOKEN_USUARIO FOREIGN KEY (fkFuncionario)
        REFERENCES Funcionario (idFuncionario)
        ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- Tabela: LogSistema
CREATE TABLE IF NOT EXISTS LogSistema (
    idLogSistema INT NOT NULL AUTO_INCREMENT,
    fkMaquina INT NOT NULL,
    horarioInicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    horarioFinal DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    tipoAcesso ENUM('AgenteJava', 'AgentePython') NOT NULL,
    PRIMARY KEY (idLogSistema),
    
    -- ALTERADO: Ao deletar uma Máquina, todos os seus Logs de Sistema devem ser deletados (CASCADE)
    CONSTRAINT fk_LOG_ACESSO_MAQUINA FOREIGN KEY (fkMaquina)
        REFERENCES Maquina (idMaquina)
        ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- Tabela: LogDetalheEvento
CREATE TABLE IF NOT EXISTS LogDetalheEvento (
    idLogDetalheEvento INT NOT NULL AUTO_INCREMENT,
    fkLogSistema INT NOT NULL,
    eventoCaptura VARCHAR(100) NOT NULL,
    horario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descricao VARCHAR(245) NOT NULL,
    PRIMARY KEY (idLogDetalheEvento),
    
    -- ALTERADO: Ao deletar um Log de Sistema, seus Detalhes de Evento devem ser deletados (CASCADE)
    CONSTRAINT fk_ACOES_LOG_ACESSO FOREIGN KEY (fkLogSistema)
        REFERENCES LogSistema (idLogSistema)
        ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- Tabela: Incidente
CREATE TABLE IF NOT EXISTS Incidente (
    idIncidente INT NOT NULL AUTO_INCREMENT,
    chaveJira VARCHAR(20) NOT NULL UNIQUE,
    titulo VARCHAR(45) NOT NULL,
    descricao VARCHAR(45) NOT NULL,
    categoria ENUM('Hardware', 'Software', 'Rede', 'Seguranca', 'Performance') NOT NULL,
    status ENUM('Aberto', 'EmAndamento', 'Resolvido', 'Fechado', 'Rejeitado') NOT NULL DEFAULT 'Aberto',
    severidade ENUM('Baixa', ',Média', 'Alta', 'Critica') NOT NULL,
    dataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fkLogDetalheEvento INT NOT NULL,
    PRIMARY KEY (idIncidente),
    
    -- ALTERADO: Ao deletar um LogDetalheEvento (que gerou o incidente), o Incidente deve ser deletado (CASCADE)
    CONSTRAINT fk_Incidente_LogDetalheEvento FOREIGN KEY (fkLogDetalheEvento)
        REFERENCES LogDetalheEvento (idLogDetalheEvento)
        ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- ======================================================
-- 3. INSERÇÃO DE DADOS DE SISTEMA
-- ======================================================

INSERT INTO TipoComponente (tipoComponete, unidadeMedida, funcaoMonitorar) VALUES
('CPU', '%', 'cpu porcentagem'), 
('RAM', '%', 'ram porcentagem'), 
('DISCO', '%', 'disco porcentagem'), 
('REDE', 'MB/s', 'rede');

INSERT INTO TipoUsuario(tipoUsuario, permissoes) VALUES
('Colaborador', 'editar_info;ver_paineis;ver_alertas;ver_suporte'),
('Administrador', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas'),
('Gestor', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas;gerir_empresa'),
('Suporte', 'editar_info;ver_suporte;ver_incidentes, ver_solicitacoes'),
('Super Administrador', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas;gerir_empresa;ver_incidentes, ver_solicitacoes');

INSERT INTO Empresa (idEmpresa, razaoSocial, cnpj, fkEditadoPor) VALUES
(1, 'Oberon Sistemas S.A.', '00987654000188', NULL);

-- A2. CRIAÇÃO DO FUNCIONÁRIO DE SISTEMA (ID 1)
INSERT INTO Funcionario (idFuncionario, nome, cpf, email, senha, fkEmpresa, fkTipoUsuario, fkCriadoPor) VALUES
(1, 'Sistema Oberon', '24519870855', 'sistema@oberon.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 1, 1004, 1),
(2, 'Dandara Ramos', '01010101010', 'dandara.ramos@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 1, 1004, 1),
(3, 'Jhoel Mita', '02020202020', 'jhoel.mita@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 1, 1004, 1),
(4, 'Miguel Lima', '03030303030', 'miguel.lima@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 1, 1004, 1),
(5, 'Pedro Sakaue', '04040404040', 'pedro.sakaue@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 1, 1004, 1),
(6, 'Bruna Martins', '05050505050', 'bruna.martins@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6',1, 1004, 1),
(7, 'Nathan Barbosa', '06060606060', 'nathan.barbosa@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 1, 1004, 1);