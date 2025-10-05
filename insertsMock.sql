use bdOberon;

INSERT INTO Empresa (razaoSocial, cnpj) VALUES
('TechVision Segurança', '12345678000199'), 
('InovaCFTV Soluções', '98765432000155'), 
('AlphaMonitor', '10101010101010'),
('BetaCFTV', '20202020202020'),
('GammaSeg', '30303030303030'),
('DeltaTech', '40404040404040');


INSERT INTO TipoUsuario(tipoUsuario, permissoes) VALUES
('Colaborador', 'editar_info;ver_paineis;ver_alertas;ver_suporte'),
('Administrador', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas'),
('Gestor', 'editar_info;ver_paineis;ver_alertas;ver_suporte;gerir_usuarios;gerir_maquinas;gerir_empresa');

INSERT INTO Funcionario (nome, cpf, email,senha, fkEmpresa, fkTipoUsuario) VALUES
('Dandara Ramos', '12345678901', 'dandarar576@gmail.com','urubu100', 1, 1000),
('Carlos Lima', '98765432100', 'carlos@inovacftv.com','urubu100', 2, 1001),
('Paula Mendes', '11111111111', 'paula@alphamonitor.com','urubu100', 3, 1002),
('Ricardo Farias', '22222222222', 'ricardo@betacftv.com','urubu100', 4, 1002),
('Juliana Pires', '33333333333', 'juliana@gammaseg.com','urubu100', 5, 1001),
('Felipe Gomes', '44444444444', 'felipe@deltatech.com','urubu100', 6, 1000);

INSERT INTO Maquina (nome, hostname, modelo, macAddress, ip, sistemaOperacional, status, fkEmpresa) VALUES
('Servidor R720', 'Desktop 01', 'Dell R720', '8F:67:95:05:84:50', '192.168.1.101', 'Linux', 'Ativo', 1), 
('Servidor Proliant', 'Desktop 02', 'HP Proliant', 'A1:B2:C3:D4:E5:F6', '192.168.1.102', 'Windows', 'Ativo', 2), 
('Máquina de Teste', 'Test-PC-03', 'IBM X3550', 'F6:E5:D4:C3:B2:A1', '10.0.0.103', 'Linux', 'Ativo', 3), 
('Computador Principal', 'Main-PC-04', 'Dell R740', '11:22:33:44:55:66', '10.0.0.104', 'Linux', 'Inativo', 4),
('Estação de Trabalho 03', 'Desktop 05', 'HP DL380', 'AA:BB:CC:DD:EE:FF', '192.168.5.201', 'Windows', 'Ativo', 5),
('Máquina Central', 'Central-PC-06', 'Lenovo SR650', '0A:1B:2C:3D:4E:5F', '172.16.0.10', 'Linux', 'Ativo', 6);


INSERT INTO Componente (tipoComponente, unidadeMedida, funcaoMonitorar) VALUES
('CPU', '%', 'cpu porcentagem'), 
('RAM', '%', 'ram porcentagem'),   
('Disco Duro', '%', 'disco porcentagem'), 
('PlacaRede', 'Mbps', 'rede taxa'), 
('GPU', '%', 'Uso de processamento gráfico');

INSERT INTO MaquinaComponente (nucleosThreads, capacidadeGb, tipoDisco, fkMaquina, fkComponente) VALUES
(8, NULL, NULL, 1, 1), 
(NULL, 16, NULL, 1, 2),
(NULL, 500, 'SSD', 1, 3),
(NULL, NULL, NULL, 1, 4),

(12, NULL, NULL, 2, 1), 
(NULL, 32, NULL, 2, 2), 
(NULL, 1000, 'HDD', 2, 3), 
(NULL, NULL, NULL, 2, 4), 

(4, NULL, NULL, 3, 1), 
(NULL, 8, NULL, 3, 2), 
(NULL, 250, 'SSD', 3, 3), 
(NULL, NULL, NULL, 3, 4); 


INSERT INTO Parametro (limite, fkEmpresa, fkMaquinaComponente) VALUES
-- 1. QUATRO PARÂMETROS ESPECÍFICOS para a Máquina 1 (idMC=1 a 4)
(88, NULL, 1), 
(95, NULL, 2), 
(80, NULL, 3), 
(750, NULL, 4), 

-- 2. QUATRO PARÂMETROS PADRÃO GLOBAL
(90, 1, NULL), 
(75, 2, NULL), 
(92, 3, NULL), 
(60, 4, NULL); 


INSERT INTO Registro (valor, horario, fkMaquinaComponente) VALUES
(88, '2025-09-21 08:00:00', 1),
(92, '2025-09-21 08:10:00', 2),
(70, '2025-09-21 08:20:00', 3),
(68, '2025-09-21 08:30:00', 4),
(92, '2025-09-21 08:40:00', 5),
(85, '2025-09-21 08:50:00', 6),
(82, '2025-09-21 09:00:00', 7),
(850, '2025-09-21 09:10:00', 8);


INSERT INTO Alerta (descricao, nivel, valorInicial, valorFinal, horarioInicio, horarioFinal, fkMaquinaComponente, fkMaquina) VALUES
('CPU acima do limite padrão', 'Alto', 90, 95, '2025-09-21 09:00:00', NULL, 1, 1),
('RAM acima do limite específico', 'Crítico', 95, 100, '2025-09-21 09:10:00', NULL, 2, 1),
('Disco acima do limite padrão', 'Médio', 90, 95, '2025-09-21 09:20:00', NULL, 3, 1),
('Disco acima do limite específico', 'Crítico', 80, 85, '2025-09-21 09:30:00', NULL, 7, 2);