select
  count(*) over() as total,
  pscai.vendor_id as id_fornecedor,
  pscai.vendor_name as nome_fornecedor,
  pscai.batch_id,
  pscai.contact_address_interface_id,
  pscai.first_name || ' ' || pscai.last_name as nome_completo_contato,
  pscai.email_address as contato,  
  pscai.import_action,
  pscai.import_status,
  pscai.load_request_id,
  pscai.party_site_id,
  hl.address1 || nvl2(hl.address2, ', ' || hl.address2, '') ||nvl2(hl.address3, ', ' || hl.address3, '') as endereco,
  hl.city as cidade,
  hl.state as estado,
  hl.postal_code as cep,
  hl.country as pais,
  pscai.party_site_name,
  pscai.per_party_id,
  pscai.request_id,
  pscai.last_updated_by,
  to_char(from_tz(cast(pscai.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as atualizado_em,
  pscai.created_by,  
  to_char(from_tz(cast(pscai.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as criado_em
from  
  poz_sup_contact_addresses_int pscai
  left join hz_party_sites hps on pscai.party_site_id = hps.party_site_id
  left join hz_locations hl on hps.location_id = hl.location_id
where
  1 = 1
  and trunc(from_tz(cast(pscai.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('19/11/2025', 'dd/mm/yyyy') and to_date('19/11/2025', 'dd/mm/yyyy')  
  and pscai.import_status = 'PROCESSED'          
order by
  pscai.creation_date desc

