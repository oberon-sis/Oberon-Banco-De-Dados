#!/bin/bash
echo ''
echo '----Script de criação do banco de dados da OBERON----'
echo ''

STRUCTURE=""
INSERTS=""
USERS=""

echo ''
echo 'Informe as credenciais para criação do ambiente'
read -p "Informe o usuario: " USER
read -s -p "Senha: " PASSWD
echo ''
echo ''

echo ''
read -p 'Criar estrutura do banco (01_CriacaoDoBanco.sql e 02_CriacaoDeViews.sql)? (S/N)' RESPOSTA 
if [ "$RESPOSTA" = 'S' ] || [ "$RESPOSTA" = 's' ]; then
    STRUCTURE=$(cat 01_CriacaoDoBanco.sql; echo; cat 02_CriacaoDeViews.sql)
    echo 'Adicionando estrutura do banco ...'
else 
    echo 'Criação da estrutura do banco cancelada'
fi
echo ''

echo ''
read -p 'Executar inserts de dados (06_InsercaoMocada.sql)? (S/N)' RESPOSTA 
if [ "$RESPOSTA" = 'S' ] || [ "$RESPOSTA" = 's' ]; then
    INSERTS="${INSERTS}$(cat 06_InsercaoMocada.sql)\n"
    echo 'Adicionando 06_InsercaoMocada.sql ...'
else 
    echo 'Execução de Inserção de Dados cancelada'
fi
echo ''

echo ''
read -p 'Executar triggers de auditoria (03, 04, 05)? (S/N)' RESPOSTA 
if [ "$RESPOSTA" = 'S' ] || [ "$RESPOSTA" = 's' ]; then
    TRIGGERS_SQL=$(cat 03_TriggersUPDATE.sql; echo; cat 04_TriggersINSERT.sql; echo; cat 05_TriggersDELETE.sql)
    INSERTS="${INSERTS}${TRIGGERS_SQL}\n"
    echo 'Adicionando scripts de Triggers ...'
else 
    echo 'Execução dos Triggers cancelada'
fi
echo ''

echo ''
read -p 'Configurar usuarios (07_ConfiguracaoUsuarios.sql)? (S/N)' RESPOSTA 
if [ "$RESPOSTA" = 'S' ] || [ "$RESPOSTA" = 's' ]; then
    USERS=$(cat 07_ConfiguracaoUsuarios.sql)
    echo 'Adicionando 07_ConfiguracaoUsuarios.sql ...'
else 
    echo 'Configuração de usuários cancelada'
fi
echo ''

mysql -u"$USER" -p"$PASSWD" <<EOF

$STRUCTURE

$INSERTS

$USERS

EOF

if [ $? -eq 0 ]; then
    echo "Execução do script SQL concluída com sucesso!"
else
    echo "Erro durante a execução do script SQL. Verifique as mensagens acima."
fi