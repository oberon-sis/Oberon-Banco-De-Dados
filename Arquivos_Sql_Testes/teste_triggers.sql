use bdOberon;

-- Configuração de IDs de Teste (baseado nos seus inserts)
SET @FUNCIONARIO_EDITOR_ID = 6; -- Mariana Silva (usado como fkEditadoPor)

-- ----------------------------------------
-- I. TESTE UPDATE: EMPRESA
-- ID 6: SPTech Solutions
-- ----------------------------------------
SELECT '--- TESTE 1: UPDATE EMPRESA (ID: 6) ---';

-- Caso 1.1: Mudar apenas a Razão Social
UPDATE Empresa
SET 
    razaoSocial = 'SPTech Solutions LTDA',
    fkEditadoPor = @FUNCIONARIO_EDITOR_ID 
WHERE idEmpresa = 6;

SELECT '1.1 Log da Empresa (Razão Social alterada):';
SELECT * FROM LogAuditoria WHERE tabelaAfetada = 'Empresa' AND idAfetado = 6 ORDER BY horario DESC LIMIT 1;


-- Caso 1.2: Mudar apenas o CNPJ
UPDATE Empresa
SET 
    cnpj = '04273891000199',
    fkEditadoPor = @FUNCIONARIO_EDITOR_ID
WHERE idEmpresa = 6;

SELECT '1.2 Log da Empresa (CNPJ alterado):';
SELECT * FROM LogAuditoria WHERE tabelaAfetada = 'Empresa' AND idAfetado = 6 ORDER BY horario DESC LIMIT 1;

-- ----------------------------------------
-- II. TESTE UPDATE: FUNCIONARIO
-- ID 1: Ana Souza
-- ----------------------------------------
SELECT '--- TESTE 2: UPDATE FUNCIONARIO (ID: 1) ---';

-- Caso 2.1: Mudar nome e email
UPDATE Funcionario
SET 
    nome = 'Ana Carolina Souza',
    email = 'ana.carolina@techvision.com',
    fkEditadoPor = @FUNCIONARIO_EDITOR_ID 
WHERE idFuncionario = 1;

SELECT '2.1 Log do Funcionário (Nome e Email alterados):';
SELECT * FROM LogAuditoria WHERE tabelaAfetada = 'Funcionario' AND idAfetado = 1 ORDER BY horario DESC LIMIT 1;

-- Caso 2.2: Mudar tipo de usuário
UPDATE Funcionario
SET 
    fkTipoUsuario = 1000, -- De volta para Admin
    fkEditadoPor = @FUNCIONARIO_EDITOR_ID
WHERE idFuncionario = 1;

SELECT '2.2 Log do Funcionário (fkTipoUsuario alterado):';
SELECT * FROM LogAuditoria WHERE tabelaAfetada = 'Funcionario' AND idAfetado = 1 ORDER BY horario DESC LIMIT 1;

-- ----------------------------------------
-- III. TESTE UPDATE: MAQUINA
-- ID 1: Estacao 01-E6
-- ----------------------------------------
SELECT '--- TESTE 3: UPDATE MAQUINA (ID: 1) ---';

-- Caso 3.1: Mudar status de Online para Manutenção
UPDATE Maquina
SET 
    status = 'Manutenção',
    fkEditadoPor = @FUNCIONARIO_EDITOR_ID 
WHERE idMaquina = 1;

SELECT '3.1 Log da Máquina (Status alterado - usa Concatenação):';
SELECT * FROM LogAuditoria WHERE tabelaAfetada = 'Maquina' AND idAfetado = 1 ORDER BY horario DESC LIMIT 1;


-- ----------------------------------------
-- IV. TESTE UPDATE: PARAMETRO
-- ID 1: Limite 85 para CPU (fkTipo=1, fkEmpresa=1)
-- ----------------------------------------
SELECT '--- TESTE 4: UPDATE PARAMETRO (ID: 1) ---';

-- Caso 4.1: Mudar o Limite (de 85 para 82)
UPDATE Parametro
SET 
    Limite = 82,
    fkEditadoPor = @FUNCIONARIO_EDITOR_ID 
WHERE idParametro = 1;

SELECT '4.1 Log do Parâmetro (Limite alterado):';
SELECT * FROM LogAuditoria WHERE tabelaAfetada = 'Parametro' AND idAfetado = 1 ORDER BY horario DESC LIMIT 1;