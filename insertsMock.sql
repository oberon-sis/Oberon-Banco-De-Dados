USE upfinity;


-- INSERINDO ENDEREÇOS
INSERT INTO Endereco (cep, uf, cidade, logradouro, bairro, complemento, latitude, longitude, numero) VALUES
("01001-001", "SP", "São Paulo", "Rua Direita", "Sé", "Prédio A", "-23.5492", "-46.6346", 123),
("21040-360", "RJ", "Rio de Janeiro", "Rua da Praia", "Bonsucesso", "Loja 2", "-22.8687", "-43.2561", 45),
("30110-008", "MG", "Belo Horizonte", "Rua da Bahia", "Centro", "Sala 101", "-19.9208", "-43.9392", 789),
("70070-000", "DF", "Brasília", "Eixo Monumental", "Asa Sul", "Bloco B", "-15.7958", "-47.8824", 10),
("90030-001", "RS", "Porto Alegre", "Rua dos Andradas", "Centro Histórico", "Cobertura", "-30.0335", "-51.2291", 567);

-- INSERINDO EMPRESAS (2 empresas)
INSERT INTO Empresa (razaoSocial, cnpj) VALUES
("Tecno Soluções S.A.", "11223344000155"),
("Rede de ATMs Inteligentes Ltda.", "55667788000111");

-- INSERINDO TIPOS DE USUÁRIO
INSERT INTO TipoUsuario (tipo, permissoes) VALUES
("Admin", "CRUD_TOTAL"),
("Operador", "CRU_LIMITEDO"),
("Visualizador", "READ_ONLY");

-- INSERINDO USUÁRIOS (10 usuários)
INSERT INTO Usuario (fkEmpresa, fkTipoUsuario, nomeUsuario, email, senha, telefone) VALUES
(1, 1, "Ana Paula", "ana.paula@tecnosolucoes.com.br", "senha_ana", "11987654321"),
(1, 2, "Bruno Santos", "bruno.santos@tecnosolucoes.com.br", "senha_bruno", "11987654322"),
(1, 3, "Carla Lima", "carla.lima@tecnosolucoes.com.br", "senha_carla", "11987654323"),
(2, 1, "Daniel Costa", "daniel.costa@redeatms.com.br", "senha_daniel", "21912345678"),
(2, 2, "Elaine Pereira", "elaine.pereira@redeatms.com.br", "senha_elaine", "21912345679"),
(2, 2, "Fabio Mendes", "fabio.mendes@redeatms.com.br", "senha_fabio", "21912345680"),
(2, 3, "Gabriela Rocha", "gabriela.rocha@redeatms.com.br", "senha_gabriela", "21912345681"),
(1, 2, "Helena Alves", "helena.alves@tecnosolucoes.com.br", "senha_helena", "11987654324"),
(1, 3, "Ivan Dias", "ivan.dias@tecnosolucoes.com.br", "senha_ivan", "11987654325"),
(2, 2, "Julia Barros", "julia.barros@redeatms.com.br", "senha_julia", "21912345682");

-- INSERINDO ATMS (3 ATMs)
INSERT INTO Atm (fkEmpresa, fkEndereco, hostname, modelo, ip, macAddress, sistemaOperacional, statusAtm) VALUES
(1, 3, "atm-ts-01", "Model-A", "192.168.1.1", "00:1A:2B:3C:4D:5E", "Linux", "Ativo"),
(1, 4, "atm-ts-02", "Model-B", "192.168.1.2", "00:1A:2B:3C:4D:5F", "Windows", "Ativo"),
(2, 5, "atm-ra-01", "Model-C", "192.168.2.1", "A1:B2:C3:D4:E5:F6", "Linux", "Ativo");
-- INSERINDO COMPONENTES
INSERT INTO Componente (tipo, unidadeMedida, funcaoMonitorada) VALUES
("CPU", "%", "CPU_porcentagem"),
("Memória", "%", "RAM_percentual"),
("Disco", "%", "DISK_percentual"),
("CPU", "bits", "CPU_frequencia"),
("Memória", "GB", "RAM_disponivel");

-- INSERINDO ATMCOMPONENTES (relações entre ATMs e Componentes)
INSERT INTO AtmComponente (fkAtm, fkComponente, capacidade) VALUES
(1, 1, "3.8 GHz"), -- CPU para o ATM-1
(1, 2, "16 GB"),   -- Memória para o ATM-1
(1, 3, "512 GB"),  -- Disco para o ATM-1
(1, 4, "ASUS Z370"),-- Placa-mãe para o ATM-1
(2, 1, "3.2 GHz"), -- CPU para o ATM-2
(2, 2, "8 GB"),    -- Memória para o ATM-2
(2, 3, "256 GB"),  -- Disco para o ATM-2
(2, 5, "600W"),    -- Fonte para o ATM-2
(3, 1, "3.5 GHz"), -- CPU para o ATM-3
(3, 2, "16 GB");   -- Memória para o ATM-3

-- INSERINDO PARÂMETROS
INSERT INTO Parametro (fkAtmComponente, limite) VALUES
(1, "90"),  -- Limite de uso de CPU para o ATM-1
(2, "95"),  -- Limite de uso de RAM para o ATM-1
(3, "98"),  -- Limite de uso de Disco para o ATM-1
(4, "65"), -- Limite de temperatura da Placa-mãe para o ATM-1
(5, "85"),  -- Limite de uso de CPU para o ATM-2
(6, "90"),  -- Limite de uso de RAM para o ATM-2
(7, "95");  -- Limite de uso de Disco para o ATM-2