
-- Variáveis globais para simular o usuário que está inserindo ou editando.
SET @fkUsuarioDefault = 1;
SET @audit_user_id = 1;
SET @audit_session_id = 1;

DELIMITER $$



-- =============================================
-- TRIGGERS PARA INJEÇÃO DE fkCriadoPor (BEFORE INSERT)
-- =============================================

-- Injeta o fkCriadoPor (Usuário Logado) no Funcionario
DROP TRIGGER IF EXISTS tr_Funcionario_AntesInsert$$
CREATE TRIGGER tr_Funcionario_AntesInsert
BEFORE INSERT ON Funcionario
FOR EACH ROW
BEGIN
    SET NEW.fkCriadoPor = IFNULL(@audit_user_id, @fkUsuarioDefault);
END$$

-- Injeta o fkCriadoPor (Usuário Logado) na Maquina
DROP TRIGGER IF EXISTS tr_Maquina_AntesInsert$$
CREATE TRIGGER tr_Maquina_AntesInsert
BEFORE INSERT ON Maquina
FOR EACH ROW
BEGIN
    SET NEW.fkCriadoPor = IFNULL(@audit_user_id, @fkUsuarioDefault);
END$$

-- Injeta o fkCriadoPor (Usuário Logado) no Componente
DROP TRIGGER IF EXISTS tr_Componente_AntesInsert$$
CREATE TRIGGER tr_Componente_AntesInsert
BEFORE INSERT ON Componente
FOR EACH ROW
BEGIN
    SET NEW.fkCriadoPor = IFNULL(@audit_user_id, @fkUsuarioDefault);
END$$

-- Injeta o fkCriadoPor (Usuário Logado) no Parametro
DROP TRIGGER IF EXISTS tr_Parametro_AntesInsert$$
CREATE TRIGGER tr_Parametro_AntesInsert
BEFORE INSERT ON Parametro
FOR EACH ROW
BEGIN
    SET NEW.fkCriadoPor = IFNULL(@audit_user_id, @fkUsuarioDefault);
END$$

-- Injeta o fkCriadoPor (Usuário Logado) no TokenRecuperacao
DROP TRIGGER IF EXISTS tr_TokenRecuperacao_AntesInsert$$
CREATE TRIGGER tr_TokenRecuperacao_AntesInsert
BEFORE INSERT ON TokenRecuperacao
FOR EACH ROW
BEGIN
    SET NEW.fkCriadoPor = IFNULL(@audit_user_id, @fkUsuarioDefault);
END$$

-- Injeta o fkCriadoPor (Usuário Logado) no Incidente
DROP TRIGGER IF EXISTS tr_Incidente_AntesInsert$$
CREATE TRIGGER tr_Incidente_AntesInsert
BEFORE INSERT ON Incidente
FOR EACH ROW
BEGIN
    SET NEW.fkCriadoPor = IFNULL(@audit_user_id, @fkUsuarioDefault);
END$$



-- trigesrt de insert na tabela log_auditoria

DROP TRIGGER IF EXISTS tr_Empresa_AntesUpdate$$
CREATE TRIGGER tr_Empresa_AntesUpdate
BEFORE UPDATE ON Empresa
FOR EACH ROW
BEGIN
    IF OLD.razaoSocial <> NEW.razaoSocial OR OLD.cnpj <> NEW.cnpj OR OLD.statusAprovacao <> NEW.statusAprovacao THEN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'UPDATE', 'SUCESSO', 'Empresa', NEW.idEmpresa, CONCAT('razaoSocial=', OLD.razaoSocial, ', cnpj=', OLD.cnpj, ', status=', OLD.statusAprovacao), CONCAT('razaoSocial=', NEW.razaoSocial, ', cnpj=', NEW.cnpj, ', status=', NEW.statusAprovacao), NOW());
    END IF;
END$$
DROP TRIGGER IF EXISTS tr_Empresa_AntesDelete$$
CREATE TRIGGER tr_Empresa_AntesDelete
BEFORE DELETE ON Empresa
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'DELETE', 'SUCESSO', 'Empresa', OLD.idEmpresa, CONCAT('razaoSocial=', OLD.razaoSocial, ', cnpj=', OLD.cnpj), 'REGISTRO DELETADO', NOW());
END$$

