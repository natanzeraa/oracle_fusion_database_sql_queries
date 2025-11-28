select count(*) over() as total
  ,hca.account_name
  ,hca.account_number
  ,hca.customer_type
  ,case
    when ps.vendor_id is not null and hca.cust_account_id is not null then upper('clifor')
    when ps.vendor_id is not null then upper('fornecedor')
    when hca.cust_account_id is not null then upper('cliente')
    else upper('sem papel')
  end as type_
  --
  ,hp.party_type
  --
  ,hca.cust_account_id
  ,hca.party_id
  ,hca.orig_system_reference  
  ,hca.status
  --
  ,hca.created_by
  ,to_char(from_tz(cast(hca.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as creation_date
  ,hca.last_updated_by
  ,to_char(from_tz(cast(hca.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as last_update_date
from
  hz_cust_accounts hca
  left join hz_parties hp on hca.party_id = hp.party_id
  left join poz_suppliers ps on hca.party_id = ps.party_id
where
  1 = 1
  and hca.cust_account_id is not null
  and ps.vendor_id is null
order by
  hca.last_update_date desc
                                               
                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
