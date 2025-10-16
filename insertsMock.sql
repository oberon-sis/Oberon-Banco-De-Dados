USE bdOberon;

-- ** CONFIGURAÇÃO DE VARIÁVEIS DE INICIALIZAÇÃO **
SET @fkUsuarioDefault = 1;
SET @audit_user_id = 1;      -- ID do Funcionario 'Sistema Oberon'
SET @audit_session_id = 1;   -- ID da Sessão de Sistema

-- A3. CRIAÇÃO DA SESSÃO DE SISTEMA (ID 1)
-- Essencial para satisfazer a FK de LogAuditoria.
INSERT INTO SessaoUsuario (fkFuncionario, horarioLogin, horarioLogout) VALUES
(1, NOW(), NOW());

-- ******************************************************
-- B. INSERÇÃO DOS DEMAIS DADOS (Triggers Ativos)
-- ******************************************************

-- B1. Funcionários (Triggers AFTER INSERT aqui VÃO criar logs em LogAuditoria)
-- fkCriadoPor = 1 (Sistema Oberon) para os admins iniciais
SET @audit_user_id = 1;
SET @audit_session_id = 1;

INSERT INTO Funcionario (nome, cpf, email, senha, fkEmpresa, fkTipoUsuario, fkCriadoPor) VALUES
('Ana Souza', '12345678901', 'ana@techvision.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 2, 1, 1),
('Carlos Lima', '98765432100', 'carlos@inovacftv.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 3, 2, 1),
('Paula Mendes', '11111111111', 'paula@alphamonitor.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 4, 3, 1),
('Ricardo Farias', '22222222222', 'ricardo@betacftv.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 3, 1),
('Juliana Pires', '33333333333', 'juliana@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1, 1), -- ID 6
('Mariana Silva', '55555555555', 'mariana.s@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 3, 1),
('Roberto Nunes', '66666666666', 'roberto.n@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 2, 1),
('Sofia Castro', '77777777777', 'sofia.c@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 3, 1),
('Thiago Mendes', '88888888888', 'thiago.m@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 3, 1),
('Vitor Rocha', '13579246800', 'vitor.r@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 3, 1),
('Felipe Gomes', '44444444444', 'felipe@deltatech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 7, 3, 1),
('Dandara Ramos', '01010101010', 'dandara.ramos@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 2, 1),
('Jhoel Mita', '02020202020', 'jhoel.mita@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 2, 1),
('Miguel Lima', '03030303030', 'miguel.lima@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 2, 1),
('Pedro Sakaue', '04040404040', 'pedro.sakaue@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 2, 1),
('Bruna Martins', '05050505050', 'bruna.martins@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 2, 1),
('Nathan Barbosa', '06060606060', 'nathan.barbosa@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 2, 1);

-- B2. Máquinas (fkCriadoPor = 6, Juliana Pires)
SET @audit_user_id = 6; -- Juliana Pires (ID 6)
SET @audit_session_id = 1;

INSERT INTO Maquina (nome, hostname, modelo, macAddress, sistemaOperacional, status, fkEmpresa, fkCriadoPor) VALUES
('Estacao 01-E6', 'PC-E6-001', 'HP ProDesk 400', '00:1A:2B:3C:4D:51', 'Windows', 'Online', 6, 6),
('Estacao 02-E6', 'PC-E6-002', 'HP ProDesk 400', '00:1A:2B:3C:4D:52', 'Windows', 'Online', 6, 6),
('Estacao 03-E6', 'PC-E6-003','Dell OptiPlex 3050', '00:1A:2B:3C:4D:53', 'Windows', 'Online', 6, 6),
('Estacao 04-E6', 'PC-E6-004', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:54', 'Linux', 'Online', 6, 6),
('Estacao 05-E6', 'PC-E6-005', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:55', 'Windows', 'Online', 6, 6),
('Estacao 06-E6', 'PC-E6-006', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:56', 'Linux', 'Online', 6, 6),
('Estacao 07-E6', 'PC-E6-007', 'HP ProDesk 400', '00:1A:2B:3C:4D:57', 'Windows', 'Online', 6, 6),
('Estacao 08-E6', 'PC-E6-008', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:58', 'Windows', 'Online', 6, 6),
('Estacao 09-E6', 'PC-E6-009', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:59', 'Windows', 'Online', 6, 6),
('Estacao 10-E6', 'PC-E6-010', 'HP ProDesk 400', '00:1A:2B:3C:4D:5A', 'Linux', 'Online', 6, 6),
('Estacao 11-E6', 'PC-E6-011', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:5B', 'Windows', 'Manutenção', 6, 6),
('Estacao 12-E6', 'PC-E6-012', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:5C', 'Windows', 'Online', 6, 6),
('Estacao 13-E6', 'PC-E6-013', 'HP ProDesk 400', '00:1A:2B:3C:4D:5D', 'Windows', 'Online', 6, 6),
('Estacao 14-E6', 'PC-E6-014', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:5E', 'Linux', 'Online', 6, 6),
('Estacao 15-E6', 'PC-E6-015', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:5F', 'Windows', 'Online', 6, 6),
('Estacao 16-E6', 'PC-E6-016', 'HP ProDesk 400', '00:1A:2B:3C:4E:51', 'Windows', 'Online', 6, 6),
('Estacao 17-E6', 'PC-E6-017', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:52', 'Windows', 'Online', 6, 6),
('Estacao 18-E6', 'PC-E6-018', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:53', 'Linux', 'Online', 6, 6),
('Estacao 19-E6', 'PC-E6-019', 'HP ProDesk 400', '00:1A:2B:3C:4E:54', 'Windows', 'Offline', 6, 6),
('Estacao 20-E6', 'PC-E6-020', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:55', 'Windows', 'Pendente', 6, 6),
('Estacao 21-E6', 'PC-E6-021', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:56', 'Windows', 'Pendente', 6, 6),
('Estacao 22-E6', 'PC-E6-022', 'HP ProDesk 400', '00:1A:2B:3C:4E:57', 'Linux', 'Pendente', 6, 6),
('Estacao 23-E6', 'PC-E6-023', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:58', 'Windows', 'Pendente', 6, 6),
('Estacao 24-E6', 'PC-E6-024', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:59', 'Windows', 'Pendente', 6, 6),
('Estacao 25-E6', 'PC-E6-025', 'HP ProDesk 400', '00:1A:2B:3C:4E:5A', 'Windows', 'Pendente', 6, 6),
('Estacao 26-E6', 'PC-E6-026', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:5B', 'Linux', 'Pendente', 6, 6),
('Estacao 27-E6', 'PC-E6-027', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:5C', 'Windows', 'Pendente', 6, 6),
('Estacao 28-E6', 'PC-E6-028', 'HP ProDesk 400', '00:1A:2B:3C:4E:5D', 'Windows', 'Pendente', 6, 6),
('Estacao 29-E6', 'PC-E6-029', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:5E', 'Windows', 'Pendente', 6, 6),
('Estacao 30-E6', 'PC-E6-030', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:5F', 'Linux', 'Pendente', 6, 6),
('Estacao 31-E6', 'PC-E6-031', 'HP ProDesk 400', '00:1A:2B:3C:4F:51', 'Windows', 'Pendente', 6, 6),
('Estacao 32-E6', 'PC-E6-032', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:52', 'Windows', 'Pendente', 6, 6),
('Estacao 33-E6', 'PC-E6-033', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:53', 'Windows', 'Pendente', 6, 6),
('Estacao 34-E6', 'PC-E6-034', 'HP ProDesk 400', '00:1A:2B:3C:4F:54', 'Linux', 'Pendente', 6, 6),
('Estacao 35-E6', 'PC-E6-035', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:55', 'Windows', 'Pendente', 6, 6),
('Estacao 36-E6', 'PC-E6-036', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:56', 'Windows', 'Pendente', 6, 6),
('Estacao 37-E6', 'PC-E6-037', 'HP ProDesk 400', '00:1A:2B:3C:4F:57', 'Windows', 'Pendente', 6, 6),
('Estacao 38-E6', 'PC-E6-038', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:58', 'Linux', 'Pendente', 6, 6),
('Estacao 39-E6', 'PC-E6-039', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:59', 'Windows', 'Pendente', 6, 6),
('Estacao 40-E6', 'PC-E6-040', 'HP ProDesk 400', '00:1A:2B:3C:4F:5A', 'Windows', 'Pendente', 6, 6);

-- B3. Componentes (fkCriadoPor = 6)
INSERT INTO Componente (nucleosThreads, capacidadeGb, tipoDisco, fkMaquina, fkCriadoPor) VALUES
(8, NULL, NULL, 1, 6), (NULL, 16, NULL, 1, 6), (NULL, 500, 'SSD', 1, 6), (NULL, NULL, NULL, 1, 6),
(12, NULL, NULL, 2, 6), (NULL, 32, NULL, 2, 6), (NULL, 1000, 'HDD', 2, 6), (NULL, NULL, NULL, 2, 6),
(4, NULL, NULL, 3, 6), (NULL, 8, NULL, 3, 6), (NULL, 250, 'SSD', 3, 6), (NULL, NULL, NULL, 3, 6),
(8, NULL, NULL, 4, 6), (NULL, 16, NULL, 4, 6), (NULL, 500, 'SSD', 4, 6), (NULL, NULL, NULL, 4, 6),
(6, NULL, NULL, 5, 6), (NULL, 12, NULL, 5, 6), (NULL, 256, 'SSD', 5, 6), (NULL, NULL, NULL, 5, 6),
(4, NULL, NULL, 6, 6), (NULL, 8, NULL, 6, 6), (NULL, 500, 'HDD', 6, 6), (NULL, NULL, NULL, 6, 6),
(10, NULL, NULL, 7, 6), (NULL, 16, NULL, 7, 6), (NULL, 256, 'HDD', 7, 6), (NULL, NULL, NULL, 7, 6),
(8, NULL, NULL, 8, 6), (NULL, 16, NULL, 8, 6), (NULL, 500, 'SSD', 8, 6), (NULL, NULL, NULL, 8, 6),
(4, NULL, NULL, 9, 6), (NULL, 8, NULL, 9, 6), (NULL, 250, 'SSD', 9, 6), (NULL, NULL, NULL, 9, 6),
(12, NULL, NULL, 10, 6), (NULL, 32, NULL, 10, 6), (NULL, 1000, 'HDD', 10, 6), (NULL, NULL, NULL, 10, 6),
(8, NULL, NULL, 11, 6), (NULL, 16, NULL, 11, 6), (NULL, 500, 'SSD', 11, 6), (NULL, NULL, NULL, 11, 6),
(6, NULL, NULL, 12, 6), (NULL, 12, NULL, 12, 6), (NULL, 256, 'SSD', 12, 6), (NULL, NULL, NULL, 12, 6),
(4, NULL, NULL, 13, 6), (NULL, 8, NULL, 13, 6), (NULL, 500, 'HDD', 13, 6), (NULL, NULL, NULL, 13, 6),
(8, NULL, NULL, 14, 6), (NULL, 16, NULL, 14, 6), (NULL, 500, 'SSD', 14, 6), (NULL, NULL, NULL, 14, 6),
(12, NULL, NULL, 15, 6), (NULL, 32, NULL, 15, 6), (NULL, 1000, 'HDD', 15, 6), (NULL, NULL, NULL, 15, 6),
(4, NULL, NULL, 16, 6), (NULL, 8, NULL, 16, 6), (NULL, 250, 'SSD', 16, 6), (NULL, NULL, NULL, 16, 6),
(8, NULL, NULL, 17, 6), (NULL, 16, NULL, 17, 6), (NULL, 500, 'SSD', 17, 6), (NULL, NULL, NULL, 17, 6),
(6, NULL, NULL, 18, 6), (NULL, 12, NULL, 18, 6), (NULL, 256, 'SSD', 18, 6), (NULL, NULL, NULL, 18, 6);


-- B4. Parâmetros (fkCriadoPor = 1 ou 3 ou 6)
SET @audit_user_id = 6; -- Usando Juliana Pires (6) como criadora dos parâmetros
INSERT INTO Parametro (fkTipoComponente, fkEmpresa, fkComponente, limite, identificador, origemParametro, fkCriadoPor) VALUES
-- 1. Parâmetros OBERON (fkEmpresa = 1) - Criado pelo SISTEMA (ID 1)
(1, 1, 1, 95, 'CPU_OBERON', 'OBERON', 1),   
(2, 1, 1, 95, 'RAM_OBERON', 'OBERON', 1),   
(3, 1, 1, 98, 'DISCO_OBERON', 'OBERON', 1), 
(4, 1, 1, 800, 'REDE_OBERON', 'OBERON', 1), 

-- 2. Parâmetros Empresa (Exemplo: InovaCFTV - E3) - Criado por Carlos Lima (ID 3)
(1, 3, 5, 90, 'CPU_INOVA', 'EMPRESA', 3), 
(2, 3, 6, 85, 'RAM_INOVA', 'EMPRESA', 3), 
(3, 3, 7, 95, 'DISCO_INOVA', 'EMPRESA', 3), 
(4, 3, 8, 800, 'REDE_INOVA', 'EMPRESA', 3), 

-- 3. Parâmetros Empresa (Exemplo: SPTech Solutions - E6) - Criado por Juliana Pires (ID 6)
(1, 6, 21, 90, 'CPU_SPTECH', 'EMPRESA', 6), 
(2, 6, 22, 95, 'RAM_SPTECH', 'EMPRESA', 6), 
(3, 6, 23, 98, 'DISCO_SPTECH', 'EMPRESA', 6), 
(4, 6, 24, 700, 'REDE_SPTECH', 'EMPRESA', 6), 

-- 4. Parâmetros Específicos
(1, 6, 1, 88, 'CPU_M1_ESPEC', 'ESPECIFICA', 6),
(2, 6, 2, 95, 'RAM_M1_ESPEC', 'ESPECIFICA', 6),
(3, 6, 3, 80, 'DISCO_M1_ESPEC', 'ESPECIFICA', 6),
(4, 6, 4, 750, 'REDE_M1_ESPEC', 'ESPECIFICA', 6),
(1, 6, 17, 85, 'CPU_M5_ESPEC', 'ESPECIFICA', 6),
(2, 6, 18, 75, 'RAM_M5_ESPEC', 'ESPECIFICA', 6),
(3, 6, 19, 90, 'DISCO_M5_ESPEC', 'ESPECIFICA', 6),
(4, 6, 20, 900, 'REDE_M5_ESPEC', 'ESPECIFICA', 6),
(1, 6, 33, 89, 'CPU_M9_ESPEC', 'ESPECIFICA', 6),
(2, 6, 34, 80, 'RAM_M9_ESPEC', 'ESPECIFICA', 6),
(3, 6, 35, 85, 'DISCO_M9_ESPEC', 'ESPECIFICA', 6),
(4, 6, 36, 780, 'REDE_M9_ESPEC', 'ESPECIFICA', 6),
(1, 6, 49, 92, 'CPU_M13_ESPEC', 'ESPECIFICA', 6),
(2, 6, 50, 85, 'RAM_M13_ESPEC', 'ESPECIFICA', 6),
(3, 6, 51, 95, 'DISCO_M13_ESPEC', 'ESPECIFICA', 6),
(4, 6, 52, 650, 'REDE_M13_ESPEC', 'ESPECIFICA', 6),
(1, 6, 65, 82, 'CPU_M17_ESPEC', 'ESPECIFICA', 6),
(2, 6, 66, 90, 'RAM_M17_ESPEC', 'ESPECIFICA', 6),
(3, 6, 67, 92, 'DISCO_M17_ESPEC', 'ESPECIFICA', 6),
(4, 6, 68, 720, 'REDE_M17_ESPEC', 'ESPECIFICA', 6);


-- B5. REGISTRO (fkCriadoPor = 1 - Sistema)
SET @audit_user_id = 1; 

INSERT INTO Registro (valor, horario, fkComponente) VALUES
(89, '2025-09-21 08:00:00', 1), (96, '2025-09-21 08:00:00', 2), (70, '2025-09-21 08:00:00', 3), (760, '2025-09-21 08:00:00', 4),
(91, '2025-09-21 08:05:00', 5), (80, '2025-09-21 08:05:00', 6), (99, '2025-09-21 08:05:00', 7), (650, '2025-09-21 08:05:00', 8),
(93, '2025-09-21 08:10:00', 9), (90, '2025-09-21 08:10:00', 10), (95, '2025-09-21 08:10:00', 11), (750, '2025-09-21 08:10:00', 12),
(90, '2025-09-21 08:15:00', 13), (96, '2025-09-21 08:15:00', 14), (95, '2025-09-21 08:15:00', 15), (710, '2025-09-21 08:15:00', 16),
(86, '2025-09-21 08:20:00', 17), (76, '2025-09-21 08:20:00', 18), (91, '2025-09-21 08:20:00', 19), (950, '2025-09-21 08:20:00', 20),
(93, '2025-09-21 08:25:00', 21), (88, '2025-09-21 08:25:00', 22), (97, '2025-09-21 08:25:00', 23), (800, '2025-09-21 08:25:00', 24),
(92, '2025-09-21 08:30:00', 25), (96, '2025-09-21 08:30:00', 26), (99, '2025-09-21 08:30:00', 27), (700, '2025-09-21 08:30:00', 28),
(93, '2025-09-21 08:35:00', 29), (95, '2025-09-21 08:35:00', 30), (97, '2025-09-21 08:35:00', 31), (750, '2025-09-21 08:35:00', 32),
(90, '2025-09-21 08:40:00', 33), (81, '2025-09-21 08:40:00', 34), (86, '2025-09-21 08:40:00', 35), (790, '2025-09-21 08:40:00', 36),
(91, '2025-09-21 08:45:00', 37), (96, '2025-09-21 08:45:00', 38), (99, '2025-09-21 08:45:00', 39), (710, '2025-09-21 08:45:00', 40),
(93, '2025-09-21 08:50:00', 41), (90, '2025-09-21 08:50:00', 42), (95, '2025-09-21 08:50:00', 43), (700, '2025-09-21 08:50:00', 44),
(91, '2025-09-21 08:55:00', 45), (96, '2025-09-21 08:55:00', 46), (99, '2025-09-21 08:55:00', 47), (710, '2025-09-21 08:55:00', 48),
(95, '2025-09-21 09:00:00', 49), (86, '2025-09-21 09:00:00', 50), (98, '2025-09-21 09:00:00', 51), (651, '2025-09-21 09:00:00', 52),
(92, '2025-09-21 09:05:00', 53), (95, '2025-09-21 09:05:00', 54), (97, '2025-09-21 09:05:00', 55), (750, '2025-09-21 09:05:00', 56),
(91, '2025-09-21 09:10:00', 57), (96, '2025-09-21 09:10:00', 58), (99, '2025-09-21 09:10:00', 59), (710, '2025-09-21 09:10:00', 60),
(93, '2025-09-21 09:15:00', 61), (90, '2025-09-21 09:15:00', 62), (95, '2025-09-21 09:15:00', 63), (750, '2025-09-21 09:15:00', 64),
(83, '2025-09-21 09:20:00', 65), (91, '2025-09-21 09:20:00', 66), (93, '2025-09-21 09:20:00', 67), (750, '2025-09-21 09:20:00', 68),
(91, '2025-09-21 09:25:00', 69), (96, '2025-09-21 09:25:00', 70), (99, '2025-09-21 09:25:00', 71), (710, '2025-09-21 09:25:00', 72);


-- B6. ALERTA (fkCriadoPor = 6 - Juliana Pires)
SET @audit_user_id = 6;
select * from Parametro;
INSERT INTO Alerta (descricao, nivel, fkRegistro, fkParametro ) VALUES
( 'CPU Acima do Limite Específico', 'Critico', 1, 1), 
( 'RAM Acima do Limite Específico', 'Crítico', 2, 2), 
( 'CPU Acima do Limite Padrão E6', 'Atencao', 5, 21), 
( 'Disco Acima do Limite Padrão E6', 'Atencao', 7, 23), 
( 'CPU Acima do Limite Oberon', 'Crítico', 9, 1), 
( 'RAM Acima do Limite Oberon', 'Atencao', 10, 2), 
( 'Disco Acima do Limite Oberon', 'Atencao', 11, 3), 
( 'RAM Acima do Limite Padrão E6', 'Crítico', 14, 22), 
( 'Rede Acima do Limite Padrão E6', 'Atencao', 16, 24), 
( 'CPU Acima do Limite Específico', 'Atencao', 17, 25), 
( 'RAM Acima do Limite Específico', 'Crítico', 18, 26), 
( 'Disco Acima do Limite Específico', 'Atencao', 19, 27), 
( 'Rede Acima do Limite Específico', 'Atencao', 20, 28), 
( 'CPU Acima do Limite Oberon', 'Crítico', 21, 1), 
( 'CPU Acima do Limite Padrão E6', 'Atencao', 25, 21), 
( 'RAM Acima do Limite Padrão E6', 'Crítico', 26, 22), 
( 'Disco Acima do Limite Padrão E6', 'Atencao', 27, 23), 
( 'CPU Acima do Limite Oberon', 'Crítico', 29, 1), 
( 'RAM Acima do Limite Oberon', 'Atencao', 30, 2), 
( 'CPU Acima do Limite Específico', 'Atencao', 33, 29), 
( 'RAM Acima do Limite Específico', 'Crítico', 34, 30), 
( 'CPU Acima do Limite Padrão E6', 'Atencao', 37, 21), 
( 'RAM Acima do Limite Padrão E6', 'Crítico', 38, 22), 
( 'CPU Acima do Limite Oberon', 'Crítico', 41, 1), 
( 'RAM Acima do Limite Padrão E6', 'Crítico', 46, 22), 
( 'Disco Acima do Limite Padrão E6', 'Atencao', 47, 23), 
( 'CPU Acima do Limite Específico', 'Crítico', 49, 32), 
( 'Disco Acima do Limite Específico', 'Atencao', 51, 32), 
( 'Rede Abaixo do Limite Específico', 'Atencao', 52, 32), 
( 'RAM Acima do Limite Oberon', 'Atencao', 54, 2), 
( 'RAM Acima do Limite Padrão E6', 'Crítico', 58, 22), 
( 'CPU Acima do Limite Específico', 'Atencao', 65, 32), 
( 'RAM Acima do Limite Padrão E6', 'Crítico', 70, 22); 
