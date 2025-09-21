CREATE DATABASE upfinity;
USE upfinity;

-- Tabela de Endereços
CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(9) NOT NULL,
    uf CHAR(2) NOT NULL,
    cidade VARCHAR(70) NOT NULL,
    logradouro VARCHAR(70) NOT NULL,
    bairro VARCHAR(70) NOT NULL,
    complemento VARCHAR(80),
    latitude VARCHAR(45) NOT NULL,
    longitude VARCHAR(45) NOT NULL,
    numero INT NOT NULL
);

-- Tabela de Empresas
CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(45) NOT NULL,
    cnpj CHAR(14) NOT NULL
);

-- Tabela para os Tipos de Usuário (Permissões)
CREATE TABLE TipoUsuario (
    idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(45) NOT NULL,
    permissoes VARCHAR(255)
);

-- Tabela de Usuários
CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    fkTipoUsuario INT NOT NULL,
    nomeUsuario VARCHAR(45) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(250) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkTipoUsuario) REFERENCES TipoUsuario(idTipoUsuario)
);

-- Tabela de ATMs
CREATE TABLE Atm (
    idAtm INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    fkEndereco INT,
    hostname VARCHAR(45) NOT NULL,
    modelo VARCHAR(45) NOT NULL,
    ip VARCHAR(45) NOT NULL,
    macAddress VARCHAR(45) NOT NULL,
    sistemaOperacional VARCHAR(45) NOT NULL,
    statusAtm VARCHAR(45) NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco)
);

-- Tabela de Componentes
CREATE TABLE Componente (
    idComponente INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(45) NOT NULL,
    unidadeMedida VARCHAR(15) NOT NULL,
    funcaoMonitorada VARCHAR(45) NOT NULL
);

-- Tabela de Junção (relacionamento N:N) entre ATM e Componente
CREATE TABLE AtmComponente (
    idAtmComponente INT PRIMARY KEY AUTO_INCREMENT,
    fkAtm INT NOT NULL,
    fkComponente INT NOT NULL,
    capacidade VARCHAR(45),
    FOREIGN KEY (fkAtm) REFERENCES Atm(idAtm),
    FOREIGN KEY (fkComponente) REFERENCES Componente(idComponente)
);

-- Tabela para Definir os Limites de Monitoramento
CREATE TABLE Parametro (
    idParametro INT PRIMARY KEY AUTO_INCREMENT,
    fkAtmComponente INT NOT NULL,
    limite VARCHAR(45) NOT NULL,
    FOREIGN KEY (fkAtmComponente) REFERENCES AtmComponente(idAtmComponente)
);

-- Tabela de Alertas
CREATE TABLE Alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    fkAtmComponente INT,
    fkAtm INT,
    fkParametro INT,
    nivel VARCHAR(45) NOT NULL,
    tipoAlerta VARCHAR(45) NOT NULL,
    valorInicial FLOAT,
    valorFinal FLOAT,
    dataHoraInicio DATETIME NOT NULL,
    dataHoraFinal DATETIME,
    FOREIGN KEY (fkAtmComponente) REFERENCES AtmComponente(idAtmComponente),
    FOREIGN KEY (fkAtm) REFERENCES Atm(idAtm),
    FOREIGN KEY (fkParametro) REFERENCES Parametro(idParametro)
);

-- Tabela para o Registro dos Dados
CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    fkAtmComponente INT NOT NULL,
    horario DATETIME NOT NULL,
    valor FLOAT NOT NULL,
    FOREIGN KEY (fkAtmComponente) REFERENCES AtmComponente(idAtmComponente)
);


USE upfinity;

-- 1. View para Visualização de Dados de Usuários
-- Esta view combina informações de usuários, suas empresas e seus tipos de permissão.
CREATE VIEW vw_usuarios_detalhes AS
SELECT
    u.idUsuario,
    u.nomeUsuario,
    u.email,
    u.telefone,
    e.razaoSocial AS nomeEmpresa,
    tu.tipo AS tipoUsuario
FROM Usuario AS u
JOIN Empresa AS e ON u.fkEmpresa = e.idEmpresa
JOIN TipoUsuario AS tu ON u.fkTipoUsuario = tu.idTipoUsuario;

-- 2. View para a Situação Geral dos ATMs
-- Esta view mostra informações essenciais de cada ATM, incluindo o nome da empresa e o endereço completo.
CREATE VIEW vw_atm_situacao AS
SELECT
    a.idAtm,
    a.hostname,
    a.statusAtm,
    a.sistemaOperacional,
    e.razaoSocial AS nomeEmpresa,
    en.cidade,
    en.logradouro,
    en.numero
