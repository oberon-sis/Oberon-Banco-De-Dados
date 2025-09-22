USE bdOberon;

-- ==========================
-- Inserts Mocados
-- ==========================

INSERT INTO Empresa (RazaoSocial, Cnpj) VALUES
('TechVision Segurança', '12345678000199'),
('InovaCFTV Soluções', '98765432000155'),
('AlphaMonitor', '10101010101010'),
('BetaCFTV', '20202020202020'),
('GammaSeg', '30303030303030'),
('DeltaTech', '40404040404040');

INSERT INTO Funcionario (Nome, Cpf, Email, FkEmpresa) VALUES
('Ana Souza', '12345678901', 'ana@techvision.com', 1),
('Carlos Lima', '98765432100', 'carlos@inovacftv.com', 2),
('Paula Mendes', '11111111111', 'paula@alphamonitor.com', 3),
('Ricardo Farias', '22222222222', 'ricardo@betacftv.com', 4),
('Juliana Pires', '33333333333', 'juliana@gammaseg.com', 5),
('Felipe Gomes', '44444444444', 'felipe@deltatech.com', 6);

INSERT INTO NivelAcesso (TipoAcesso, Permissoes, FkFuncionario) VALUES
('Administrador', 'Gerenciar todas as máquinas e usuários', 1),
('Operador', 'Monitorar registros e alertas', 2),
('Supervisor', 'Supervisionar operadores', 3),
('Técnico', 'Manutenção e configuração', 4),
('Auditor', 'Consultar logs e alertas', 5),
('Analista', 'Analisar métricas e desempenho', 6);

INSERT INTO Maquina (Nome, EnderecoIp, FkEmpresa) VALUES
('Servidor CFTV 01', '192.168.0.10', 1),
('Servidor CFTV 02', '192.168.0.11', 2),
('Servidor CFTV 03', '192.168.0.12', 3),
('Servidor CFTV 04', '192.168.0.13', 4),
('Servidor CFTV 05', '192.168.0.14', 5),
('Servidor CFTV 06', '192.168.0.15', 6);

INSERT INTO Componente (TipoComponente, UnidadeMedida, FuncaoMonitorar) VALUES
('CPU', '%', 'Uso de processamento'),
('RAM', 'MB', 'Consumo de memória'),
('Disco', 'GB', 'Espaço disponível'),
('Temperatura', '°C', 'Controle térmico'),
('GPU', '%', 'Uso de processamento gráfico'),
('PlacaRede', 'Mbps', 'Taxa de transmissão de dados');

INSERT INTO MaquinaComponente (Capacidade, FkMaquina, FkComponente) VALUES
(100, 1, 1),   -- CPU Servidor 1
(16000, 1, 2), -- RAM Servidor 1
(500, 2, 3),   -- Disco Servidor 2
(85, 2, 4),    -- Temp Servidor 2
(90, 3, 5),    -- GPU Servidor 3
(1000, 3, 6);  -- PlacaRede Servidor 3

INSERT INTO Parametro (FkMaquinaComponente, Limite) VALUES
(1, 85),   -- CPU limite Servidor 1
(2, 14000),-- RAM limite Servidor 1
(3, 450),  -- Disco limite Servidor 2
(4, 70),   -- Temperatura limite Servidor 2
(5, 95),   -- GPU limite Servidor 3
(6, 900);  -- PlacaRede limite Servidor 3

INSERT INTO Registro (Valor, Horario, FkMaquinaComponente) VALUES
(75, '2025-09-21 08:00:00', 1),
(12000, '2025-09-21 08:10:00', 2),
(400, '2025-09-21 08:20:00', 3),
(68, '2025-09-21 08:30:00', 4),
(92, '2025-09-21 08:40:00', 5),
(850, '2025-09-21 08:50:00', 6);

INSERT INTO Alerta (Descricao, Nivel, ValorInicial, ValorFinal, HorarioInicio, HorarioFinal, FkMaquinaComponente) VALUES
('CPU acima do limite', 'Crítico', 85, 95, '2025-09-21 09:00:00', '2025-09-21 09:15:00', 1),
('RAM alta', 'Alto', 14000, 14500, '2025-09-21 09:10:00', '2025-09-21 09:30:00', 2),
('Disco quase cheio', 'Alto', 450, 470, '2025-09-21 09:20:00', '2025-09-21 09:40:00', 3),
('Temperatura elevada', 'Crítico', 70, 75, '2025-09-21 09:30:00', '2025-09-21 09:50:00', 4),
('GPU sobrecarregada', 'Alto', 95, 100, '2025-09-21 09:40:00', '2025-09-21 10:00:00', 5),
('Placa de Rede em pico', 'Médio', 900, 950, '2025-09-21 09:50:00', '2025-09-21 10:10:00', 6);
 'Alto', 70, 72, '2025-09-21 08:00:00', '2025-09-21 08:30:00', 4);

