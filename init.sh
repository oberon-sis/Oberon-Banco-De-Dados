#!/bin/bash
echo ''
echo '----Script de criação do banco de dados da UPFINITY----'
echo ''

echo ''
echo 'Informe as credenciais para criação do ambiente'
read -p "Informe o usuario: " USER
read -s -p "Senha: " PASSWD
echo ''
echo ''

echo ''
read -p 'Criar estrutura do script dbStrucure.sql? (S/N)' RESPOSTA 
if [ $RESPOSTA = 'S' ]; then STRUCTURE=$(cat dbStructure.sql); echo 'Criando dbStructure.sql ...'
else echo 'Criação de dbStructure.sql cancelada'
fi
echo ''

echo ''
read -p 'Executar inserts de insertsMock.sql? (S/N)' RESPOSTA 
if [ $RESPOSTA = 'S' ]; then INSERTS=$(cat insertsMock.sql); echo 'Criando insertsMock.sql ...'
else echo 'Execução de insertsMock.sql cancelada'
fi
echo ''

echo ''
read -p 'Configurar usuarios de userConfig? (S/N)' RESPOSTA 
if [ $RESPOSTA = 'S' ]; then USERS=$(cat userConfig.sql); echo 'Criando userConfig.sql ...'
else echo 'Criação de userConfig.sql cancelada'
fi
echo ''


mysql -u"$USER" -p"$PASSWD" <<EOF

$STRUCTURE
$INSERTS
$USERS

EOF
