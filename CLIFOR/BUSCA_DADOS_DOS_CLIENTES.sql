/*---------------------------------------------------------------------------------------------------------------------------------------
| CONSULTA BASE â CLIENTES E PERFIS FINANCEIROS (TCA / AR)
|
| OBJETIVO:
|   Retornar informaÃ§Ãµes principais de clientes (pessoas jurÃ­dicas) cadastrados no Oracle,
|   incluindo dados da conta de cliente e perfil financeiro associados.
|
| CAMPOS PRINCIPAIS:
|   - PARTY_ID ................. Identificador Ãºnico da entidade (cliente) na tabela HZ_PARTIES
|   - PARTY_NAME ............... Nome do cliente (organizaÃ§Ã£o)
|   - PARTY_TYPE ............... Tipo da entidade (ORGANIZATION ou PERSON)
|   - ACCOUNT_NUMBER ........... NÃºmero da conta de cliente (HZ_CUST_ACCOUNTS)
|   - CUST_ACCOUNT_ID .......... Identificador da conta do cliente
|   - CUST_ACCOUNT_PROFILE_ID .. Identificador do perfil de crÃ©dito do cliente
|   - PROFILE_CLASS_ID ......... Classe de perfil associada (regras e polÃ­ticas financeiras)
|   - LAST_UPDATED_BY .......... UsuÃ¡rio responsÃ¡vel pela Ãºltima atualizaÃ§Ã£o
|   - LAST_UPDATE_DATE_LOCAL ... Data da Ãºltima atualizaÃ§Ã£o convertida para horÃ¡rio de SÃ£o Paulo
|   - CREATED_BY ............... UsuÃ¡rio que criou o registro
|   - CREATION_DATE ............ Data de criaÃ§Ã£o convertida para horÃ¡rio de SÃ£o Paulo
|
| FONTES DE DADOS:
|   - HZ_PARTIES ...................... ContÃ©m os dados mestres do cliente (nome, tipo, identificaÃ§Ã£o)
|   - HZ_CUST_ACCOUNTS ............... ContÃ©m as contas comerciais vinculadas ao cliente
|   - HZ_CUSTOMER_PROFILES_F ......... ContÃ©m os perfis financeiros e regras de crÃ©dito associadas Ã  conta
|
| FILTROS:
|   - Apenas clientes do tipo ORGANIZATION (empresas)
|
| OBSERVAÃÃES:
|   - Datas sÃ£o convertidas de UTC para o fuso horÃ¡rio 'America/Sao_Paulo'
|   - JOIN entre tabelas segue o modelo de relacionamento padrÃ£o do Oracle TCA (Trading Community Architecture)
----------------------------------------------------------------------------------------------------------------------------------------*/

SELECT
  hp.party_id,
  hp.party_name AS customer_name,
  hp.party_type,
  hca.account_number,
  hca.cust_account_id,
  hcpf.cust_account_profile_id,
  hcpf.profile_class_id,
  hcpf.LAST_UPDATED_BY,
  TO_CHAR(
    FROM_TZ(CAST(hcpf.LAST_UPDATE_DATE AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS LAST_UPDATE_DATE_LOCAL,
  hcpf.CREATED_BY,
  TO_CHAR(
    FROM_TZ(CAST(hcpf.CREATION_DATE AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS CREATION_DATE
FROM
  hz_parties hp
  JOIN hz_cust_accounts hca ON hp.party_id = hca.party_id
  LEFT JOIN hz_customer_profiles_f hcpf ON hca.cust_account_id = hcpf.cust_account_id
WHERE
  1 = 1
  and hp.party_type = 'ORGANIZATION'
--  and hcpf.LAST_UPDATED_BY like '%natan%'
ORDER BY
  hcpf.LAST_UPDATED_BY DESC
;


