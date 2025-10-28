FROM mysql:latest 

ENV MYSQL_ROOT_PASSWORD=urubu100 

COPY ./Arquivos_Sql_Servidor /docker-entrypoint-initdb.d/

EXPOSE 3306 