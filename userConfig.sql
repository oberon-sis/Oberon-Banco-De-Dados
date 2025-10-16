DROP USER IF EXISTS oberon_select;
CREATE USER 'oberon_select'@'%' IDENTIFIED BY 'Urubu100$';
GRANT SELECT ON db.* TO 'oberon_select'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS oberon_insert;
CREATE USER 'oberon_insert'@'%' IDENTIFIED BY 'Urubu100$';
GRANT INSERT ON bdOberon.* TO 'oberon_insert'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS servidorOberon;
CREATE USER 'oberon_servidor'@'%' IDENTIFIED BY 'Urubu100';
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