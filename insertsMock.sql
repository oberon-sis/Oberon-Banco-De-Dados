USE bdOberon;

-- A senha hash unificada é:'$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6
-- A senha para testar é Urubu100$
-- A empresa para testar é a fk 5
-- podem testar com os e-mails da faculdade 

INSERT INTO Empresa (razaoSocial, cnpj) VALUES
('TechVision Segurança', '12345678000199'),
('InovaCFTV Soluções', '98765432000155'),
('AlphaMonitor', '10101010101010'),
('BetaCFTV', '20202020202020'),
('SPTech Solutions', '30303030303030'), -- Empresa 5
('DeltaTech', '40404040404040');



INSERT INTO Funcionario (nome, cpf, email, senha, fkEmpresa, fkTipoUsuario) VALUES
('Ana Souza', '12345678901', 'ana@techvision.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 1, 1000),
('Carlos Lima', '98765432100', 'carlos@inovacftv.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 2, 1001),
('Paula Mendes', '11111111111', 'paula@alphamonitor.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 3, 1002),
('Ricardo Farias', '22222222222', 'ricardo@betacftv.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 4, 1002),

-- Funcionários SPTech Solutions (E5)
('Juliana Pires', '33333333333', 'juliana@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1001), -- Admin
('Mariana Silva', '55555555555', 'mariana.s@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1000), -- Colaborador
('Roberto Nunes', '66666666666', 'roberto.n@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1002), -- Gestor
('Sofia Castro', '77777777777', 'sofia.c@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1000), -- Colaborador
('Thiago Mendes', '88888888888', 'thiago.m@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1000), -- Colaborador
('Vitor Rocha', '13579246800', 'vitor.r@sptech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1000), -- Colaborador

('Felipe Gomes', '44444444444', 'felipe@deltatech.com', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 6, 1000);

INSERT INTO Funcionario (nome, cpf, email, senha, fkEmpresa, fkTipoUsuario) VALUES
('Dandara Ramos', '01010101010', 'dandara.ramos@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1002),
('Jhoel Mita', '02020202020', 'jhoel.mita@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1002),
('Miguel Lima', '03030303030', 'miguel.lima@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1002),
('Pedro Sakaue', '04040404040', 'pedro.sakaue@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1002),
('Bruna Martins', '05050505050', 'bruna.martins@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1002),
('Nathan Barbosa', '06060606060', 'nathan.barbosa@sptech.school', '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6', 5, 1002);

-- INSERTS: Maquina (Máquinas 1 a 10 monitoradas + Máquinas 11 a 18 monitoradas)
INSERT INTO Maquina (nome, hostname, modelo, macAddress, ip, sistemaOperacional, status, fkEmpresa) VALUES
('Estacao 01-E5', 'PC-E5-001', 'HP ProDesk 400', '00:1A:2B:3C:4D:51', '192.168.5.211', 'Windows', 'Online', 5), -- ID 1 (Monitorada)
('Estacao 02-E5', 'PC-E5-002', 'HP ProDesk 400', '00:1A:2B:3C:4D:52', '192.168.5.212', 'Windows', 'Online', 5), -- ID 2 (Monitorada)
('Estacao 03-E5', 'PC-E5-003', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:53', '192.168.5.213', 'Windows', 'Online', 5), -- ID 3 (Monitorada)
('Estacao 04-E5', 'PC-E5-004', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:54', '192.168.5.214', 'Linux', 'Online', 5), -- ID 4 (Monitorada)
('Estacao 05-E5', 'PC-E5-005', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:55', '192.168.5.215', 'Windows', 'Online', 5), -- ID 5 (Monitorada)
('Estacao 06-E5', 'PC-E5-006', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:56', '192.168.5.216', 'Linux', 'Online', 5), -- ID 6 (Monitorada)
('Estacao 07-E5', 'PC-E5-007', 'HP ProDesk 400', '00:1A:2B:3C:4D:57', '192.168.5.217', 'Windows', 'Online', 5), -- ID 7 (Monitorada)
('Estacao 08-E5', 'PC-E5-008', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:58', '192.168.5.218', 'Windows', 'Online', 5), -- ID 8 (Monitorada)
('Estacao 09-E5', 'PC-E5-009', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:59', '192.168.5.219', 'Windows', 'Online', 5), -- ID 9 (Monitorada)
('Estacao 10-E5', 'PC-E5-010', 'HP ProDesk 400', '00:1A:2B:3C:4D:5A', '192.168.5.220', 'Linux', 'Online', 5), -- ID 10 (Monitorada)
('Estacao 11-E5', 'PC-E5-011', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:5B', '192.168.5.221', 'Windows', 'Manutenção', 5), -- ID 11 (Monitorada)
('Estacao 12-E5', 'PC-E5-012', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:5C', '192.168.5.222', 'Windows', 'Online', 5), -- ID 12 (Monitorada)
('Estacao 13-E5', 'PC-E5-013', 'HP ProDesk 400', '00:1A:2B:3C:4D:5D', '192.168.5.223', 'Windows', 'Online', 5), -- ID 13 (Monitorada)
('Estacao 14-E5', 'PC-E5-014', 'Dell OptiPlex 3050', '00:1A:2B:3C:4D:5E', '192.168.5.224', 'Linux', 'Online', 5), -- ID 14 (Monitorada)
('Estacao 15-E5', 'PC-E5-015', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4D:5F', '192.168.5.225', 'Windows', 'Online', 5), -- ID 15 (Monitorada)
('Estacao 16-E5', 'PC-E5-016', 'HP ProDesk 400', '00:1A:2B:3C:4E:51', '192.168.5.226', 'Windows', 'Online', 5), -- ID 16 (Monitorada)
('Estacao 17-E5', 'PC-E5-017', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:52', '192.168.5.227', 'Windows', 'Online', 5), -- ID 17 (Monitorada)
('Estacao 18-E5', 'PC-E5-018', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:53', '192.168.5.228', 'Linux', 'Online', 5), -- ID 18 (Monitorada)
('Estacao 19-E5', 'PC-E5-019', 'HP ProDesk 400', '00:1A:2B:3C:4E:54', '192.168.5.229', 'Windows', 'Offline', 5),
('Estacao 20-E5', 'PC-E5-020', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:55', '192.168.5.230', 'Windows', 'Aguardando', 5),
('Estacao 21-E5', 'PC-E5-021', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:56', '192.168.5.231', 'Windows', 'Aguardando', 5),
('Estacao 22-E5', 'PC-E5-022', 'HP ProDesk 400', '00:1A:2B:3C:4E:57', '192.168.5.232', 'Linux', 'Aguardando', 5),
('Estacao 23-E5', 'PC-E5-023', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:58', '192.168.5.233', 'Windows', 'Aguardando', 5),
('Estacao 24-E5', 'PC-E5-024', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:59', '192.168.5.234', 'Windows', 'Aguardando', 5),
('Estacao 25-E5', 'PC-E5-025', 'HP ProDesk 400', '00:1A:2B:3C:4E:5A', '192.168.5.235', 'Windows', 'Aguardando', 5),
('Estacao 26-E5', 'PC-E5-026', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:5B', '192.168.5.236', 'Linux', 'Aguardando', 5),
('Estacao 27-E5', 'PC-E5-027', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:5C', '192.168.5.237', 'Windows', 'Aguardando', 5),
('Estacao 28-E5', 'PC-E5-028', 'HP ProDesk 400', '00:1A:2B:3C:4E:5D', '192.168.5.238', 'Windows', 'Aguardando', 5),
('Estacao 29-E5', 'PC-E5-029', 'Dell OptiPlex 3050', '00:1A:2B:3C:4E:5E', '192.168.5.239', 'Windows', 'Aguardando', 5),
('Estacao 30-E5', 'PC-E5-030', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4E:5F', '192.168.5.240', 'Linux', 'Aguardando', 5),
('Estacao 31-E5', 'PC-E5-031', 'HP ProDesk 400', '00:1A:2B:3C:4F:51', '192.168.5.241', 'Windows', 'Aguardando', 5),
('Estacao 32-E5', 'PC-E5-032', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:52', '192.168.5.242', 'Windows', 'Aguardando', 5),
('Estacao 33-E5', 'PC-E5-033', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:53', '192.168.5.243', 'Windows', 'Aguardando', 5),
('Estacao 34-E5', 'PC-E5-034', 'HP ProDesk 400', '00:1A:2B:3C:4F:54', '192.168.5.244', 'Linux', 'Aguardando', 5),
('Estacao 35-E5', 'PC-E5-035', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:55','192.168.5.888',  'Windows', 'Aguardando', 5),
('Estacao 36-E5', 'PC-E5-036', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:56', '192.168.5.246', 'Windows', 'Aguardando', 5),
('Estacao 37-E5', 'PC-E5-037', 'HP ProDesk 400', '00:1A:2B:3C:4F:57', '192.168.5.247', 'Windows', 'Aguardando', 5),
('Estacao 38-E5', 'PC-E5-038', 'Dell OptiPlex 3050', '00:1A:2B:3C:4F:58', '192.168.5.248', 'Linux', 'Aguardando', 5),
('Estacao 39-E5', 'PC-E5-039', 'Lenovo ThinkCentre M720', '00:1A:2B:3C:4F:59', '192.168.5.249', 'Windows', 'Aguardando', 5),
('Estacao 40-E5', 'PC-E5-040', 'HP ProDesk 400', '00:1A:2B:3C:4F:5A', '192.168.5.250', 'Windows', 'Aguardando', 5);


-- INSERTS: MaquinaComponente (Aumentando para Máquinas 1 a 18)
INSERT INTO MaquinaComponente (nucleosThreads, capacidadeGb, tipoDisco, fkMaquina, fkComponente, origemParametro) VALUES
-- M1 a M10 (40 inserts existentes)
(8, NULL, NULL, 1, 1, 'ESPECIFICO'), (NULL, 16, NULL, 1, 2, 'ESPECIFICO'), (NULL, 500, 'SSD', 1, 3, 'ESPECIFICO'), (NULL, NULL, NULL, 1, 4, 'ESPECIFICO'),
(12, NULL, NULL, 2, 1, 'EMPRESA'), (NULL, 32, NULL, 2, 2, 'EMPRESA'), (NULL, 1000, 'HDD', 2, 3, 'EMPRESA'), (NULL, NULL, NULL, 2, 4, 'EMPRESA'),
(4, NULL, NULL, 3, 1, 'OBERON'), (NULL, 8, NULL, 3, 2, 'OBERON'), (NULL, 250, 'SSD', 3, 3, 'OBERON'), (NULL, NULL, NULL, 3, 4, 'OBERON'),
(8, NULL, NULL, 4, 1, 'EMPRESA'), (NULL, 16, NULL, 4, 2, 'EMPRESA'), (NULL, 500, 'SSD', 4, 3, 'EMPRESA'), (NULL, NULL, NULL, 4, 4, 'EMPRESA'),
(6, NULL, NULL, 5, 1, 'ESPECIFICO'), (NULL, 12, NULL, 5, 2, 'ESPECIFICO'), (NULL, 256, 'SSD', 5, 3, 'ESPECIFICO'), (NULL, NULL, NULL, 5, 4, 'ESPECIFICO'),
(4, NULL, NULL, 6, 1, 'OBERON'), (NULL, 8, NULL, 6, 2, 'OBERON'), (NULL, 500, 'HDD', 6, 3, 'OBERON'), (NULL, NULL, NULL, 6, 4, 'OBERON'),
(10, NULL, NULL, 7, 1, 'EMPRESA'), (NULL, 16, NULL, 7, 2, 'EMPRESA'), (NULL, 256, 'HDD', 7, 3, 'EMPRESA'), (NULL, NULL, NULL, 7, 4, 'EMPRESA'),
(8, NULL, NULL, 8, 1, 'OBERON'), (NULL, 16, NULL, 8, 2, 'OBERON'), (NULL, 500, 'SSD', 8, 3, 'OBERON'), (NULL, NULL, NULL, 8, 4, 'OBERON'),
(4, NULL, NULL, 9, 1, 'ESPECIFICO'), (NULL, 8, NULL, 9, 2, 'ESPECIFICO'), (NULL, 250, 'SSD', 9, 3, 'ESPECIFICO'), (NULL, NULL, NULL, 9, 4, 'ESPECIFICO'),
(12, NULL, NULL, 10, 1, 'EMPRESA'), (NULL, 32, NULL, 10, 2, 'EMPRESA'), (NULL, 1000, 'HDD', 10, 3, 'EMPRESA'), (NULL, NULL, NULL, 10, 4, 'EMPRESA'),

-- M11 a M18 (32 novos inserts)
(8, NULL, NULL, 11, 1, 'OBERON'), (NULL, 16, NULL, 11, 2, 'OBERON'), (NULL, 500, 'SSD', 11, 3, 'OBERON'), (NULL, NULL, NULL, 11, 4, 'OBERON'), -- M11 (IDs 41-44)
(6, NULL, NULL, 12, 1, 'EMPRESA'), (NULL, 12, NULL, 12, 2, 'EMPRESA'), (NULL, 256, 'SSD', 12, 3, 'EMPRESA'), (NULL, NULL, NULL, 12, 4, 'EMPRESA'), -- M12 (IDs 45-48)
(4, NULL, NULL, 13, 1, 'ESPECIFICO'), (NULL, 8, NULL, 13, 2, 'ESPECIFICO'), (NULL, 500, 'HDD', 13, 3, 'ESPECIFICO'), (NULL, NULL, NULL, 13, 4, 'ESPECIFICO'), -- M13 (IDs 49-52)
(8, NULL, NULL, 14, 1, 'OBERON'), (NULL, 16, NULL, 14, 2, 'OBERON'), (NULL, 500, 'SSD', 14, 3, 'OBERON'), (NULL, NULL, NULL, 14, 4, 'OBERON'), -- M14 (IDs 53-56)
(12, NULL, NULL, 15, 1, 'EMPRESA'), (NULL, 32, NULL, 15, 2, 'EMPRESA'), (NULL, 1000, 'HDD', 15, 3, 'EMPRESA'), (NULL, NULL, NULL, 15, 4, 'EMPRESA'), -- M15 (IDs 57-60)
(4, NULL, NULL, 16, 1, 'OBERON'), (NULL, 8, NULL, 16, 2, 'OBERON'), (NULL, 250, 'SSD', 16, 3, 'OBERON'), (NULL, NULL, NULL, 16, 4, 'OBERON'), -- M16 (IDs 61-64)
(8, NULL, NULL, 17, 1, 'ESPECIFICO'), (NULL, 16, NULL, 17, 2, 'ESPECIFICO'), (NULL, 500, 'SSD', 17, 3, 'ESPECIFICO'), (NULL, NULL, NULL, 17, 4, 'ESPECIFICO'), -- M17 (IDs 65-68)
(6, NULL, NULL, 18, 1, 'EMPRESA'), (NULL, 12, NULL, 18, 2, 'EMPRESA'), (NULL, 256, 'SSD', 18, 3, 'EMPRESA'), (NULL, NULL, NULL, 18, 4, 'EMPRESA'); -- M18 (IDs 69-72)


INSERT INTO ParametroPadrao (limite, fkEmpresa, fkComponente) VALUES
(90, 2, 1),
(85, 2, 2),
(95, 2, 3),
(800, 2, 4),
(90, 5, 1), -- SPTech Solutions / CPU
(95, 5, 2), -- SPTech Solutions / RAM
(98, 5, 3), -- SPTech Solutions / DISCO
(700, 5, 4); -- SPTech Solutions / REDE


INSERT INTO ParametroEspecifico (limite, fkMaquinaComponente) VALUES
-- M1 (IDs 1-4)
(88, 1), (95, 2), (80, 3), (750, 4),
-- M5 (IDs 17-20)
(85, 17), (75, 18), (90, 19), (900, 20),
-- M9 (IDs 33-36)
(89, 33), (80, 34), (85, 35), (780, 36),
-- M13 (IDs 49-52)
(92, 49), (85, 50), (95, 51), (650, 52),
-- M17 (IDs 65-68)
(82, 65), (90, 66), (92, 67), (720, 68);


-- INSERTS: Registro (20 registros adicionais, totalizando 40)
INSERT INTO Registro (valor, horario, fkMaquinaComponente) VALUES
-- Registros Existentes (1-20)
(89, '2025-09-21 08:00:00', 1), (96, '2025-09-21 08:00:00', 2), (70, '2025-09-21 08:00:00', 3), (760, '2025-09-21 08:00:00', 4),
(91, '2025-09-21 08:05:00', 5), (80, '2025-09-21 08:05:00', 6), (99, '2025-09-21 08:05:00', 7), (650, '2025-09-21 08:05:00', 8),
(93, '2025-09-21 08:10:00', 9), (90, '2025-09-21 08:10:00', 10), (95, '2025-09-21 08:10:00', 11), (750, '2025-09-21 08:10:00', 12),
(90, '2025-09-21 08:15:00', 13), (96, '2025-09-21 08:15:00', 14), (95, '2025-09-21 08:15:00', 15), (710, '2025-09-21 08:15:00', 16),
(86, '2025-09-21 08:20:00', 17), (76, '2025-09-21 08:20:00', 18), (91, '2025-09-21 08:20:00', 19), (950, '2025-09-21 08:20:00', 20),

-- NOVOS REGISTROS (M6-M10)
(93, '2025-09-21 08:25:00', 21), (88, '2025-09-21 08:25:00', 22), (97, '2025-09-21 08:25:00', 23), (800, '2025-09-21 08:25:00', 24),
(92, '2025-09-21 08:30:00', 25), (96, '2025-09-21 08:30:00', 26), (99, '2025-09-21 08:30:00', 27), (700, '2025-09-21 08:30:00', 28),
(93, '2025-09-21 08:35:00', 29), (95, '2025-09-21 08:35:00', 30), (97, '2025-09-21 08:35:00', 31), (750, '2025-09-21 08:35:00', 32),
(90, '2025-09-21 08:40:00', 33), (81, '2025-09-21 08:40:00', 34), (86, '2025-09-21 08:40:00', 35), (790, '2025-09-21 08:40:00', 36),
(91, '2025-09-21 08:45:00', 37), (96, '2025-09-21 08:45:00', 38), (99, '2025-09-21 08:45:00', 39), (710, '2025-09-21 08:45:00', 40),

-- NOVOS REGISTROS (M11-M18)
(93, '2025-09-21 08:50:00', 41), (90, '2025-09-21 08:50:00', 42), (95, '2025-09-21 08:50:00', 43), (700, '2025-09-21 08:50:00', 44), -- M11
(91, '2025-09-21 08:55:00', 45), (96, '2025-09-21 08:55:00', 46), (99, '2025-09-21 08:55:00', 47), (710, '2025-09-21 08:55:00', 48), -- M12
(95, '2025-09-21 09:00:00', 49), (86, '2025-09-21 09:00:00', 50), (98, '2025-09-21 09:00:00', 51), (651, '2025-09-21 09:00:00', 52), -- M13
(92, '2025-09-21 09:05:00', 53), (95, '2025-09-21 09:05:00', 54), (97, '2025-09-21 09:05:00', 55), (750, '2025-09-21 09:05:00', 56), -- M14
(91, '2025-09-21 09:10:00', 57), (96, '2025-09-21 09:10:00', 58), (99, '2025-09-21 09:10:00', 59), (710, '2025-09-21 09:10:00', 60), -- M15
(93, '2025-09-21 09:15:00', 61), (90, '2025-09-21 09:15:00', 62), (95, '2025-09-21 09:15:00', 63), (750, '2025-09-21 09:15:00', 64), -- M16
(83, '2025-09-21 09:20:00', 65), (91, '2025-09-21 09:20:00', 66), (93, '2025-09-21 09:20:00', 67), (750, '2025-09-21 09:20:00', 68), -- M17
(91, '2025-09-21 09:25:00', 69), (96, '2025-09-21 09:25:00', 70), (99, '2025-09-21 09:25:00', 71), (710, '2025-09-21 09:25:00', 72); -- M18


-- INSERTS: Alerta (10 alertas adicionais, totalizando 31)
INSERT INTO Alerta (descricao, nivel, valorInicial, valorFinal, horarioInicio, horarioFinal, fkMaquinaComponente, fkMaquina) VALUES
-- M1-M10 (21 alertas existentes)
('CPU Acima do Limite Específico', 'Alto', 89, 89, '2025-09-21 08:00:00', NULL, 1, 1),
('RAM Acima do Limite Específico', 'Crítico', 96, 96, '2025-09-21 08:00:00', NULL, 2, 1),
('CPU Acima do Limite Padrão E5', 'Alto', 91, 91, '2025-09-21 08:05:00', NULL, 5, 2),
('Disco Acima do Limite Padrão E5', 'Médio', 99, 99, '2025-09-21 08:05:00', NULL, 7, 2),
('CPU Acima do Limite Oberon', 'Crítico', 93, 93, '2025-09-21 08:10:00', NULL, 9, 3),
('RAM Acima do Limite Oberon', 'Alto', 90, 90, '2025-09-21 08:10:00', NULL, 10, 3),
('Disco Acima do Limite Oberon', 'Médio', 95, 95, '2025-09-21 08:10:00', NULL, 11, 3),
('RAM Acima do Limite Padrão E5', 'Crítico', 96, 96, '2025-09-21 08:15:00', NULL, 14, 4),
('Rede Acima do Limite Padrão E5', 'Alto', 710, 710, '2025-09-21 08:15:00', NULL, 16, 4),
('CPU Acima do Limite Específico', 'Alto', 86, 86, '2025-09-21 08:20:00', NULL, 17, 5),
('RAM Acima do Limite Específico', 'Crítico', 76, 76, '2025-09-21 08:20:00', NULL, 18, 5),
('Disco Acima do Limite Específico', 'Médio', 91, 91, '2025-09-21 08:20:00', NULL, 19, 5),
('Rede Acima do Limite Específico', 'Crítico', 950, 950, '2025-09-21 08:20:00', NULL, 20, 5),
('CPU Acima do Limite Oberon', 'Crítico', 93, 93, '2025-09-21 08:25:00', NULL, 21, 6),
('CPU Acima do Limite Padrão E5', 'Alto', 92, 92, '2025-09-21 08:30:00', NULL, 25, 7),
('RAM Acima do Limite Padrão E5', 'Crítico', 96, 96, '2025-09-21 08:30:00', NULL, 26, 7),
('Disco Acima do Limite Padrão E5', 'Médio', 99, 99, '2025-09-21 08:30:00', NULL, 27, 7),
('CPU Acima do Limite Oberon', 'Crítico', 93, 93, '2025-09-21 08:35:00', NULL, 29, 8),
('RAM Acima do Limite Oberon', 'Alto', 95, 95, '2025-09-21 08:35:00', NULL, 30, 8),
('CPU Acima do Limite Específico', 'Alto', 90, 90, '2025-09-21 08:40:00', NULL, 33, 9),
('RAM Acima do Limite Específico', 'Crítico', 81, 81, '2025-09-21 08:40:00', NULL, 34, 9),
('CPU Acima do Limite Padrão E5', 'Alto', 91, 91, '2025-09-21 08:45:00', NULL, 37, 10),
('RAM Acima do Limite Padrão E5', 'Crítico', 96, 96, '2025-09-21 08:45:00', NULL, 38, 10),

-- NOVOS ALERTAS (M11-M18)
('CPU Acima do Limite Oberon', 'Crítico', 93, 93, '2025-09-21 08:50:00', NULL, 41, 11), -- M11
('RAM Acima do Limite Padrão E5', 'Crítico', 96, 96, '2025-09-21 08:55:00', NULL, 46, 12), -- M12
('Disco Acima do Limite Padrão E5', 'Médio', 99, 99, '2025-09-21 08:55:00', NULL, 47, 12), -- M12
('CPU Acima do Limite Específico', 'Crítico', 95, 95, '2025-09-21 09:00:00', NULL, 49, 13), -- M13
('Disco Acima do Limite Específico', 'Médio', 98, 98, '2025-09-21 09:00:00', NULL, 51, 13), -- M13
('Rede Abaixo do Limite Específico', 'Baixo', 651, 651, '2025-09-21 09:00:00', NULL, 52, 13), -- M13
('RAM Acima do Limite Oberon', 'Alto', 95, 95, '2025-09-21 09:05:00', NULL, 54, 14), -- M14
('RAM Acima do Limite Padrão E5', 'Crítico', 96, 96, '2025-09-21 09:10:00', NULL, 58, 15), -- M15
('CPU Acima do Limite Específico', 'Alto', 83, 83, '2025-09-21 09:20:00', NULL, 65, 17), -- M17
('RAM Acima do Limite Padrão E5', 'Crítico', 96, 96, '2025-09-21 09:25:00', NULL, 70, 18); -- M18

select * from Funcionario;

update Funcionario set senha = '$2b$10$XdCeJ6JyrZo1pJAlRRJ.e.HWBbXLrcxF9kJ87mYw4qszEjQ7Mgmy6' where idFuncionario > 0;