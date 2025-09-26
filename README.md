# Monitoramento ATM Banco de Dados

Este repositório contém o esquema do banco de dados utilizado no projeto **Upfinity**, um sistema de monitoramento de componentes de hardwere de ATMs. 

## 📋 Status do Projeto

✅ Em desenvolvimento 

## 🚀 Funcionalidades

- Modelagem de dados para hardware, software, alertas e usuários
- Scripts de inserção inicial de dados
- Otimização de queries para grandes volumes de dados
- Script de criação de banco de dados.
- Script de criação de views

## 📂 Estrutura do Banco  

- **Tabelas principais**:
  - `maquina`: Registra as máquinas de CFTV monitoradas, incluindo informações sobre o status, modelo e sistema operacional.
  - `componente`: Define os tipos de componentes de hardware (CPU, RAM, Disco, etc.) a serem monitorados nas máquinas.
  - `maquinaComponente`: Relaciona as máquinas aos seus componentes específicos, detalhando características como capacidade e núcleos.
  - `alerta`: Registra os alertas gerados quando um parâmetro ultrapassa os limites definidos, indicando falhas ou anomalias.


## 🚀 Tecnologias  

-   **Banco de dados**: MySQL 
<img
    align="center"
    alt="SQL"
    title="SQL"
    width="40px"
    style="padding-rigth: 10px;"
    src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/azuresqldatabase/azuresqldatabase-original.svg"
/> 

## 📌 Como usar  
1. Clone este repositório  
2. Execute o script de configuração do usuário `\dbStructure.sql`
3. Execute o script de configuração do usuário `\userConfig.sql`

## 📖 Documentação
Mais detalhes sobre os requisitos de banco de dados e integração estão descritos na [documentação principal]() disponivél nas pasta do one drive.

`Nota: Este repositório é privado e contém informações sensíveis de configuração de banco de dados.`