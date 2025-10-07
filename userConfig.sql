DROP USER IF EXISTS oberon_select;
CREATE USER 'oberon_select'@'%' IDENTIFIED BY 'Urubu100$';
GRANT SELECT ON db.* TO 'oberon_select'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS oberon_insert;
CREATE USER 'oberon_insert'@'%' IDENTIFIED BY 'Urubu100$';
GRANT INSERT ON bdOberon.* TO 'oberon_insert'@'%';
FLUSH PRIVILEGES;

DROP USER IF EXISTS oberon_servidor;
CREATE USER 'oberon_servidor'@'%' IDENTIFIED BY 'Urubu100$';
GRANT SELECT, INSERT, UPDATE, DELETE ON bdOberon.* TO 'oberon_servidor'@'%';

FLUSH PRIVILEGES;

DROP USER IF EXISTS oberon_cliente;
CREATE USER 'oberon_cliente'@'%' IDENTIFIED BY 'Urubu100$';
GRANT SELECT, INSERT, UPDATE ON bdOberon.* TO 'oberon_cliente'@'%';

FLUSH PRIVILEGES;

DROP USER IF EXISTS oberon_admin;
CREATE USER 'oberon_admin'@'%' IDENTIFIED BY 'Urubu100$';
GRANT ALL PRIVILEGES ON bdOberon.* TO 'oberon_admin'@'%';
FLUSH PRIVILEGES;


DROP USER IF EXISTS oberon_dev;
CREATE USER 'oberon_dev'@'%' IDENTIFIED BY 'Urubu100$';
GRANT SELECT, INSERT, UPDATE, DELETE ON bdOberon.* TO 'oberon_dev'@'%';
FLUSH PRIVILEGES;