FROM Atm AS a
JOIN Empresa AS e ON a.fkEmpresa = e.idEmpresa
JOIN Endereco AS en ON a.fkEndereco = en.idEndereco;

-- 3. View para o Relacionamento entre ATMs e Componentes
-- Esta view detalha a configuração de cada componente em cada ATM.
CREATE VIEW vw_atm_componentes AS
SELECT
    ac.idAtmComponente,
    a.hostname AS nomeAtm,
    c.tipo AS tipoComponente,
    c.unidadeMedida,
    c.funcaoMonitorada,
    ac.capacidade
FROM AtmComponente AS ac
JOIN Atm AS a ON ac.fkAtm = a.idAtm
JOIN Componente AS c ON ac.fkComponente = c.idComponente;

-- 4. View para Detalhes de Parâmetros
-- Esta view mostra o limite de cada componente em um ATM, ligando o parâmetro ao tipo de componente.
CREATE VIEW vw_parametros_limites AS
SELECT
    p.idParametro,
    a.hostname AS nomeAtm,
    c.tipo AS tipoComponente,
    p.limite
FROM Parametro AS p
JOIN AtmComponente AS ac ON p.fkAtmComponente = ac.idAtmComponente
JOIN Atm AS a ON ac.fkAtm = a.idAtm
JOIN Componente AS c ON ac.fkComponente = c.idComponente;

-- 5. View para a Apresentação de Dados de Monitoramento
-- Esta view combina dados de registro com informações do ATM e do componente.
-- facilitando a apresentação do histórico de uso para cada componente.
CREATE VIEW vw_dados_monitoramento AS
SELECT
    a.hostname AS nomeAtm,
    a.ip AS ipAtm,
    e.razaoSocial AS nomeEmpresa,
    c.tipo AS tipoComponente,
    c.unidadeMedida,
    c.funcaoMonitorada,
    r.valor AS valorCapturado,
    p.limite,
    CAST(REPLACE(p.limite, '%', '') AS DECIMAL) - r.valor AS diferencaParaLimite,
    r.horario
FROM Registro AS r
JOIN AtmComponente AS ac ON r.fkAtmComponente = ac.idAtmComponente
JOIN Atm AS a ON ac.fkAtm = a.idAtm
JOIN Empresa AS e ON a.fkEmpresa = e.idEmpresa
JOIN Componente AS c ON ac.fkComponente = c.idComponente
JOIN Parametro AS p ON ac.idAtmComponente = p.fkAtmComponente;

-- 6. View para o Histórico de Alertas
-- Esta view oferece uma visão unificada e detalhada de todos os alertas.
-- Mostra a duração do alerta e especifica se é um alerta de componente ou do ATM em si.
CREATE VIEW vw_historico_alertas AS
SELECT
    COALESCE(a_atm.hostname, a_comp_atm.hostname) AS nomeAtm,
    CASE
        WHEN al.fkAtm IS NOT NULL THEN 'ATM'
        ELSE 'Componente'
    END AS origemAlerta,
    CASE
        WHEN al.fkAtmComponente IS NOT NULL THEN c.tipo
        ELSE 'Geral'
    END AS tipoAlertaDetalhado,
    al.nivel,
    al.tipoAlerta,
    al.valorInicial,
    al.valorFinal,
    al.dataHoraInicio,
    al.dataHoraFinal,
    CASE
        WHEN al.dataHoraFinal IS NOT NULL THEN TIMESTAMPDIFF(MINUTE, al.dataHoraInicio, al.dataHoraFinal)
        ELSE 'Em Andamento'
    END AS duracaoAlertaMinutos
FROM Alerta AS al
LEFT JOIN Atm AS a_atm ON al.fkAtm = a_atm.idAtm
LEFT JOIN AtmComponente AS ac ON al.fkAtmComponente = ac.idAtmComponente
LEFT JOIN Atm AS a_comp_atm ON ac.fkAtm = a_comp_atm.idAtm
LEFT JOIN Componente AS c ON ac.fkComponente = c.idComponente;


select * from vw_usuarios_detalhes;
select * from vw_atm_situacao;
select * from vw_atm_componentes;
select * from vw_parametros_limites;
select * from vw_dados_monitoramento;
select * from vw_historico_alertas;