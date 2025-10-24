use bdOberon;
DELIMITER $$
-- ======================================================
-- TRIGGERS DE LOGAUDITORIA (INSERT)
-- =============================================

-- Tabela FUNCIONARIO - AFTER INSERT
DROP TRIGGER IF EXISTS tr_Funcionario_AposInsert$$
CREATE TRIGGER tr_Funcionario_AposInsert
AFTER INSERT ON Funcionario
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkFuncionario, acao, descricao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (
        NEW.fkCriadoPor,
        'INSERT',
        CONCAT('Novo funcionário [', NEW.nome, '] cadastrado.'),
        'Funcionario',
        NEW.idFuncionario,
        JSON_OBJECT('nome', NEW.nome, 'email', NEW.email, 'cpf', NEW.cpf, 'criadoPor', NEW.fkCriadoPor),
        NOW()
    );
END$$

-- Tabela MAQUINA - AFTER INSERT
DROP TRIGGER IF EXISTS tr_Maquina_AposInsert$$
CREATE TRIGGER tr_Maquina_AposInsert
AFTER INSERT ON Maquina
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkFuncionario, acao, descricao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (
        NEW.fkCriadoPor, 
        'INSERT', 
        CONCAT('Nova máquina [', NEW.nome, '] registrada.'),
        'Maquina', 
        NEW.idMaquina, 
        JSON_OBJECT('nome', NEW.nome, 'mac', NEW.macAddress, 'status', NEW.status, 'criadoPor', NEW.fkCriadoPor), 
        NOW()
    );
END$$

-- Tabela PARAMETRO - AFTER INSERT
DROP TRIGGER IF EXISTS tr_Parametro_AposInsert$$
CREATE TRIGGER tr_Parametro_AposInsert
AFTER INSERT ON Parametro
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkFuncionario, acao, descricao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (
        NEW.fkCriadoPor, 
        'INSERT', 
        CONCAT('Novo parâmetro de limite (ID ', NEW.idParametro, ') criado.'),
        'Parametro', 
        NEW.idParametro, 
        JSON_OBJECT('fkTipo', NEW.fkTipoComponente, 'limite', NEW.limite, 'origem', NEW.origemParametro, 'criadoPor', NEW.fkCriadoPor), 
        NOW()
    );
END$$

-- Tabela TOKEN RECUPERACAO - AFTER INSERT
DROP TRIGGER IF EXISTS tr_TokenRecuperacao_AposInsert$$
CREATE TRIGGER tr_TokenRecuperacao_AposInsert
AFTER INSERT ON TokenRecuperacao
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkFuncionario, acao, descricao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (
        NEW.fkFuncionario, 
        'INSERT', 
        'Token de recuperação de senha gerado.',
        'TokenRecuperacao', 
        NEW.fkFuncionario, 
        JSON_OBJECT('fkFuncionario', NEW.fkFuncionario, 'expiracao', NEW.horarioExpiracao), 
        NOW()
    );
END$$
DELIMITER $$