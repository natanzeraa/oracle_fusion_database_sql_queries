SELECT
  COUNT(*) OVER() AS TOTAL,
  -- Dados do Cliente
  hp.party_id,
  hp.party_name AS NOME_CLIENTE,
  hp.party_number AS CODIGO_CLIENTE,
  NVL(flv_tl.meaning, hp.party_type) AS TIPO_CLIENTE_PT,
  NVL(ft_tl.territory_short_name, hp.country) AS PAIS_PT,
  -- Conta do Cliente
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
  ----------------------------------------------------------------------
  -- ENDEREÇOS (PARTY SITES / LOCATION / USE)
  ----------------------------------------------------------------------
  hps.party_site_id AS ID_ENDERECO,
  hps.party_site_number AS COD_ENDERECO,
  hps.party_site_name AS NOME_ENDERECO,
  -- LOCATION
  hl.location_id AS LOCATION_ID,
  hl.address1,
  hl.address2,
  hl.address3,
  hl.address4,
  hl.city AS CIDADE,
  hl.state AS ESTADO,
  hl.postal_code AS CEP,
  hl.province AS PROVINCIA,
  hl.country AS PAIS_LOCATION,
  -- USE TYPE (BILL_TO / SHIP_TO / LEGAL / PRIMARY)
  hpsu.site_use_type AS TIPO_USO,
  TO_CHAR(
    FROM_TZ(CAST(hps.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS DATA_CRIACAO_ENDERECO,
  TO_CHAR(
    FROM_TZ(CAST(hps.last_update_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS DATA_ATUALIZACAO_ENDERECO
FROM
  hz_parties hp
  JOIN hz_cust_accounts hca ON hp.party_id = hca.party_id
  LEFT JOIN hz_customer_profiles_f hcpf ON hca.cust_account_id = hcpf.cust_account_id ----------------------------------------------------------------------
  -- JOIN DOS ENDEREÇOS
  ----------------------------------------------------------------------
  LEFT JOIN hz_party_sites hps ON hps.party_id = hp.party_id
  LEFT JOIN hz_locations hl ON hl.location_id = hps.location_id
  LEFT JOIN hz_party_site_uses hpsu ON hps.party_site_id = hpsu.party_site_id ----------------------------------------------------------------------
  -- TRADUÇÕES
  ----------------------------------------------------------------------
  LEFT JOIN fnd_lookup_values_tl flv_tl ON flv_tl.lookup_type = 'PARTY_TYPE'
  AND flv_tl.lookup_code = hp.party_type
  AND flv_tl.language = 'PTB'
  LEFT JOIN fnd_territories_tl ft_tl ON ft_tl.territory_code = hp.country
  AND ft_tl.language = 'PTB'
WHERE
  1 = 1
  -- AND hp.party_number LIKE '%03868183%' -- << seu filtro
  -- AND hpsu.site_use_type = 'BILL_TO'
  -- AND hp.party_name = 'MAXICON'
  -- AND hcpf.created_by = 'franciele.rossetto@plumaagro.com.br'
  AND hca.account_number   in (
    '08733109-2',
    '03142670-2',
    '08733109-1',
    '03142670-1',
    '17952934-1',
    '04146300-2',
    '17952934-2',
    '83310441-2',
    '83310441-1',
    '89982268-2',
    '11252642-2',
    '07954091-2',
    '07954091-1',
    '89982268-1',
    '04146300-1',
    '11252642-1',
    '54905897-2',
    '05545381-2',
    '65881346149-2',
    '21213500630-1',
    '17238347-1',
    '81743528-2',
    '00106409-1',
    '07277875-1',
    '00781758-1',
    '00281818-2',
    '01682695-1',
    '00109066-1',
    '65881346149-1',
    '82022021-2',
    '03868183-2',
    '80696479-1',
    '37005308972-2',
    '07177888-2',
    '94305091-2',
    '66260140134-2',
    '52070464-2',
    '44964190-2',
    '08050599-1',
    '29467080-1',
    '02525961-2',
    '11252642-2',
    '94305091-1',
    '25111957987-1',
    '05545381-1',
    '92185008-2',
    '81743528-1',
    '89982268-2',
    '21278160-2',
    '03620220-2',
    '00356217884-2',
    '00356217884-1',
    '92185008-1',
    '30476181-2',
    '04146300-1',
    '08035135-2',
    '83310441-2',
    '80696479-2',
    '07177888-1',
    '66260140134-1',
    '61024295-1',
    '52447154968-1',
    '12513903-2',
    '00281818-1',
    '35759402153-2',
    '08869805-2',
    '03150691-1',
    '00109066-2',
    '89982268-1',
    '08869805-1',
    '07277875-2',
    '02525961-1',
    '27093558-1',
    '34661049-1',
    '30476181-1',
    '07954091-1',
    '83310441-1',
    '04228079660-1',
    '44964190-1',
    '00781758-2',
    '34661049-2',
    '01682695-2',
    '03598161-1',
    '17238347-2',
    '03620220-1',
    '37005308972-1',
    '25111957987-2',
    '35828090-1',
    '03868183-1',
    '65635442820-2',
    '04228079660-2',
    '12513903-1',
    '27275197-2',
    '52070464-1',
    '10476046-1',
    '61024295-2',
    '52447154968-2',
    '17952934-2',
    '17952934-1',
    '11252642-1',
    '05645983807-1',
    '04883352-2',
    '21278160-1',
    '35759402153-1',
    '08050599-2',
    '27093558-2',
    '65635442820-1',
    '10476046-2',
    '03150691-2',
    '05645983807-2',
    '04883352-1',
    '00106409-2',
    '08035135-1',
    '29467080-2',
    '21213500630-2',
    '08054068-1',
    '82022021-1',
    '03598161-2',
    '54905897-1',
    '04146300-2',
    '27275197-1',
    '35828090-2',
    '08054068-2',
    '13274958-1',
    '07954091-2',
    '13274958-2',
    '57600249-1',
    '57600249-2',
    '33768854-2',
    '29137523-1',
    '12636035-1',
    '29137523-2',
    '12636035-2',
    '33768854-1'
  )
ORDER BY
  hps.creation_date DESC
