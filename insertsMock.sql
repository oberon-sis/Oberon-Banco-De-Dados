USE bdOberon;

-- ==========================
-- Inserts Mockados
-- ==========================

INSERT INTO empresa (razaoSocial, cnpj) VALUES
('TechVision Segurança', '12345678000199'),
('InovaCFTV Soluções', '98765432000155'),
('AlphaMonitor', '10101010101010'),
('BetaCFTV', '20202020202020'),
('GammaSeg', '30303030303030'),
('DeltaTech', '40404040404040');


INSERT INTO tipoUsuario(tipoUsuario, permissoes) VALUES
('Colaborador', 'editar_info;ver_paineis;ver_alertas;ver_suporte'),
('Administrador', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas'),
('Gestor', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas;gerir_empresa');

INSERT INTO funcionario (nome, cpf, email, fkEmpresa, fkTipoUsuario) VALUES
('Ana Souza', '12345678901', 'ana@techvision.com', 1, 1000),
('Carlos Lima', '98765432100', 'carlos@inovacftv.com', 2, 1001),
('Paula Mendes', '11111111111', 'paula@alphamonitor.com', 3, 1002),
('Ricardo Farias', '22222222222', 'ricardo@betacftv.com', 4, 1002),
('Juliana Pires', '33333333333', 'juliana@gammaseg.com', 5, 1001),
('Felipe Gomes', '44444444444', 'felipe@deltatech.com', 6, 1000);

INSERT INTO maquina (hostname, modelo, sistemaOperacional, statusAtivo, fkEmpresa) VALUES
('Servidor CFTV 01', 'Dell R720', 'Linux', 'Ativo', 1),
('Servidor CFTV 02', 'HP Proliant', 'Windows', 'Ativo', 2),
('Servidor CFTV 03', 'IBM X3550', 'Linux', 'Ativo', 3),
('Servidor CFTV 04', 'Dell R740', 'Linux', 'Inativo', 4),
('Servidor CFTV 05', 'HP DL380', 'Windows', 'Ativo', 5),
('Servidor CFTV 06', 'Lenovo SR650', 'Linux', 'Ativo', 6);


INSERT INTO componente (tipoComponente, unidadeMedida, funcaoMonitorar) VALUES
('CPU', '%', 'Uso de processamento'),
('RAM', 'MB', 'Consumo de memória'),
('Disco', 'GB', 'Espaço disponível'),
('Temperatura', '°C', 'Controle térmico'),
('GPU', '%', 'Uso de processamento gráfico'),
('PlacaRede', 'Mbps', 'Taxa de transmissão de dados');

INSERT INTO maquinaComponente (capacidadeGb, fkMaquina, fkComponente) VALUES
(100, 1, 1),   -- CPU Servidor 1
(16000, 1, 2), -- RAM Servidor 1
(500, 2, 3),   -- Disco Servidor 2
(85, 2, 4),    -- Temp Servidor 2
(90, 3, 5),    -- GPU Servidor 3
(1000, 3, 6);  -- PlacaRede Servidor 3


INSERT INTO parametro (limite, fkMaquinaComponente) VALUES
(85, 1),   -- CPU limite Servidor 1
(14000, 2),-- RAM limite Servidor 1
(450, 3),  -- Disco limite Servidor 2
(70, 4),   -- Temperatura limite Servidor 2
(95, 5),   -- GPU limite Servidor 3
(900, 6);  -- PlacaRede limite Servidor 3


INSERT INTO registro (valor, horario, fkMaquinaComponente) VALUES
(75, '2025-09-21 08:00:00', 1),
(12000, '2025-09-21 08:10:00', 2),
(400, '2025-09-21 08:20:00', 3),
(68, '2025-09-21 08:30:00', 4),
(92, '2025-09-21 08:40:00', 5),
(850, '2025-09-21 08:50:00', 6);

INSERT INTO alerta (descricao, nivel, valorInicial, valorFinal, horarioInicio, horarioFinal, fkMaquinaComponente, fkMaquina) VALUES
('CPU acima do limite', 'Crítico', 85, 95, '2025-09-21 09:00:00', '2025-09-21 09:15:00', 1, 1),
('RAM alta', 'Alto', 14000, 14500, '2025-09-21 09:10:00', '2025-09-21 09:30:00', 2, 1),
('Disco quase cheio', 'Alto', 450, 470, '2025-09-21 09:20:00', '2025-09-21 09:40:00', 3, 2),
('Temperatura elevada', 'Crítico', 70, 75, '2025-09-21 09:30:00', '2025-09-21 09:50:00', 4, 2),
('GPU sobrecarregada', 'Alto', 95, 100, '2025-09-21 09:40:00', '2025-09-21 10:00:00', 5, 3),
('Placa de Rede em pico', 'Médio', 900, 950, '2025-09-21 09:50:00', '2025-09-21 10:10:00', 6, 3);



