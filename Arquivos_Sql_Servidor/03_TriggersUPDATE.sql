use bdOberon;
DELIMITER $$
-- =============================================
-- 3. TRIGGERS DE LOGAUDITORIA (UPDATE)
-- =============================================
-- MAQUINA
DROP TRIGGER IF EXISTS tr_Maquina_AntesUpdate$$
CREATE TRIGGER tr_Maquina_AntesUpdate
AFTER UPDATE ON Maquina
FOR EACH ROW
BEGIN
    
    SET @OLD_CHANGES = '';
    SET @NEW_CHANGES = '';

    -- Função para adicionar alterações
    -- Usa <=> para comparação NULL-safe
    IF NOT (OLD.nome <=> NEW.nome) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"nome": "', OLD.nome, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"nome": "', NEW.nome, '", ');
    END IF;

    IF NOT (OLD.status <=> NEW.status) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"status": "', OLD.status, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"status": "', NEW.status, '", ');
    END IF;

    IF NOT (OLD.macAddress <=> NEW.macAddress) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"macAddress": "', OLD.macAddress, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"macAddress": "', NEW.macAddress, '", ');
    END IF;
    
    IF NOT (OLD.ip <=> NEW.ip) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"ip": "', OLD.ip, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"ip": "', NEW.ip, '", ');
    END IF;

    IF NOT (OLD.hostname <=> NEW.hostname) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"hostname": "', OLD.hostname, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"hostname": "', NEW.hostname, '", ');
    END IF;
    
    IF NOT (OLD.modelo <=> NEW.modelo) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"modelo": "', OLD.modelo, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"modelo": "', NEW.modelo, '", ');
    END IF;

    IF NOT (OLD.sistemaOperacional <=> NEW.sistemaOperacional) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"sistemaOperacional": "', OLD.sistemaOperacional, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"sistemaOperacional": "', NEW.sistemaOperacional, '", ');
    END IF;

    -- 1. Remove a vírgula e o espaço finais da string de JSON (', ')
    -- 2. Constrói o JSON completo: '{' + conteúdo + '}'
    IF LENGTH(@NEW_CHANGES) > 0 THEN
        SET @OLD_VAL = CONCAT('{', LEFT(@OLD_CHANGES, LENGTH(@OLD_CHANGES) - 2), '}');
        SET @NEW_VAL = CONCAT('{', LEFT(@NEW_CHANGES, LENGTH(@NEW_CHANGES) - 2), '}');

        -- A partir daqui, o fluxo de log é o mesmo
        INSERT INTO LogAuditoria (fkFuncionario, acao, descricao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
        VALUES (
            NEW.fkEditadoPor,
            'UPDATE', 
            CONCAT('Atualização da máquina: [', OLD.nome, ']'), 
            'Maquina', 
            NEW.idMaquina, 
            @OLD_VAL,
            @NEW_VAL,
            NOW()
        );
    END IF;
END$$

-- =============================================
-- CORREÇÃO TOTAL: Tabela EMPRESA (Concatenação)
-- =============================================
DROP TRIGGER IF EXISTS tr_Empresa_AntesUpdate$$
CREATE TRIGGER tr_Empresa_AntesUpdate
AFTER UPDATE ON Empresa
FOR EACH ROW
BEGIN
    SET @OLD_CHANGES = '';
    SET @NEW_CHANGES = '';
    
    -- razaoSocial
    IF NOT (OLD.razaoSocial <=> NEW.razaoSocial) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"razaoSocial": "', OLD.razaoSocial, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"razaoSocial": "', NEW.razaoSocial, '", ');
    END IF;
    
    -- cnpj
    IF NOT (OLD.cnpj <=> NEW.cnpj) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"cnpj": "', OLD.cnpj, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"cnpj": "', NEW.cnpj, '", ');
    END IF;

    -- Finaliza JSON e insere
    IF LENGTH(@NEW_CHANGES) > 0 THEN
        SET @OLD_VAL = CONCAT('{', LEFT(@OLD_CHANGES, LENGTH(@OLD_CHANGES) - 2), '}');
        SET @NEW_VAL = CONCAT('{', LEFT(@NEW_CHANGES, LENGTH(@NEW_CHANGES) - 2), '}');

        INSERT INTO LogAuditoria (fkFuncionario, acao, descricao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
        VALUES (
            NEW.fkEditadoPor,
            'UPDATE', 
            CONCAT('Alteração em dados da Empresa: [', OLD.razaoSocial, ']'), 
            'Empresa', 
            NEW.idEmpresa, 
            @OLD_VAL,
            @NEW_VAL,
            NOW()
        );
    END IF;
END$$

-- =============================================
-- CORREÇÃO TOTAL: Tabela FUNCIONARIO (Concatenação)
-- =============================================
DROP TRIGGER IF EXISTS tr_Funcionario_AntesUpdate$$
CREATE TRIGGER tr_Funcionario_AntesUpdate
AFTER UPDATE ON Funcionario
FOR EACH ROW
BEGIN
    SET @OLD_CHANGES = '';
    SET @NEW_CHANGES = '';
    
    -- nome
    IF NOT (OLD.nome <=> NEW.nome) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"nome": "', OLD.nome, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"nome": "', NEW.nome, '", ');
    END IF;
    
    -- email
    IF NOT (OLD.email <=> NEW.email) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"email": "', OLD.email, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"email": "', NEW.email, '", ');
    END IF;
    
    -- fkTipoUsuario
    IF NOT (OLD.fkTipoUsuario <=> NEW.fkTipoUsuario) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"fkTipoUsuario": ', OLD.fkTipoUsuario, ', '); -- Sem aspas para INTEGER
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"fkTipoUsuario": ', NEW.fkTipoUsuario, ', '); -- Sem aspas para INTEGER
    END IF;

    -- Finaliza JSON e insere
    IF LENGTH(@NEW_CHANGES) > 0 THEN
        SET @OLD_VAL = CONCAT('{', LEFT(@OLD_CHANGES, LENGTH(@OLD_CHANGES) - 2), '}');
        SET @NEW_VAL = CONCAT('{', LEFT(@NEW_CHANGES, LENGTH(@NEW_CHANGES) - 2), '}');

        INSERT INTO LogAuditoria (fkFuncionario, acao, descricao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
        VALUES (
            NEW.fkEditadoPor,
            'UPDATE', 
            CONCAT('Atualização de cadastro/permissões do funcionário: [', OLD.nome, ']'), 
            'Funcionario', 
            NEW.idFuncionario, 
            @OLD_VAL,
            @NEW_VAL,
            NOW()
        );
    END IF;
END$$

-- =============================================
-- CORREÇÃO TOTAL: Tabela PARAMETRO (Concatenação)
-- =============================================
DROP TRIGGER IF EXISTS tr_Parametro_AntesUpdate$$
CREATE TRIGGER tr_Parametro_AntesUpdate
AFTER UPDATE ON Parametro
FOR EACH ROW
BEGIN
    SET @OLD_CHANGES = '';
    SET @NEW_CHANGES = '';

    -- limite (numérico)
    IF NOT (OLD.limite <=> NEW.limite) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"limite": ', OLD.limite, ', '); -- Numérico
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"limite": ', NEW.limite, ', '); -- Numérico
    END IF;
    
    -- origemParametro (string)
    IF NOT (OLD.origemParametro <=> NEW.origemParametro) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"origemParametro": "', OLD.origemParametro, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"origemParametro": "', NEW.origemParametro, '", ');
    END IF;
    
    -- identificador (string)
    IF NOT (OLD.identificador <=> NEW.identificador) THEN
        SET @OLD_CHANGES = CONCAT(@OLD_CHANGES, '"identificador": "', OLD.identificador, '", ');
        SET @NEW_CHANGES = CONCAT(@NEW_CHANGES, '"identificador": "', NEW.identificador, '", ');
    END IF;

    -- Finaliza JSON e insere
    IF LENGTH(@NEW_CHANGES) > 0 THEN
        SET @OLD_VAL = CONCAT('{', LEFT(@OLD_CHANGES, LENGTH(@OLD_CHANGES) - 2), '}');
        SET @NEW_VAL = CONCAT('{', LEFT(@NEW_CHANGES, LENGTH(@NEW_CHANGES) - 2), '}');

        INSERT INTO LogAuditoria (fkFuncionario, acao, descricao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
        VALUES (
            NEW.fkEditadoPor,
            'UPDATE', 
            CONCAT('Atualização de parâmetro de limite (ID ', NEW.idParametro, ')'), 
            'Parametro', 
            NEW.idParametro, 
            @OLD_VAL,
            @NEW_VAL,
            NOW()
        );
    END IF;
END$$

DELIMITER ;