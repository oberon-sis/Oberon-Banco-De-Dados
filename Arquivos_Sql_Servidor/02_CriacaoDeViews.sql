use bdOberon;
-- ======================================================
-- 3. CRIAÇÃO DE VIEWS (COMPLETO E AJUSTADO)
-- ======================================================
CREATE OR REPLACE VIEW vw_ParametrosComponente AS
SELECT
    M.idMaquina,
    C.idComponente,
    TC.funcaoMonitorar,
    TC.unidadeMedida,
    C.origemParametro, 
    P.identificador,
    P.limite
FROM
    Maquina AS M
JOIN
    Componente AS C ON M.idMaquina = C.fkMaquina
JOIN
    TipoComponente AS TC ON
    (
        -- Condição para ligar TipoComponente a Componente
        (C.nucleosThreads IS NOT NULL AND TC.tipoComponete = 'CPU') OR
        (C.capacidadeGb IS NOT NULL AND C.tipoDisco IS NULL AND TC.tipoComponete = 'RAM') OR
        (C.capacidadeGb IS NOT NULL AND C.tipoDisco IS NOT NULL AND TC.tipoComponete = 'DISCO') OR
        (C.nucleosThreads IS NULL AND C.capacidadeGb IS NULL AND C.tipoDisco IS NULL AND TC.tipoComponete = 'REDE')
    )
JOIN
    Parametro AS P ON P.fkTipoComponente = C.fkTipoComponente
WHERE
    (
        -- Condição 1: Parâmetro ESPECÍFICO (P.fkComponente APONTA para C.idComponente e NÃO é NULL)
        (C.origemParametro = 'ESPECIFICO' AND P.fkEmpresa = M.fkEmpresa AND P.fkComponente IS NOT NULL AND P.fkComponente = C.idComponente)
    )
    OR
    (
        -- Condição 2: Parâmetro PADRÃO DA EMPRESA (P.fkComponente É NULL, é da empresa e é o tipo certo)
        (C.origemParametro = 'EMPRESA' AND P.fkEmpresa = M.fkEmpresa AND P.fkComponente IS NULL)
    )
    OR
    (
        -- Condição 3: Parâmetro PADRÃO OBERON (P.fkComponente É NULL, é da Oberon (ID 1) e é o tipo certo)
        (C.origemParametro = 'OBERON' AND P.fkEmpresa = 1 AND P.fkComponente IS NULL)
    )
ORDER BY
    M.idMaquina, C.idComponente, P.limite;
    
CREATE OR REPLACE VIEW vw_DadosMaquina AS
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

CREATE OR REPLACE VIEW vw_ComponentesParaAtualizar AS
SELECT
    C.idComponente,
    C.fkMaquina,
    CASE
        WHEN C.nucleosThreads IS NOT NULL THEN 'CPU'
        WHEN C.capacidadeGb IS NOT NULL AND C.tipoDisco IS NULL THEN 'RAM'
        WHEN C.capacidadeGb IS NOT NULL AND C.tipoDisco IS NOT NULL THEN 'DISCO'
        WHEN C.nucleosThreads IS NULL AND C.capacidadeGb IS NULL AND C.tipoDisco IS NULL THEN 'REDE'
        ELSE 'DESCONHECIDO'
    END AS tipoComponente
FROM
    Componente C;
    
CREATE OR REPLACE VIEW vw_AuditoriaUltimasAcoes AS
SELECT
    LA.horario,
    LA.acao,
    LA.descricao,
    LA.tabelaAfetada,
    LA.idAfetado,
    LA.valorAntigo,
    LA.valorNovo,
    F.nome AS usuarioResponsavel
FROM
    LogAuditoria AS LA
JOIN
    Funcionario AS F ON LA.fkFuncionario = F.idFuncionario
ORDER BY
    LA.horario DESC;
    

CREATE OR REPLACE VIEW vw_DetalhesIncidentes AS
SELECT
    I.chaveJira,
    I.titulo,
    I.status AS statusIncidente,
    I.severidade,
    I.dataCriacao,
    LDE.eventoCaptura,
    LDE.descricao AS descricaoLog,
    LS.tipoAcesso AS agenteOrigem,
    M.nome AS maquinaAfetada
FROM
    Incidente AS I
JOIN
    LogDetalheEvento AS LDE ON I.fkLogDetalheEvento = LDE.idLogDetalheEvento
JOIN
    LogSistema AS LS ON LDE.fkLogSistema = LS.idLogSistema
JOIN
    Maquina AS M ON LS.fkMaquina = M.idMaquina
ORDER BY
    I.dataCriacao DESC;
    
CREATE OR REPLACE VIEW vw_HistoricoAlertasAtivos AS
SELECT
    A.fkRegistro,
    A.nivel AS nivelAlerta,
    A.descricao AS motivoAlerta,
    R.horario AS horarioRegistro,
    R.valor AS valorColetado,
    M.nome AS maquinaAfetada,
    TC.tipoComponete AS tipoComponente,
    P.identificador AS limiteIdentificador
FROM
    Alerta AS A
JOIN
    Registro AS R ON A.fkRegistro = R.idRegistro
JOIN
    Componente AS C ON R.fkComponente = C.idComponente
JOIN
    Maquina AS M ON C.fkMaquina = M.idMaquina
JOIN
    Parametro AS P ON A.fkParametro = P.idParametro
JOIN
    TipoComponente AS TC ON P.fkTipoComponente = TC.idTipoComponente
ORDER BY
    R.horario DESC;
    