-- TRIGGERS FUNCIONARIO (4, 5, 6)
DROP TRIGGER IF EXISTS tr_Funcionario_AposInsert$$
CREATE TRIGGER tr_Funcionario_AposInsert
AFTER INSERT ON Funcionario
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'INSERT', 'SUCESSO', 'Funcionario', NEW.idFuncionario, CONCAT('nome=', NEW.nome, ', email=', NEW.email, ', cpf=', NEW.cpf, ', criadoPor=', NEW.fkCriadoPor), NOW());
END$$
DROP TRIGGER IF EXISTS tr_Funcionario_AntesUpdate$$
CREATE TRIGGER tr_Funcionario_AntesUpdate
BEFORE UPDATE ON Funcionario
FOR EACH ROW
BEGIN
    SET NEW.fkEditadoPor = IFNULL(@audit_user_id, NEW.fkEditadoPor);
    IF OLD.nome <> NEW.nome OR OLD.email <> NEW.email OR OLD.fkTipoUsuario <> NEW.fkTipoUsuario THEN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'UPDATE', 'SUCESSO', 'Funcionario', NEW.idFuncionario, CONCAT('nome=', OLD.nome, ', email=', OLD.email, ', tipo=', OLD.fkTipoUsuario, ', editadoPor=', OLD.fkEditadoPor), CONCAT('nome=', NEW.nome, ', email=', NEW.email, ', tipo=', NEW.fkTipoUsuario, ', editadoPor=', NEW.fkEditadoPor), NOW());
    END IF;
END$$
DROP TRIGGER IF EXISTS tr_Funcionario_AntesDelete$$
CREATE TRIGGER tr_Funcionario_AntesDelete
BEFORE DELETE ON Funcionario
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'DELETE', 'SUCESSO', 'Funcionario', OLD.idFuncionario, CONCAT('nome=', OLD.nome, ', email=', OLD.email), 'REGISTRO DELETADO', NOW());
END$$



-- TRIGGERS MAQUINA (13, 14, 15)
DROP TRIGGER IF EXISTS tr_Maquina_AposInsert$$
CREATE TRIGGER tr_Maquina_AposInsert
AFTER INSERT ON Maquina
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'INSERT', 'SUCESSO', 'Maquina', NEW.idMaquina, CONCAT('nome=', NEW.nome, ', mac=', NEW.macAddress, ', status=', NEW.status, ', criadoPor=', NEW.fkCriadoPor), NOW());
END$$
DROP TRIGGER IF EXISTS tr_Maquina_AntesUpdate$$
CREATE TRIGGER tr_Maquina_AntesUpdate
BEFORE UPDATE ON Maquina
FOR EACH ROW
BEGIN
    SET NEW.fkEditadoPor = IFNULL(@audit_user_id, NEW.fkEditadoPor);
    IF OLD.nome <> NEW.nome OR OLD.status <> NEW.status THEN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'UPDATE', 'SUCESSO', 'Maquina', NEW.idMaquina, CONCAT('nome=', OLD.nome, ', status=', OLD.status, ', editadoPor=', OLD.fkEditadoPor), CONCAT('nome=', NEW.nome, ', status=', NEW.status, ', editadoPor=', NEW.fkEditadoPor), NOW());
    END IF;
END$$
DROP TRIGGER IF EXISTS tr_Maquina_AntesDelete$$
CREATE TRIGGER tr_Maquina_AntesDelete
BEFORE DELETE ON Maquina
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'DELETE', 'SUCESSO', 'Maquina', OLD.idMaquina, CONCAT('nome=', OLD.nome, ', status=', OLD.status), 'REGISTRO DELETADO', NOW());
END$$

-- TRIGGERS COMPONENTE (16, 17, 18)
DROP TRIGGER IF EXISTS tr_Componente_AposInsert$$
CREATE TRIGGER tr_Componente_AposInsert
AFTER INSERT ON Componente
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'INSERT', 'SUCESSO', 'Componente', NEW.idComponente, CONCAT('id=', NEW.idComponente, ', cap=', NEW.capacidadeGb, ', criadoPor=', NEW.fkCriadoPor), NOW());
END$$
DROP TRIGGER IF EXISTS tr_Componente_AntesUpdate$$
CREATE TRIGGER tr_Componente_AntesUpdate
BEFORE UPDATE ON Componente
FOR EACH ROW
BEGIN
    SET NEW.fkEditadoPor = IFNULL(@audit_user_id, NEW.fkEditadoPor);
    IF OLD.capacidadeGb <> NEW.capacidadeGb OR OLD.nucleosThreads <> NEW.nucleosThreads THEN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'UPDATE', 'SUCESSO', 'Componente', NEW.idComponente, CONCAT('cap=', OLD.capacidadeGb, ', threads=', OLD.nucleosThreads, ', editadoPor=', OLD.fkEditadoPor), CONCAT('cap=', NEW.capacidadeGb, ', threads=', NEW.nucleosThreads, ', editadoPor=', NEW.fkEditadoPor), NOW());
    END IF;
END$$
DROP TRIGGER IF EXISTS tr_Componente_AntesDelete$$
CREATE TRIGGER tr_Componente_AntesDelete
BEFORE DELETE ON Componente
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'DELETE', 'SUCESSO', 'Componente', OLD.idComponente, CONCAT('id=', OLD.idComponente, ', mac=', OLD.fkMaquina), 'REGISTRO DELETADO', NOW());
END$$

