-- Garante que estamos no banco de dados correto
USE bdOberon;

-- ======================================================
-- 4.1. Gatilho para Exclusão de EMPRESA (Corrigido)
-- ======================================================

DROP TRIGGER IF EXISTS trg_log_empresa_delete;
DELIMITER $$
CREATE TRIGGER trg_log_empresa_delete
BEFORE DELETE ON Empresa
FOR EACH ROW
BEGIN
    -- Declaração de variáveis
    DECLARE v_num_funcionarios INT;
    DECLARE v_num_maquinas INT;
    DECLARE v_num_parametros INT;
    
    -- Se a variável de sessão não estiver definida, usa um valor padrão (ex: 1, Sistema Oberon)
    IF @USUARIO_LOGADO IS NULL THEN
        SET @USUARIO_LOGADO = 1; 
    END IF;
    
    -- 1. Contar registros relacionados
    SELECT COUNT(*) INTO v_num_funcionarios FROM Funcionario WHERE fkEmpresa = OLD.idEmpresa;
    SELECT COUNT(*) INTO v_num_maquinas FROM Maquina WHERE fkEmpresa = OLD.idEmpresa;
    SELECT COUNT(*) INTO v_num_parametros FROM Parametro WHERE fkEmpresa = OLD.idEmpresa;

    -- 2. Montar a descrição detalhada
    SET @descricao_log = CONCAT(
        'Exclusão em cascata iniciada por exclusão da Empresa: ', OLD.razaoSocial, ' (ID: ', OLD.idEmpresa, '). ',
        'Afetou: ', v_num_funcionarios, ' Funcionários; ',
        v_num_maquinas, ' Máquinas; ',
        v_num_parametros, ' Parâmetros de Empresa.'
    );

    -- 3. Inserir o registro no LogAuditoria usando a variável de sessão @USUARIO_LOGADO
    INSERT INTO LogAuditoria (fkFuncionario, idAfetado, acao, descricao, tabelaAfetada)
    VALUES (
        1, 
        OLD.idEmpresa,
        'DELETE CASCADE',
        @descricao_log,
        'Empresa'
    );
END$$
DELIMITER ;

-- ======================================================
-- 4.2. Gatilho para Exclusão de MÁQUINA (Corrigido)
-- ======================================================

DROP TRIGGER IF EXISTS trg_log_maquina_delete;
DELIMITER $$
CREATE TRIGGER trg_log_maquina_delete
BEFORE DELETE ON Maquina
FOR EACH ROW
BEGIN
    -- Declaração de variáveis
    DECLARE v_num_componentes INT;
    DECLARE v_num_logs_sistema INT;
    
    -- Se a variável de sessão não estiver definida, usa um valor padrão (ex: 1, Sistema Oberon)
    IF @USUARIO_LOGADO IS NULL THEN
        SET @USUARIO_LOGADO = 1; 
    END IF;
    
    -- 1. Contar registros relacionados
    SELECT COUNT(*) INTO v_num_componentes FROM Componente WHERE fkMaquina = OLD.idMaquina;
    SELECT COUNT(*) INTO v_num_logs_sistema FROM LogSistema WHERE fkMaquina = OLD.idMaquina;

    -- 2. Montar a descrição detalhada
    SET @descricao_log = CONCAT(
        'Exclusão em cascata iniciada por exclusão da Máquina: ', OLD.nome, ' (ID: ', OLD.idMaquina, '). ',
        'Afetou: ', v_num_componentes, ' Componentes; ',
        v_num_logs_sistema, ' Logs de Sistema.'
    );
    
    -- 3. Inserir o registro no LogAuditoria
    INSERT INTO LogAuditoria (fkFuncionario, idAfetado, acao, descricao, tabelaAfetada)
    VALUES (
        @USUARIO_LOGADO, -- AGORA USAMOS O USUÁRIO LOGADO NA SESSÃO
        OLD.idMaquina,
        'DELETE CASCADE',
        @descricao_log,
        'Maquina'
    );
END$$
DELIMITER ;

-- ======================================================
-- 4.3. Gatilho para Exclusão de COMPONENTE (Corrigido)
-- ======================================================

DROP TRIGGER IF EXISTS trg_log_componente_delete;
DELIMITER $$
CREATE TRIGGER trg_log_componente_delete
BEFORE DELETE ON Componente
FOR EACH ROW
BEGIN
    -- Declaração de variáveis
    DECLARE v_num_registros INT;
    DECLARE v_num_parametros INT;
    
    -- Se a variável de sessão não estiver definida, usa um valor padrão (ex: 1, Sistema Oberon)
    IF @USUARIO_LOGADO IS NULL THEN
        SET @USUARIO_LOGADO = 1; 
    END IF;
    
    -- 1. Contar registros relacionados
    SELECT COUNT(*) INTO v_num_registros FROM Registro WHERE fkComponente = OLD.idComponente;
    SELECT COUNT(*) INTO v_num_parametros FROM Parametro WHERE fkComponente = OLD.idComponente;
    
    -- 2. Montar a descrição detalhada
    SET @descricao_log = CONCAT(
        'Exclusão em cascata iniciada por exclusão do Componente ID: ', OLD.idComponente, '. ',
        'Afetou: ', v_num_registros, ' Registros de Coleta; ',
        v_num_parametros, ' Parâmetros Específicos.'
    );
    
    -- 3. Inserir o registro no LogAuditoria
    INSERT INTO LogAuditoria (fkFuncionario, idAfetado, acao, descricao, tabelaAfetada)
    VALUES (
        @USUARIO_LOGADO, -- AGORA USAMOS O USUÁRIO LOGADO NA SESSÃO
        OLD.idComponente,
        'DELETE CASCADE',
        @descricao_log,
        'Componente'
    );
END$$
DELIMITER ;