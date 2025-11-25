select
  count(*) over() as total,
  hp.party_name as fornecedor,
  ps.segment1 as numero_fornecedor,
  ps.creation_source as modo_de_criacao,
  ps.vendor_type_lookup_code as tipo,
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
  -- and ps.vendor_type_lookup_code = 'TRANSPORTADOR'
  -- and hp.party_name = upper('MUNICIPIO DE FAXINAL DOS GUEDES')    
  -- and ps.created_by = 'leonardo.gomes@plumaagro.com.br'
  -- and ps.last_updated_by = 'franciele.rossetto@plumaagro.com.br' 
  -- and trunc(from_tz(cast(ps.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('18/11/2025', 'dd/mm/yyyy') and to_date('18/11/2025', 'dd/mm/yyyy')    
  -- and hl.address1 is null      
order by
  ps.last_update_date desc
  


