SELECT
  hp.party_id,
  hp.party_name AS NOME_CLIENTE,
  hp.party_number AS CODIGO_CLIENTE,
  NVL(flv_tl.meaning, hp.party_type) AS TIPO_CLIENTE_PT,
  NVL(ft_tl.territory_short_name, hp.country) AS PAIS_PT,
  hca.account_number AS CONTA_CLIENTE,
  hca.orig_system_reference AS SISTEMA_ORIGEM,
  CASE
    WHEN hca.orig_system_reference IS NOT NULL THEN 'Importado'
    WHEN hca.job_definition_name IS NOT NULL THEN 'Batch/Import'
    ELSE 'Manual'
  END AS ORIGEM_REGISTRO,
  hcpf.created_by AS CRIADO_POR,
  TO_CHAR(
    FROM_TZ(CAST(hcpf.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS DATA_CRIACAO,
  hcpf.last_updated_by AS ATUALIZADO_POR,
  TO_CHAR(
    FROM_TZ(CAST(hcpf.last_update_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS DATA_ATUALIZACAO,
  COUNT(*) OVER() AS TOTAL
FROM
  hz_parties hp
  JOIN hz_cust_accounts hca ON hp.party_id = hca.party_id
  LEFT JOIN hz_customer_profiles_f hcpf ON hca.cust_account_id = hcpf.cust_account_id
  LEFT JOIN fnd_lookup_values_tl flv_tl ON flv_tl.lookup_type = 'PARTY_TYPE'
  AND flv_tl.lookup_code = hp.party_type
  AND flv_tl.language = 'PTB'
  LEFT JOIN fnd_territories_tl ft_tl ON ft_tl.territory_code = hp.country
  AND ft_tl.language = 'PTB'
WHERE
  TRUNC(
    FROM_TZ(CAST(hcpf.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo'
  ) BETWEEN TO_DATE('01/11/2025', 'DD/MM/YYYY')
  AND TO_DATE('12/11/2025', 'DD/MM/YYYY')
ORDER BY
  hcpf.creation_date DESC
