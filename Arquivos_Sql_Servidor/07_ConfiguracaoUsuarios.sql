DROP USER IF EXISTS oberon_select;
CREATE USER 'oberon_select'@'%' IDENTIFIED BY 'Urubu100$';
GRANT SELECT ON db.* TO 'oberon_select'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS oberon_insert;
CREATE USER 'oberon_insert'@'%' IDENTIFIED BY 'Urubu100$';
GRANT INSERT ON bdOberon.* TO 'oberon_insert'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS servidorOberon;
CREATE USER 'servidorOberon'@'%' IDENTIFIED BY 'Urubu100';
GRANT SELECT, INSERT, UPDATE, DELETE ON bdOberon.* TO 'servidorOberon'@'%';

FLUSH PRIVILEGES;

DROP USER IF EXISTS oberon_cliente;
CREATE USER 'oberon_cliente'@'%' IDENTIFIED BY 'ClienteOberon123';
GRANT SELECT, INSERT, UPDATE ON bdOberon.* TO 'oberon_cliente'@'%';

FLUSH PRIVILEGES;

DROP USER IF EXISTS oberon_admin;
CREATE USER 'oberon_admin'@'%' IDENTIFIED BY 'Urubu100$';
GRANT ALL PRIVILEGES ON bdOberon.* TO 'oberon_admin'@'%';
FLUSH PRIVILEGES;


DROP USER IF EXISTS jhoel_oberon;
CREATE USER 'jhoel_oberon'@'%' IDENTIFIED BY 'Urubu100$';
GRANT ALL PRIVILEGES ON bdOberon.* TO 'jhoel_oberon'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS dandara_oberon;
CREATE USER 'dandara_oberon'@'%' IDENTIFIED BY 'Urubu100$';
GRANT ALL PRIVILEGES ON bdOberon.* TO 'dandara_oberon'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS miguel_oberon;
CREATE USER 'miguel_oberon'@'%' IDENTIFIED BY 'Urubu100$';
GRANT ALL PRIVILEGES ON bdOberon.* TO 'miguel_oberon'@'%';
FLUSH PRIVILEGES;



DROP USER IF EXISTS bruna_oberon;
CREATE USER 'bruna_oberon'@'%' IDENTIFIED BY 'Urubu100$';
GRANT ALL PRIVILEGES ON bdOberon.* TO 'bruna_oberon'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS pedro_oberon;
CREATE USER 'pedro_oberon'@'%' IDENTIFIED BY 'Urubu100$';
GRANT ALL PRIVILEGES ON bdOberon.* TO 'pedro_oberon'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS nathan_oberon;
CREATE USER 'nathan_oberon'@'%' IDENTIFIED BY 'Urubu100$';
GRANT ALL PRIVILEGES ON bdOberon.* TO 'jhoel_oberon'@'%';
FLUSH PRIVILEGES;

/*USUARIO PARA OS AGENTES DE MONIOTAMENTO*/

-- PASSO 1: CRIAR O NOVO USUÁRIO
-- Permite que o usuário se conecte a partir de QUALQUER host ('%')
CREATE USER 'oberon_agente_monitoramento'@'%' 
IDENTIFIED BY 'oberon_agente_monitoramento_2025';

-- PASSO 2: CONCEDER PERMISSÕES DE INSERÇÃO (INSERT)
-- Tabelas: Alerta, Incidente, LogDetalheEvento, LogSistema, Registro
GRANT INSERT ON bdOberon.Alerta TO 'oberon_agente_monitoramento'@'%';
GRANT INSERT ON bdOberon.Incidente TO 'oberon_agente_monitoramento'@'%';
GRANT INSERT ON bdOberon.LogDetalheEvento TO 'oberon_agente_monitoramento'@'%';
GRANT INSERT ON bdOberon.LogSistema TO 'oberon_agente_monitoramento'@'%';
GRANT INSERT ON bdOberon.Registro TO 'oberon_agente_monitoramento'@'%';


-- PASSO 3: CONCEDER PERMISSÕES DE ATUALIZAÇÃO (UPDATE)
-- Tabelas: Componente, LogSistema, Maquina
GRANT UPDATE ON bdOberon.Componente TO 'oberon_agente_monitoramento'@'%';
GRANT UPDATE ON bdOberon.LogSistema TO 'oberon_agente_monitoramento'@'%';
GRANT UPDATE ON bdOberon.Maquina TO 'oberon_agente_monitoramento'@'%';


-- PASSO 4: CONCEDER PERMISSÕES DE LEITURA (SELECT)
-- Tabelas/Views: LogSistema, vw_DadosMaquina, vwParametrosComponente
GRANT SELECT ON bdOberon.LogSistema TO 'oberon_agente_monitoramento'@'%';
GRANT SELECT ON bdOberon.vw_DadosMaquina TO 'oberon_agente_monitoramento'@'%';
GRANT SELECT ON bdOberon.vw_ParametrosComponente TO 'oberon_agente_monitoramento'@'%';
GRANT SELECT ON bdOberon.Maquina TO 'oberon_agente_monitoramento'@'%';
GRANT SELECT ON bdOberon.vw_componentesparaatualizar TO 'oberon_agente_monitoramento'@'%';
GRANT SELECT ON bdOberon.Componente TO 'oberon_agente_monitoramento'@'%';


-- PASSO 5: APLICAR AS MUDANÇAS
FLUSH PRIVILEGES;

