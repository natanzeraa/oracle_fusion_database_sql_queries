select
  count(*) over() as total,
  hp.party_id,
  hp.party_name as nome_cliente,
  hp.party_number as codigo_cliente,
  nvl(flv_tl.meaning, hp.party_type) as tipo_cliente_pt,
  nvl(ft_tl.territory_short_name, hp.country) as pais_pt,
  hca.account_number as conta_cliente,
  hca.orig_system_reference as sistema_origem,
  case
    when hca.orig_system_reference is not null then 'importado'
    when hca.job_definition_name is not null then 'batch/import'
    else 'manual'
  end as origem_registro,
  hcpf.created_by as criado_por,
  to_char(
    from_tz(cast(hcpf.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as data_criacao,
  hcpf.last_updated_by as atualizado_por,
  to_char(
    from_tz(cast(hcpf.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as data_atualizacao
from
  hz_parties hp
  join hz_cust_accounts hca on hp.party_id = hca.party_id
  left join hz_customer_profiles_f hcpf on hca.cust_account_id = hcpf.cust_account_id
  left join fnd_lookup_values_tl flv_tl on flv_tl.lookup_type = 'party_type'
  and flv_tl.lookup_code = hp.party_type
  and flv_tl.language = 'ptb'
  left join fnd_territories_tl ft_tl on ft_tl.territory_code = hp.country
  and ft_tl.language = 'ptb'
where
 1= 1
 and trunc( from_tz(cast(hcpf.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('01/11/2025', 'dd/mm/yyyy') and to_date('30/11/2025', 'dd/mm/yyyy')
  -- and hp.party_number like '%08733109%'   
  --  and hcpf.created_by = 'leonardo.guilherme@ninecon.com.br'      
  --  and hp.party_name = 'abirush automacao e sistemas ltda'   
order by
  hcpf.creation_date desc