-- TRIGGERS PARAMETRO (19, 20, 21)
DROP TRIGGER IF EXISTS tr_Parametro_AposInsert$$
CREATE TRIGGER tr_Parametro_AposInsert
AFTER INSERT ON Parametro
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'INSERT', 'SUCESSO', 'Parametro', NEW.idParametro, CONCAT('id=', NEW.idParametro, ', fkTipo=', NEW.fkTipoComponente, ', limite=', NEW.limite, ', origem=', NEW.origemParametro, ', criadoPor=', NEW.fkCriadoPor), NOW());
END$$
DROP TRIGGER IF EXISTS tr_Parametro_AntesUpdate$$
CREATE TRIGGER tr_Parametro_AntesUpdate
BEFORE UPDATE ON Parametro
FOR EACH ROW
BEGIN
    SET NEW.fkEditadoPor = IFNULL(@audit_user_id, NEW.fkEditadoPor);
    IF OLD.limite <> NEW.limite OR OLD.origemParametro <> NEW.origemParametro THEN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'UPDATE', 'SUCESSO', 'Parametro', NEW.idParametro, CONCAT('limite=', OLD.limite, ', origem=', OLD.origemParametro, ', editadoPor=', OLD.fkEditadoPor), CONCAT('limite=', NEW.limite, ', origem=', NEW.origemParametro, ', editadoPor=', NEW.fkEditadoPor), NOW());
    END IF;
END$$
DROP TRIGGER IF EXISTS tr_Parametro_AntesDelete$$
CREATE TRIGGER tr_Parametro_AntesDelete
BEFORE DELETE ON Parametro
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'DELETE', 'SUCESSO', 'Parametro', OLD.idParametro, CONCAT('id=', OLD.idParametro, ', limite=', OLD.limite), 'REGISTRO DELETADO', NOW());
END$$

-- TRIGGERS TOKEN RECUPERACAO (22, 23)
DROP TRIGGER IF EXISTS tr_TokenRecuperacao_AposInsert$$
CREATE TRIGGER tr_TokenRecuperacao_AposInsert
AFTER INSERT ON TokenRecuperacao
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'INSERT', 'SUCESSO', 'TokenRecuperacao', NEW.idTokenRecuperacao, CONCAT('fkUsuario=', NEW.fkUsuario, ', hash=', LEFT(NEW.hashToken, 10), '...', ', criadoPor=', NEW.fkCriadoPor), NOW());
END$$
-- Não há trigger BEFORE UPDATE pois tokens não devem ser atualizados
DROP TRIGGER IF EXISTS tr_TokenRecuperacao_AntesDelete$$
CREATE TRIGGER tr_TokenRecuperacao_AntesDelete
BEFORE DELETE ON TokenRecuperacao
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'DELETE', 'SUCESSO', 'TokenRecuperacao', OLD.idTokenRecuperacao, CONCAT('fkUsuario=', OLD.fkUsuario), 'REGISTRO DELETADO', NOW());
END$$

-- TRIGGERS INCIDENTE (24, 25, 26)
DROP TRIGGER IF EXISTS tr_Incidente_AposInsert$$
CREATE TRIGGER tr_Incidente_AposInsert
AFTER INSERT ON Incidente
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'INSERT', 'SUCESSO', 'Incidente', NEW.idIncidente, CONCAT('chaveJira=', NEW.chaveJira, ', status=', NEW.status, ', severidade=', NEW.severidade, ', criadoPor=', NEW.fkCriadoPor), NOW());
END$$
DROP TRIGGER IF EXISTS tr_Incidente_AntesUpdate$$
CREATE TRIGGER tr_Incidente_AntesUpdate
BEFORE UPDATE ON Incidente
FOR EACH ROW
BEGIN
    SET NEW.fkEditadoPor = IFNULL(@audit_user_id, NEW.fkEditadoPor);
    IF OLD.status <> NEW.status OR OLD.severidade <> NEW.severidade OR OLD.descricao <> NEW.descricao THEN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'UPDATE', 'SUCESSO', 'Incidente', NEW.idIncidente, CONCAT('status=', OLD.status, ', severidade=', OLD.severidade, ', desc=', OLD.descricao, ', editadoPor=', OLD.fkEditadoPor), CONCAT('status=', NEW.status, ', severidade=', NEW.severidade, ', desc=', NEW.descricao, ', editadoPor=', NEW.fkEditadoPor), NOW());
    END IF;
END$$
DROP TRIGGER IF EXISTS tr_Incidente_AntesDelete$$
CREATE TRIGGER tr_Incidente_AntesDelete
BEFORE DELETE ON Incidente
FOR EACH ROW
BEGIN
    INSERT INTO LogAuditoria (fkSessaoUsuario, acao, statusAcao, tabelaAfetada, idAfetado, valorAntigo, valorNovo, horario)
    VALUES (IFNULL(@audit_session_id, 1), 'DELETE', 'SUCESSO', 'Incidente', OLD.idIncidente, CONCAT('chaveJira=', OLD.chaveJira, ', titulo=', OLD.titulo), 'REGISTRO DELETADO', NOW());
END$$

-- Volta o delimitador ao padrão
DELIMITER ;