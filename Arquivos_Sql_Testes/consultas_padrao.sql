USE bdOberon;

-- ========================================================
-- CONSULTAS DE DIAGNÓSTICO (DEBUG & ESTRUTURA) 
-- Todos os dados que envolvam horario não é necessario fazer o insert ele está default configurado em horario brasilia
-- ========================================================

show tables;

-- Tabela: Empresa
-- Propósito: Informações do Cliente. Chave usada em Maquina e Funcionario.
SELECT * FROM Empresa;

-- Tabela: Funcionario
-- Propósito: Gerenciamento de Usuários. fkTipoUsuario define permissão (1000, 1001, etc.). fkCriadoPor/fkEditadoPor são cruciais para triggers.
SELECT * FROM Funcionario;

-- Tabela: TipoUsuario
-- Propósito: Tabela lookup para traduzir o fkTipoUsuario (para telas de permissão).
SELECT * FROM TipoUsuario;

-- Tabela: Maquina
-- Propósito: Ativo monitorado (onde o agente Python roda). O ID é a chave para todos os componentes.
SELECT * FROM Maquina;

-- Tabela: Componente
-- Propósito: Define o hardware (CPU, RAM, DISCO, etc.) em cada Maquina.
-- fkMaquina e fkTipoComponente definem a identidade do hardware.
SELECT * FROM Componente;

-- Tabela: TipoComponente
-- Propósito: Tabela lookup para identificar o tipo de componente (1=CPU, 2=RAM...).
SELECT * FROM TipoComponente;

-- Tabela: Parametro
-- Propósito: Limites e Alertas (CRITICO, ALERTA). Determina a regra aplicada.
-- Nota: fkEmpresa=1 (OBERON), fkEmpresa>1 (EMPRESA). fkComponente define regras ESPECIFICAS.
SELECT * FROM Parametro;

-- Tabela: Registro
-- Propósito: Dados brutos de telemetria (valor + timestamp). O fkComponente é a chave de ligação.
SELECT * FROM Registro;

-- Tabela: Alerta
-- Propósito: Logs de alertas disparados pelo backend (quando Registro > Parametro). fkRegistro é a ligação.
SELECT * FROM Alerta;

-- Tabela: LogAuditoria
-- Propósito: Rastreabilidade (quem/o quê/quando alterou). Tabela de debugging obrigatória para falhas em UPDATE/DELETE.
-- Nota: valorAntigo/valorNovo contém JSON para análise de diff.
SELECT * FROM LogAuditoria;

-- Tabela: TokenRecuperacao
-- Propósito: Usado na API de recuperação de senha. fkFuncionario + hashToken.
SELECT * FROM TokenRecuperacao;

-- Tabela: LogSistema
-- Propósito: Logs de sessões/processos internos do agente/serviço.
SELECT * FROM LogSistema;

-- Tabela: LogDetalheEvento
-- Propósito: Detalhes específicos dos eventos do LogSistema.
SELECT * FROM LogDetalheEvento;

-- Tabela: Incidente
-- Propósito: Registro de incidentes externos (ex: JIRA). fkIncidente é a chave.
SELECT * FROM Incidente;


-- ========================================================
-- CONSULTAS EM VIEWS (COMPLEXIDADE ABSTRAÍDA)
-- ========================================================
show tables;
-- VIEW: vw_dadosmaquina
-- Uso Dev: Ideal para carregar os dados completos de uma máquina no backend com uma única consulta.
SELECT * FROM vw_DadosMaquina;

-- VIEW: vw_parametroscomponentes
-- Uso Dev: Utilizada pelo agente/backend para buscar o limite de alerta aplicável a cada Componente, considerando a cascata (ESPECIFICO > EMPRESA > OBERON).
SELECT * FROM vw_ParametrosComponente;

-- VIEW: vw_historicoalertas
-- Uso Dev: Usada para exibir o histórico de alertas no frontend/relatórios.
SELECT * FROM vw_HistoricoAlertas;