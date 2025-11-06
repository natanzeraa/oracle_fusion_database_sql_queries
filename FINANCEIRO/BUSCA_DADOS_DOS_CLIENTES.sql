/*---------------------------------------------------------------------------------------------------------------------------------------
| CONSULTA BASE — CLIENTES E PERFIS FINANCEIROS (TCA / AR)
|
| OBJETIVO:
|   Retornar informações principais de clientes (pessoas jurídicas) cadastrados no Oracle,
|   incluindo dados da conta de cliente e perfil financeiro associados.
|
| CAMPOS PRINCIPAIS:
|   - PARTY_ID ................. Identificador único da entidade (cliente) na tabela HZ_PARTIES
|   - PARTY_NAME ............... Nome do cliente (organização)
|   - PARTY_TYPE ............... Tipo da entidade (ORGANIZATION ou PERSON)
|   - ACCOUNT_NUMBER ........... Número da conta de cliente (HZ_CUST_ACCOUNTS)
|   - CUST_ACCOUNT_ID .......... Identificador da conta do cliente
|   - CUST_ACCOUNT_PROFILE_ID .. Identificador do perfil de crédito do cliente
|   - PROFILE_CLASS_ID ......... Classe de perfil associada (regras e políticas financeiras)
|   - LAST_UPDATED_BY .......... Usuário responsável pela última atualização
|   - LAST_UPDATE_DATE_LOCAL ... Data da última atualização convertida para horário de São Paulo
|   - CREATED_BY ............... Usuário que criou o registro
|   - CREATION_DATE ............ Data de criação convertida para horário de São Paulo
|
| FONTES DE DADOS:
|   - HZ_PARTIES ...................... Contém os dados mestres do cliente (nome, tipo, identificação)
|   - HZ_CUST_ACCOUNTS ............... Contém as contas comerciais vinculadas ao cliente
|   - HZ_CUSTOMER_PROFILES_F ......... Contém os perfis financeiros e regras de crédito associadas à conta
|
| FILTROS:
|   - Apenas clientes do tipo ORGANIZATION (empresas)
|
| OBSERVAÇÕES:
|   - Datas são convertidas de UTC para o fuso horário 'America/Sao_Paulo'
|   - JOIN entre tabelas segue o modelo de relacionamento padrão do Oracle TCA (Trading Community Architecture)
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
  hp.party_type = 'ORGANIZATION'
ORDER BY
  hcpf.LAST_UPDATED_BY
;

