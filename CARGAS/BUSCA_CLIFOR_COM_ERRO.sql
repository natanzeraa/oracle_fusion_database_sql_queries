-- Buscar a empresa que der o erro:
-- "You must enter the organization name of the registry ID as the supplier name."
SELECT
  hp.party_name AS FORNECEDOR,
  ps.segment1 AS NUMERO_FORNECEDOR,
  ps.creation_source as MODO_DE_CRIACAO,
  ps.vendor_type_lookup_code as TIPO,
  ps.created_by AS CRIADO_POR,
  TO_CHAR(
    FROM_TZ(CAST(ps.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS data_criacao,
  ps.last_updated_by AS quem_atualizou,
  TO_CHAR(
    FROM_TZ(CAST(ps.last_update_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS data_atualizacao,
  hps.party_site_name AS SITE,
  hl.address1 || NVL2(hl.address2, ', ' || hl.address2, '') || NVL2(hl.address3, ', ' || hl.address3, '') AS endereco,
  hl.city AS cidade,
  hl.state AS estado,
  hl.postal_code AS cep,
  hl.country AS pais
FROM
  poz_suppliers ps
  JOIN hz_parties hp ON ps.party_id = hp.party_id
  LEFT JOIN hz_party_sites hps ON hp.party_id = hps.party_id
  LEFT JOIN hz_locations hl ON hps.location_id = hl.location_id
WHERE
  ps.enabled_flag = 'Y'
  -- and ps.created_by = 'franciele.rossetto@plumaagro.com.br' 
  -- and hp.party_name = 'COMPANHIA PAULISTA DE FORCA E LUZ'
ORDER BY
  ps.last_update_date DESC
