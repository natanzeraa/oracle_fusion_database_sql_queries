select
  count(*) over() as total,
  hp.party_id,
  hp.party_name as customer_name,
  hp.party_type,
  hca.account_number,
  hca.cust_account_id,
  hcpf.cust_account_profile_id,
  hcpf.profile_class_id,
  hl.address1 || nvl2(hl.address2, ', ' || hl.address2, '') || nvl2(hl.address3, ', ' || hl.address3, '') as endereco,
  hl.city,
  hl.postal_code,
  hl.state,  
  hl.country,  
  hcpf.last_updated_by,
  to_char(from_tz(cast(hcpf.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as last_update_date_local,
  hcpf.created_by,
  to_char(from_tz(cast(hcpf.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as creation_date    
from
  hz_parties hp
  inner join hz_cust_accounts hca on hp.party_id = hca.party_id
  left join hz_customer_profiles_f hcpf on hca.cust_account_id = hcpf.cust_account_id
  left join hz_party_sites hps on hp.party_id = hps.party_id
  left join hz_locations hl on hps.location_id = hl.location_id  
where
  1 = 1
  -- and hp.party_type = 'organization'
  -- and hcpf.last_updated_by like '%natan%'
  and trunc(from_tz(cast(hp.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('01/11/2025', 'dd/mm/yyyy') and to_date('19/11/2025', 'dd/mm/yyyy')  
order by
  hcpf.creation_date desc,
  hcpf.last_update_date desc    
    
