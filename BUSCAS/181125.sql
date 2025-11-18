SELECT DISTINCT 
  -- count(*) over() as TOTAL,
  class_tl.description AS CLASSE_DO_ITEM,
  iop.organization_code AS ORGANIZACAO,
  case
    when esib.inventory_item_status_code = 'Active' then 'ATIVO'
    else 'INATIVO'
  end as STATUS_DE_INVENTARIO,
  case
    when esib.approval_status = 'A' then 'APROVADO'
    else 'REPROVADO'
  end as STATUS_APROVACAO,
  esib.item_number AS CODIGO_DO_ITEM,
  esiv.description AS DESCRICAO_DO_ITEM  
  --esib.last_updated_by as QUEM_ATUALIZOU,
  --to_char(from_tz(cast(esib.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as ATUALIZADO_EM,
  --esib.created_by as QUEM_CRIOU,
  --to_char(from_tz(cast(esib.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as CRIADO_EM
FROM
  egp_system_items_b esib
  JOIN egp_system_items_vl esiv ON esiv.inventory_item_id = esib.inventory_item_id
  AND esiv.organization_id = esib.organization_id
  JOIN inv_org_parameters iop ON iop.organization_id = esib.organization_id
  JOIN egp_item_classes_b class ON esib.item_catalog_group_id = class.item_class_id
  JOIN egp_item_classes_tl class_tl ON class.item_class_id = class_tl.item_class_id
  AND class_tl.language = 'PTB'
where
  1 = 1
  -- and esib.approval_status = 'A'
  and esib.inventory_item_status_code = 'Active'     
  and esib.item_number in (
  '00870915',
  '00870907',
  '00008589',
  '05201644',
  '00004887',
  '05072839',
  '05072636',
  '05196445',
  '05154243',
  '05130631',
  '00000585',
  '05078444',
  '05094044',
  '05078436',
  '05040235',
  '00508764',
  '00001168',
  '00004765',
  '00004773',
  '02594603',
  '02886617',
  '04424928',
  '03384961',
  '00710015',
  '00047574',
  '04114779',
  '00141306',
  '00848308',
  '00848316',
  '00001016',
  '03898275',
  '05107847',
  '00002934',
  '00004384',
  '05061433',
  '00863917',
  '00890128',
  '00706696',
  '00851101',
  '00277777',
  '00859721',
  '05309845',
  '04632109',
  '00017888',
  '00834302',
  '05246649',
  '00776291',
  '00062112',
  '05229063',
  '05229055',
  '04454233',
  '04024917',
  '04543488',
  '00015327',
  '00015335',
  '00009699',
  '05131839',
  '00081861',
  '00015116',
  '00015124',
  '00786108',
  '00834505',
  '00786116',
  '00057967',
  '05281843',
  '05218266',
  '05170232',
  '05188645',
  '00887504',
  '00772492',
  '02642555',
  '05206456',
  '00001107',
  '00001095',
  '00004951',
  '00004943',
  '05199297',
  '00001987',
  '00001979',
  '05094052'
)   
  -- and esib.inventory_item_status_code = 'Inactive'
  -- and esiv.description like '%BAG VACINA%'
  -- and esib.last_updated_by like '%@ninecon%'

;
  
  
SELECT
  ae.entity_name,
  atv.primary_key_value,
  atv.column_name,
  atv.old_value,
  atv.new_value,
  atv.last_update_date,
  atv.last_updated_by
FROM
  fnd_audit_trail atv
  JOIN fnd_audit_entities ae ON ae.entity_id = atv.entity_id
WHERE
  ae.entity_name = 'egp_system_items_b'
  AND atv.primary_key_value = '00000009'  
ORDER BY
  atv.last_update_date DESC
;

SELECT
    esib.item_number,
    esiv.description,
    esib.last_updated_by,
    to_char( from_tz(cast(esib.last_update_date as timestamp), 'UTC') at time zone 'America/Sao_Paulo', 'DD/MM/YYYY HH24:MI:SS') as ATUALIZADO_EM    
FROM
    egp_system_items_b esib
    JOIN egp_system_items_vl esiv
        ON esiv.inventory_item_id = esib.inventory_item_id
       AND esiv.organization_id = esib.organization_id
WHERE
    lower(esib.last_updated_by) = 'marcelo.silva@ninecon.com.br'
ORDER BY
    esib.last_update_date DESC

;

SELECT
    pi.INCOME_TAX_ID,
    COUNT(*) AS qtd_fornecedores
FROM
    POZ_SUPPLIERS_PII pi
GROUP BY
    pi.INCOME_TAX_ID
HAVING
    COUNT(*) > 1

;


SELECT
    v.VENDOR_NAME,
    pi.INCOME_TAX_ID,
    COUNT(*) AS qtd
FROM
    POZ_SUPPLIERS_V   v
    JOIN POZ_SUPPLIERS_PII pi
      ON pi.VENDOR_ID = v.VENDOR_ID
GROUP BY
    v.VENDOR_NAME,
    pi.INCOME_TAX_ID
HAVING
    COUNT(*) > 1
;

SELECT
    ps.VENDOR_NAME,
    COUNT(*) AS qtd
FROM
    POZ_SUPPLIERS_V ps
GROUP BY
    ps.VENDOR_NAME
HAVING
    COUNT(*) > 1
    
;
SELECT
    v.VENDOR_ID,
    v.SEGMENT1           AS CODIGO_FORNECEDOR,
    v.VENDOR_NAME,
    v.VENDOR_TYPE_LOOKUP_CODE,
    pi.INCOME_TAX_ID     AS CNPJ_CPF,
    v.ENABLED_FLAG,
    v.START_DATE_ACTIVE,
    v.END_DATE_ACTIVE
FROM
    POZ_SUPPLIERS_V   v
    LEFT JOIN POZ_SUPPLIERS_PII pi
       ON pi.VENDOR_ID = v.VENDOR_ID
WHERE
  1 = 1
  -- and v.VENDOR_ID = :VENDOR_ID
  and v.vendor_name = 'MUNICIPIO DE FAXINAL DOS GUEDES'      
  
;

SELECT
  ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID,
  ZxPartyTaxProfile.PARTY_TYPE_CODE,
  PTY.PARTY_NAME,
  PTY.PARTY_ID
FROM
  ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile,
  HZ_PARTIES PTY
WHERE
  ZxPartyTaxProfile.PARTY_TYPE_CODE = 'TAX_AUTHORITY'
  AND ZxPartyTaxProfile.PARTY_ID = PTY.PARTY_ID  
  
;


select
  count(*) over() as total,
  hp.party_name as fornecedor,
  ps.segment1 as numero_fornecedor,
  ps.creation_source as modo_de_criacao,
  ps.vendor_type_lookup_code as tipo,
  -- ps.EXTERNAL_SYSTEM as SISTEMA_EXTERNO,  
  ps.created_by as criado_por,
  to_char(
    from_tz(cast(ps.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as data_criacao,
  ps.last_updated_by as quem_atualizou,
  to_char(
    from_tz(cast(ps.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as data_atualizacao,
  hps.party_site_name as site,
  hl.address1 || nvl2(hl.address2, ', ' || hl.address2, '') || nvl2(hl.address3, ', ' || hl.address3, '') as endereco,
  hl.city as cidade,
  hl.state as estado,
  hl.postal_code as cep,
  hl.country as pais
from
  poz_suppliers ps
  join hz_parties hp on ps.party_id = hp.party_id  
  left join hz_party_sites hps on hp.party_id = hps.party_id
  left join hz_locations hl on hps.location_id = hl.location_id
where
  1 = 1
  and ps.enabled_flag = 'Y' 
  and hp.party_name = upper('CASSILANDIA AGROAVICOLA LTDA 41')    
  -- and ps.created_by = 'leonardo.gomes@plumaagro.com.br'
  -- and ps.last_updated_by = 'franciele.rossetto@plumaagro.com.br'   
  -- and hl.address1 is null      
order by
  ps.last_update_date desc
;

SELECT
    pi.VENDOR_ID,
    pi.INCOME_TAX_ID AS CNPJ,
    v.VENDOR_NAME,
    v.SEGMENT1        AS CODIGO_FORNECEDOR,
    v.VENDOR_TYPE_LOOKUP_CODE AS TIPO_FORNECEDOR,
    v.ENABLED_FLAG
FROM
    POZ_SUPPLIERS_PII pi
    JOIN POZ_SUPPLIERS_V v
        ON v.VENDOR_ID = pi.VENDOR_ID
WHERE
    pi.INCOME_TAX_ID = '07277875000184'
;
