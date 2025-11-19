select
  count(*) over() as total,
  hp.party_id,
  hp.party_name,
  case
    when ps.vendor_id is not null then 'fornecedor'
  end as tipo_fornecedor,
  case
    when hca.cust_account_id is not null then 'cliente'
  end as tipo_cliente
from
  hz_parties hp
  inner join poz_suppliers ps on ps.party_id = hp.party_id
  inner join hz_cust_accounts hca on hca.party_id = hp.party_id
where
  1 = 1
