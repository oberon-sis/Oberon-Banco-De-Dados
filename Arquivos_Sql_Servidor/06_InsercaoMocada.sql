USE bdOberon;

-- ======================================================
-- A. CONFIGURAÇÃO DE VARIÁVEIS E DADOS DE SISTEMA (ATOMICIDADE)
-- ======================================================

SET @ID_FUNCIONARIO_LOGADO = 1; 

INSERT INTO Empresa (idEmpresa, razaoSocial, cnpj) VALUES
(2, 'TechVision Segurança', '13579246000101'),-- ID 2
(3, 'InovaCFTV Soluções', '24680135000122'),-- ID 3
(4, 'AlphaMonitor', '58197340000167'),-- ID 4
(5, 'BetaCFTV', '90456123000159'),-- ID 5
(6, 'ADT Monitoramento', '04273891000132'),-- ID 6
(7, 'SPTech Solutions', '04273891000133'),-- ID 6
(8, 'DeltaTech', '77014562000190'); -- ID 7

INSERT INTO Funcionario (nome, cpf, email, senha, fkEmpresa, fkTipoUsuario, fkCriadoPor) VALUES
('Ana Souza', '48239017601', 'ana@techvision.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 2, 1000, 1),
('Carlos Lima', '72154389020', 'carlos@inovacftv.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 3, 1001, 1),
('Paula Mendes', '00593467811', 'paula@alphamonitor.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 4, 1002, 1),
('Ricardo Farias', '83012975422', 'ricardo@betacftv.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1002, 1),
('Juliana Pires', '14578906333', 'juliana@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1000, 1),
('Mariana Silva', '69204185755', 'mariana.s@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1002, 1),
('Roberto Nunes', '90352618466', 'roberto.n@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1001, 1),
('Sofia Castro', '02871349577', 'sofia.c@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1002, 1),
('Thiago Mendes', '57463921088', 'thiago.m@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1002, 1),
('Vitor Rocha', '13579246800', 'vitor.r@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1002, 1),
('Felipe Gomes', '25648790344', 'felipe@deltatech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 7, 1002, 1),
('Dandara Ramos', '36925814710', 'dandara.ramos@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1001, 1),
('Jhoel Mita', '10842759320', 'jhoel.mita@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1001, 1),
('Armando', '74319682520', 'armando.adt@gmail.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1001, 1),
('Miguel Lima', '74319682530', 'miguel.lima@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1001, 1),
('Pedro Sakaue', '51206394740', 'pedro.sakaue@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1001, 1),
('Bruna Martins', '98734501250', 'bruna.martins@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1001, 1),
('Nathan Barbosa', '60178943260', 'nathan.barbosa@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1001, 1);



INSERT INTO Maquina (nome, hostname, modelo, macAddress, sistemaOperacional, status, fkEmpresa, ip, fkCriadoPor) VALUES
('Máquina-0021', 'PC-E6-001', 'HP ProDesk 400', 'C8:CB:9E:5A:5D:A6', 'Windows', 'Online', 6, '192.168.1.101', 1),
('Máquina-0022', 'PC-E6-002', 'HP ProDesk 400', '00:1A:2B:3C:4D:52', 'Windows', 'Online', 6, '192.168.1.102', 1),
('Máquina-0001', 'PC-E6-003','Dell OptiPlex 3050', '00:1A:2B:3C:4D:53', 'Windows', 'Offline', 6, '192.168.1.103', 1),
('Máquina-0002', 'PC-E6-004', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:54', 'Linux', 'Online', 6, '192.168.1.104', 1),
('Máquina-0015', 'PC-E6-005', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:55', 'Windows', 'Online', 6, '192.168.1.105', 1),
('Máquina-0030', 'PC-E6-006', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:56', 'Linux', 'Manutenção', 6, '192.168.1.106', 1);
-- ('Estacao 07-E6', 'PC-E6-007', 'HP ProDesk 400', '00:1A:2B:3C:4D:57', 'Windows', 'Online', 6, '192.168.1.107', 1),
-- ('Estacao 08-E6', 'PC-E6-008', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:58', 'Windows', 'Online', 6, '192.168.1.108', 1),
-- ('Estacao 09-E6', 'PC-E6-009', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:59', 'Windows', 'Online', 6, '192.168.1.109', 1),
-- ('Estacao 10-E6', 'PC-E6-010', 'HP ProDesk 400', '00:1A:2B:3C:4D:5A', 'Linux', 'Online', 6, '192.168.1.110', 1),
-- ('Estacao 11-E6', 'PC-E6-011', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:5B', 'Windows', 'Manutenção', 6, '192.168.1.111', 1),
-- ('Estacao 12-E6', 'PC-E6-012', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:5C', 'Windows', 'Online', 6, '192.168.1.112', 1),
-- ('Estacao 13-E6', 'PC-E6-013', 'HP ProDesk 400', '00:1A:2B:3C:4D:5D', 'Windows', 'Online', 6, '192.168.1.113', 1),
-- ('Estacao 14-E6', 'PC-E6-014', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:5E', 'Linux', 'Online', 6, '192.168.1.114', 1),
-- ('Estacao 15-E6', 'PC-E6-015', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:5F', 'Windows', 'Online', 6, '192.168.1.115', 1),
-- ('Estacao 16-E6', 'PC-E6-016', 'HP ProDesk 400', '00:1A:2B:3C:4E:51', 'Windows', 'Online', 6, '192.168.1.116', 1),
-- ('Estacao 17-E6', 'PC-E6-017', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:52', 'Windows', 'Online', 6, '192.168.1.117', 1),
-- ('Estacao 18-E6', 'PC-E6-018', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:53', 'Linux', 'Online', 6, '192.168.1.118', 1),
-- ('Estacao 19-E6', 'PC-E6-019', 'HP ProDesk 400', '00:1A:2B:3C:4E:54', 'Windows', 'Offline', 6, '192.168.1.119', 1),
-- ('Estacao 20-E6', 'PC-E6-020', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:55', 'Windows', 'Pendente', 6, '192.168.1.120', 1),
-- ('Estacao 21-E6', 'PC-E6-021', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:56', 'Windows', 'Pendente', 6, '192.168.1.121', 1),
-- ('Estacao 22-E6', 'PC-E6-022', 'HP ProDesk 400', '00:1A:2B:3C:4E:57', 'Linux', 'Pendente', 6, '192.168.1.122', 1),
-- ('Estacao 23-E6', 'PC-E6-023', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:58', 'Windows', 'Pendente', 6, '192.168.1.123', 1),
-- ('Estacao 24-E6', 'PC-E6-024', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:59', 'Windows', 'Pendente', 6, '192.168.1.124', 1),
-- ('Estacao 25-E6', 'PC-E6-025', 'HP ProDesk 400', '00:1A:2B:3C:4E:5A', 'Windows', 'Pendente', 6, '192.168.1.125', 1),
-- ('Estacao 26-E6', 'PC-E6-026', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:5B', 'Linux', 'Pendente', 6, '192.168.1.126', 1),
-- ('Estacao 27-E6', 'PC-E6-027', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:5C', 'Windows', 'Pendente', 6, '192.168.1.127', 1),
-- ('Estacao 28-E6', 'PC-E6-028', 'HP ProDesk 400', '00:1A:2B:3C:4E:5D', 'Windows', 'Pendente', 6, '192.168.1.128', 1),
-- ('Estacao 29-E6', 'PC-E6-029', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:5E', 'Windows', 'Pendente', 6, '192.168.1.129', 1),
-- ('Estacao 30-E6', 'PC-E6-030', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:5F', 'Linux', 'Pendente', 6, '192.168.1.130', 1),
-- ('Estacao 31-E6', 'PC-E6-031', 'HP ProDesk 400', '00:1A:2B:3C:4F:51', 'Windows', 'Pendente', 6, '192.168.1.131', 1),
-- ('Estacao 32-E6', 'PC-E6-032', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:52', 'Windows', 'Pendente', 6, '192.168.1.132', 1),
-- ('Estacao 33-E6', 'PC-E6-033', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:53', 'Windows', 'Pendente', 6, '192.168.1.133', 1),
-- ('Estacao 34-E6', 'PC-E6-034', 'HP ProDesk 400', '00:1A:2B:3C:4F:54', 'Linux', 'Pendente', 6, '192.168.1.134', 1),
-- ('Estacao 35-E6', 'PC-E6-035', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:55', 'Windows', 'Pendente', 6, '192.168.1.135', 1),
-- ('Estacao 36-E6', 'PC-E6-036', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:56', 'Windows', 'Pendente', 6, '192.168.1.136', 1),
-- ('Estacao 37-E6', 'PC-E6-037', 'HP ProDesk 400', '00:1A:2B:3C:4F:57', 'Windows', 'Pendente', 6, '192.168.1.137', 1),
-- ('Estacao 38-E6', 'PC-E6-038', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:58', 'Linux', 'Pendente', 6, '192.168.1.138', 1),
-- ('Estacao 39-E6', 'PC-E6-039', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:59', 'Windows', 'Pendente', 6, '192.168.1.139', 1),
-- ('Estacao 40-E6', 'PC-E6-040', 'HP ProDesk 400', '00:1A:2B:3C:4F:5A', 'Windows', 'Pendente', 6, '192.168.1.140', 1);


INSERT INTO Componente (fkTipoComponente, nucleosThreads, capacidadeGb, tipoDisco, fkMaquina, origemParametro, fkCriadoPor) VALUES
-- Máquina 1 (fkMaquina=1): ESPECÍFICO (Corrigido o ENUM)
(1, 8, NULL, NULL, 1,'ESPECÍFICO', 1),
(2, NULL, 16, NULL, 1,'ESPECÍFICO', 1),
(3, NULL, 500, 'SSD', 1,'ESPECÍFICO', 1),
(4, NULL, NULL, NULL, 1,'ESPECÍFICO', 1),

-- Máquina 2 (fkMaquina=2): ESPECÍFICO
(1, 12, NULL, NULL, 2,'ESPECÍFICO', 1),
(2, NULL, 32, NULL, 2,'ESPECÍFICO', 1),
(3, NULL, 1000, 'HDD', 2,'ESPECÍFICO', 1),
(4, NULL, NULL, NULL, 2,'ESPECÍFICO', 1),

-- Máquina 3 (fkMaquina=3): ESPECÍFICO
(1, 4, NULL, NULL, 3,'ESPECÍFICO', 1),
(2, NULL, 8, NULL, 3,'ESPECÍFICO', 1),
(3, NULL, 250, 'SSD', 3,'ESPECÍFICO', 1),
(4, NULL, NULL, NULL, 3,'ESPECÍFICO', 1),

-- Máquina 4 (fkMaquina=4): ESPECÍFICO
(1, 8, NULL, NULL, 4,'ESPECÍFICO', 1),
(2, NULL, 16, NULL, 4,'ESPECÍFICO', 1),
(3, NULL, 500, 'SSD', 4,'ESPECÍFICO', 1),
(4, NULL, NULL, NULL, 4,'ESPECÍFICO', 1),

-- Máquina 5 (fkMaquina=5): EMPRESA
(1, 6, NULL, NULL, 5, 'EMPRESA', 1),
(2, NULL, 12, NULL, 5, 'EMPRESA', 1),
(3, NULL, 256, 'SSD', 5, 'EMPRESA', 1),
(4, NULL, NULL, NULL, 5, 'EMPRESA', 1),

-- Máquina 6 (fkMaquina=6): EMPRESA
(1, 4, NULL, NULL, 6, 'EMPRESA', 1),
(2, NULL, 8, NULL, 6, 'EMPRESA', 1),
(3, NULL, 500, 'HDD', 6, 'EMPRESA', 1),
(4, NULL, NULL, NULL, 6, 'EMPRESA', 1);

-- -- Máquina 7 (fkMaquina=7): EMPRESA
-- (1, 10, NULL, NULL, 7, 'EMPRESA', 1),
-- (2, NULL, 16, NULL, 7, 'EMPRESA', 1),
-- (3, NULL, 256, 'HDD', 7, 'EMPRESA', 1),
-- (4, NULL, NULL, NULL, 7, 'EMPRESA', 1),

-- -- Máquina 8 (fkMaquina=8): EMPRESA
-- (1, 8, NULL, NULL, 8, 'EMPRESA', 1),
-- (2, NULL, 16, NULL, 8, 'EMPRESA', 1),
-- (3, NULL, 500, 'SSD', 8, 'EMPRESA', 1),
-- (4, NULL, NULL, NULL, 8, 'EMPRESA', 1),

-- -- Máquinas 9 a 18: OBERON
-- (1, 4, NULL, NULL, 9, 'OBERON', 1), (2, NULL, 8, NULL, 9, 'OBERON', 1), (3, NULL, 250, 'SSD', 9, 'OBERON', 1), (4, NULL, NULL, NULL, 9, 'OBERON', 1),
-- (1, 12, NULL, NULL, 10, 'OBERON', 1), (2, NULL, 32, NULL, 10, 'OBERON', 1), (3, NULL, 1000, 'HDD', 10, 'OBERON', 1), (4, NULL, NULL, NULL, 10, 'OBERON', 1),
-- (1, 8, NULL, NULL, 11, 'OBERON', 1), (2, NULL, 16, NULL, 11, 'OBERON', 1), (3, NULL, 500, 'SSD', 11, 'OBERON', 1), (4, NULL, NULL, NULL, 11, 'OBERON', 1),
-- (1, 6, NULL, NULL, 12, 'OBERON', 1), (2, NULL, 12, NULL, 12, 'OBERON', 1), (3, NULL, 256, 'SSD', 12, 'OBERON', 1), (4, NULL, NULL, NULL, 12, 'OBERON', 1),
-- (1, 4, NULL, NULL, 13, 'OBERON', 1), (2, NULL, 8, NULL, 13, 'OBERON', 1), (3, NULL, 500, 'HDD', 13, 'OBERON', 1), (4, NULL, NULL, NULL, 13, 'OBERON', 1),
-- (1, 8, NULL, NULL, 14, 'OBERON', 1), (2, NULL, 16, NULL, 14, 'OBERON', 1), (3, NULL, 500, 'SSD', 14, 'OBERON', 1), (4, NULL, NULL, NULL, 14, 'OBERON', 1),
-- (1, 12, NULL, NULL, 15, 'OBERON', 1), (2, NULL, 32, NULL, 15, 'OBERON', 1), (3, NULL, 1000, 'HDD', 15, 'OBERON', 1), (4, NULL, NULL, NULL, 15, 'OBERON', 1),
-- (1, 4, NULL, NULL, 16, 'OBERON', 1), (2, NULL, 8, NULL, 16, 'OBERON', 1), (3, NULL, 250, 'SSD', 16, 'OBERON', 1), (4, NULL, NULL, NULL, 16, 'OBERON', 1),
-- (1, 8, NULL, NULL, 17, 'OBERON', 1), (2, NULL, 16, NULL, 17, 'OBERON', 1), (3, NULL, 500, 'SSD', 17, 'OBERON', 1), (4, NULL, NULL, NULL, 17, 'OBERON', 1),
-- (1, 6, NULL, NULL, 18, 'OBERON', 1), (2, NULL, 12, NULL, 18, 'OBERON', 1), (3, NULL, 256, 'SSD', 18, 'OBERON', 1), (4, NULL, NULL, NULL, 18, 'OBERON', 1);


INSERT INTO Parametro (fkTipoComponente, fkEmpresa, Limite, identificador, origemParametro, fkCriadoPor) VALUES
-- 1. Parâmetros OBERON (fkEmpresa = 1) - PADRÃO GLOBAL (fkComponente = 1)
-- CPU (Tipo 1)
(1, 1, 85, 'ATENÇÃO', 'OBERON', 1),
(1, 1, 90, 'ALERTA', 'OBERON', 1),
(1, 1,  95, 'CRITICO', 'OBERON', 1),
-- RAM (Tipo 2)
(2, 1, 85, 'ATENÇÃO', 'OBERON', 1), 
(2, 1, 90, 'ALERTA', 'OBERON', 1),
(2, 1, 95, 'CRITICO', 'OBERON', 1), 
-- DISCO (Tipo 3)
(3, 1, 88, 'ATENÇÃO', 'OBERON', 1),
(3, 1, 93, 'ALERTA', 'OBERON', 1), 
(3, 1, 98, 'CRITICO', 'OBERON', 1),
-- REDE (Tipo 4)
(4, 1, 600, 'ATENÇÃO', 'OBERON', 1), 
(4, 1, 700, 'ALERTA', 'OBERON', 1),
(4, 1, 800, 'CRITICO', 'OBERON', 1), 

-- CPU (Tipo 1)
(1, 3, 80, 'ATENÇÃO', 'EMPRESA', 1),
(1, 3, 85, 'ALERTA', 'EMPRESA', 1),
(1, 3, 90, 'CRITICO', 'EMPRESA', 1),
-- RAM (Tipo 2)
(2, 3, 75, 'ATENÇÃO', 'EMPRESA', 1),
(2, 3, 80, 'ALERTA', 'EMPRESA', 1),
(2, 3, 85, 'CRITICO', 'EMPRESA', 1),
-- DISCO (Tipo 3)
(3, 3, 85, 'ATENÇÃO', 'EMPRESA', 1),
(3, 3, 90, 'ALERTA', 'EMPRESA', 1),
(3, 3, 95, 'CRITICO', 'EMPRESA', 1),
-- REDE (Tipo 4)
(4, 3, 600, 'ATENÇÃO', 'EMPRESA', 1),
(4, 3, 700, 'ALERTA', 'EMPRESA', 1),
(4, 3, 800, 'CRITICO', 'EMPRESA', 1),

-- CPU (Tipo 1)
(1, 6, 80, 'ATENÇÃO', 'EMPRESA', 1),
(1, 6, 85, 'ALERTA', 'EMPRESA', 1),
(1, 6, 90, 'CRITICO', 'EMPRESA', 1),
-- RAM (Tipo 2)
(2, 6, 85, 'ATENÇÃO', 'EMPRESA', 1),
(2, 6, 90, 'ALERTA', 'EMPRESA', 1),
(2, 6, 95, 'CRITICO', 'EMPRESA', 1),
-- DISCO (Tipo 3)
(3, 6, 88, 'ATENÇÃO', 'EMPRESA', 1),
(3, 6, 93, 'ALERTA', 'EMPRESA', 1),
(3, 6, 98, 'CRITICO', 'EMPRESA', 1),
-- REDE (Tipo 4)
(4, 6, 500, 'ATENÇÃO', 'EMPRESA', 1),
(4, 6, 600, 'ALERTA', 'EMPRESA', 1),
(4, 6, 700, 'CRITICO', 'EMPRESA', 1);

INSERT INTO Parametro (fkTipoComponente, fkEmpresa, fkComponente, Limite, identificador, origemParametro, fkCriadoPor) VALUES

-- 4. Parâmetros Específicos - MÁQUINAS ESPECÍFICAS (fkEmpresa = 6)
-- CPU_M1 (Tipo 1 - Componente 1)
(1, 6, 1, 78, 'ATENÇÃO','ESPECÍFICO', 1),
(1, 6, 1, 83, 'ALERTA','ESPECÍFICO', 1),
(1, 6, 1, 88, 'CRITICO','ESPECÍFICO', 1),
-- RAM_M1 (Tipo 2 - Componente 2)
(2, 6, 2, 85, 'ATENÇÃO','ESPECÍFICO', 1),
(2, 6, 2, 90, 'ALERTA','ESPECÍFICO', 1),
(2, 6, 2, 95, 'CRITICO','ESPECÍFICO', 1),
-- DISCO_M1 (Tipo 3 - Componente 3)
(3, 6, 3, 70, 'ATENÇÃO','ESPECÍFICO', 1),
(3, 6, 3, 75, 'ALERTA','ESPECÍFICO', 1),
(3, 6, 3, 80, 'CRITICO','ESPECÍFICO', 1),
-- REDE_M1 (Tipo 4 - Componente 4)
(4, 6, 4, 550, 'ATENÇÃO','ESPECÍFICO', 1),
(4, 6, 4, 650, 'ALERTA','ESPECÍFICO', 1),
(4, 6, 4, 750, 'CRITICO','ESPECÍFICO', 1),

-- CPU_M5 (Tipo 1 - Componente 17)
(1, 6, 17, 75, 'ATENÇÃO','ESPECÍFICO', 1),
(1, 6, 17, 80, 'ALERTA','ESPECÍFICO', 1),
(1, 6, 17, 85, 'CRITICO','ESPECÍFICO', 1),
-- RAM_M5 (Tipo 2 - Componente 18)
(2, 6, 18, 65, 'ATENÇÃO','ESPECÍFICO', 1),
(2, 6, 18, 70, 'ALERTA','ESPECÍFICO', 1),
(2, 6, 18, 75, 'CRITICO','ESPECÍFICO', 1),
-- DISCO_M5 (Tipo 3 - Componente 19)
(3, 6, 19, 80, 'ATENÇÃO','ESPECÍFICO', 1),
(3, 6, 19, 85, 'ALERTA','ESPECÍFICO', 1),
(3, 6, 19, 90, 'CRITICO','ESPECÍFICO', 1),
-- REDE_M5 (Tipo 4 - Componente 20)
(4, 6, 20, 700, 'ATENÇÃO','ESPECÍFICO', 1),
(4, 6, 20, 800, 'ALERTA','ESPECÍFICO', 1),
(4, 6, 20, 900, 'CRITICO','ESPECÍFICO', 1);


INSERT INTO Registro (valor, horario, fkComponente) VALUES
(89, '2025-09-21 08:00:00', 1), (96, '2025-09-21 08:00:00', 2), (70, '2025-09-21 08:00:00', 3), (760, '2025-09-21 08:00:00', 4),
(91, '2025-09-21 08:05:00', 5), (80, '2025-09-21 08:05:00', 6), (99, '2025-09-21 08:05:00', 7), (650, '2025-09-21 08:05:00', 8),
(93, '2025-09-21 08:10:00', 9), (90, '2025-09-21 08:10:00', 10), (95, '2025-09-21 08:10:00', 11), (750, '2025-09-21 08:10:00', 12),
(90, '2025-09-21 08:15:00', 13), (96, '2025-09-21 08:15:00', 14), (95, '2025-09-21 08:15:00', 15), (710, '2025-09-21 08:15:00', 16),
(86, '2025-09-21 08:20:00', 17), (76, '2025-09-21 08:20:00', 18), (91, '2025-09-21 08:20:00', 19), (950, '2025-09-21 08:20:00', 20),
(93, '2025-09-21 08:25:00', 21), (88, '2025-09-21 08:25:00', 22), (97, '2025-09-21 08:25:00', 23), (800, '2025-09-21 08:25:00', 24);
-- (92, '2025-09-21 08:30:00', 25), (96, '2025-09-21 08:30:00', 26), (99, '2025-09-21 08:30:00', 27), (700, '2025-09-21 08:30:00', 28),
-- (93, '2025-09-21 08:35:00', 29), (95, '2025-09-21 08:35:00', 30), (97, '2025-09-21 08:35:00', 31), (750, '2025-09-21 08:35:00', 32),
-- (90, '2025-09-21 08:40:00', 33), (81, '2025-09-21 08:40:00', 34), (86, '2025-09-21 08:40:00', 35), (790, '2025-09-21 08:40:00', 36),
-- (91, '2025-09-21 08:45:00', 37), (96, '2025-09-21 08:45:00', 38), (99, '2025-09-21 08:45:00', 39), (710, '2025-09-21 08:45:00', 40),
-- (93, '2025-09-21 08:50:00', 41), (90, '2025-09-21 08:50:00', 42), (95, '2025-09-21 08:50:00', 43), (700, '2025-09-21 08:50:00', 44),
-- (91, '2025-09-21 08:55:00', 45), (96, '2025-09-21 08:55:00', 46), (99, '2025-09-21 08:55:00', 47), (710, '2025-09-21 08:55:00', 48),
-- (95, '2025-09-21 09:00:00', 49), (86, '2025-09-21 09:00:00', 50), (98, '2025-09-21 09:00:00', 51), (651, '2025-09-21 09:00:00', 52),
-- (92, '2025-09-21 09:05:00', 53), (95, '2025-09-21 09:05:00', 54), (97, '2025-09-21 09:05:00', 55), (750, '2025-09-21 09:05:00', 56),
-- (91, '2025-09-21 09:10:00', 57), (96, '2025-09-21 09:10:00', 58), (99, '2025-09-21 09:10:00', 59), (710, '2025-09-21 09:10:00', 60),
-- (93, '2025-09-21 09:15:00', 61), (90, '2025-09-21 09:15:00', 62), (95, '2025-09-21 09:15:00', 63), (750, '2025-09-21 09:15:00', 64),
-- (83, '2025-09-21 09:20:00', 65), (91, '2025-09-21 09:20:00', 66), (93, '2025-09-21 09:20:00', 67), (750, '2025-09-21 09:20:00', 68),
-- (91, '2025-09-21 09:25:00', 69), (96, '2025-09-21 09:25:00', 70), (99, '2025-09-21 09:25:00', 71), (710, '2025-09-21 09:25:00', 72);
select * from Registro;

INSERT INTO Alerta (descricao, nivel, fkRegistro, fkParametro ) VALUES
( 'CPU Acima do Limite Específico', 'CRITICO', 4, 3),
( 'RAM Acima do Limite Específico', 'CRITICO', 5, 6),
( 'CPU Acima do Limite Padrão E6', 'ATENÇÃO', 6, 21),
( 'Disco Acima do Limite Padrão E6', 'ATENÇÃO', 7, 23),
( 'CPU Acima do Limite Oberon', 'CRITICO', 9, 3),
( 'RAM Acima do Limite Oberon', 'ATENÇÃO', 10, 4),
( 'Disco Acima do Limite Oberon', 'ATENÇÃO', 11, 7),
( 'RAM Acima do Limite Padrão E6', 'CRITICO', 14, 23),
( 'Rede Acima do Limite Padrão E6', 'ATENÇÃO', 16, 24),
( 'CPU Acima do Limite Específico', 'ATENÇÃO', 17, 25),
( 'RAM Acima do Limite Específico', 'CRITICO', 18, 26),
( 'Disco Acima do Limite Específico', 'ATENÇÃO', 19, 27),
( 'Rede Acima do Limite Específico', 'ATENÇÃO', 20, 28),
( 'CPU Acima do Limite Oberon', 'CRITICO', 21, 3);
-- ( 'CPU Acima do Limite Padrão E6', 'ATENÇÃO', 25, 21),
-- ( 'RAM Acima do Limite Padrão E6', 'CRITICO', 26, 22),
-- ( 'Disco Acima do Limite Padrão E6', 'ATENÇÃO', 27, 23),
-- ( 'CPU Acima do Limite Oberon', 'CRITICO', 29, 3),
-- ( 'RAM Acima do Limite Oberon', 'ATENÇÃO', 30, 4),
-- ( 'CPU Acima do Limite Específico', 'ATENÇÃO', 33, 29),
-- ( 'RAM Acima do Limite Específico', 'CRITICO', 34, 32),
-- ( 'CPU Acima do Limite Padrão E6', 'ATENÇÃO', 37, 21),
-- ( 'RAM Acima do Limite Padrão E6', 'CRITICO', 38, 22),
-- ( 'CPU Acima do Limite Oberon', 'CRITICO', 41, 3),
-- ( 'RAM Acima do Limite Padrão E6', 'CRITICO', 46, 22),
-- ( 'Disco Acima do Limite Padrão E6', 'ATENÇÃO', 47, 23),
-- ( 'CPU Acima do Limite Específico', 'CRITICO', 49, 32),
-- ( 'Disco Acima do Limite Específico', 'ATENÇÃO', 51, 32),
-- ( 'Rede Abaixo do Limite Específico', 'ATENÇÃO', 52, 32);