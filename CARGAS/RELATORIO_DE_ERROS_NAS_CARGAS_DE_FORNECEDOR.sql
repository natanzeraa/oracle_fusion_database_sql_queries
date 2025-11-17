-- TODAS AS COLUNAS DA TABELA DE FORNECEDOR
select
  table_name,
  column_name
from
  all_tab_columns
where
  1 = 1
  and table_name = 'POZ_SUPPLIER_INT_REJECTIONS'
;
  
-- BUSCA OS ERROS DE IMPORTACAO DA TABELA DE FORNECEDOR
select
  psir.REJECTION_ID,
  psir.PARENT_TABLE,
  psir.PARENT_ID,
  psir.VALUE,
  psir.REJECT_LOOKUP_CODE,
  psir.APP_NAME,
  psir.ATTRIBUTE,
--  psir.OBJECT_VERSION_NUMBER,
--  psir.REQUEST_ID,
--  psir.JOB_DEFINITION_NAME,
--  psir.JOB_DEFINITION_PACKAGE,
  psir.LAST_UPDATED_BY,
  to_char(
    from_tz(cast(psir.LAST_UPDATE_DATE as timestamp), 'UTC') at time zone 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) as LAST_UPDATE_DATE,
  --  psir.LAST_UPDATE_LOGIN,
  psir.CREATED_BY,
  to_char(
    from_tz(cast(psir.CREATION_DATE as timestamp), 'UTC') at time zone 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) as CREATION_DATE,
  count(*) over() as TOTAL  
from
  POZ_SUPPLIER_INT_REJECTIONS psir
where
  1 = 1
  and trunc(
    from_tz(cast(psir.CREATION_DATE as timestamp), 'UTC') at time zone 'America/Sao_Paulo'
  ) between to_date('01/11/2025', 'DD/MM/YYYY')
  and to_date('30/11/2025', 'DD/MM/YYYY')
order by
  psir.CREATION_DATE desc
;

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
  hl.address1 || 
    NVL2(hl.address2, ', ' || hl.address2, '') || 
    NVL2(hl.address3, ', ' || hl.address3, '') AS endereco,
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
  and ps.created_by = 'franciele.rossetto@plumaagro.com.br'
  -- and hp.party_name = 'COMPANHIA PAULISTA DE FORCA E LUZ'
ORDER BY    
  ps.last_update_date DESC
;


SELECT
    hp.party_id,
    hp.party_name,
    hop.jgzz_fiscal_code     AS cnpj,
    hop.taxpayer_id          AS taxpayer, 
    hop.organization_name    AS org_profile_name
FROM hz_parties hp
LEFT JOIN hz_organization_profiles hop 
       ON hop.party_id = hp.party_id
WHERE hop.jgzz_fiscal_code = '<CNPJ>'
   OR hop.taxpayer_id = '300000072288240'


