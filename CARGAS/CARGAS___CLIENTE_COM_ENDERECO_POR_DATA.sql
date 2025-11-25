select
  count(*) over() as total,
  -- dados do cliente
  hp.party_id,
  hp.party_name as nome_cliente,
  hp.party_number as codigo_cliente,
  nvl(flv_tl.meaning, hp.party_type) as tipo_cliente_pt,
  nvl(ft_tl.territory_short_name, hp.country) as pais_pt,
  -- conta do cliente
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
  ) as data_atualizacao,
  hps.party_site_id as id_endereco,
  hps.party_site_number as cod_endereco,
  hps.party_site_name as nome_endereco,
  hl.location_id as location_id,
  hl.address1,
  hl.address2,
  hl.address3,
  hl.address4,
  hl.city as cidade,
  hl.state as estado,
  hl.postal_code as cep,
  hl.province as provincia,
  hl.country as pais_location,
  hpsu.site_use_type as tipo_uso,
  to_char(
    from_tz(cast(hps.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as data_criacao_endereco,
  to_char(
    from_tz(cast(hps.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as data_atualizacao_endereco
from
  hz_parties hp
  join hz_cust_accounts hca on hp.party_id = hca.party_id
  left join hz_customer_profiles_f hcpf on hca.cust_account_id = hcpf.cust_account_id
  left join hz_party_sites hps on hps.party_id = hp.party_id
  left join hz_locations hl on hl.location_id = hps.location_id
  left join hz_party_site_uses hpsu on hps.party_site_id = hpsu.party_site_id
  left join fnd_lookup_values_tl flv_tl on flv_tl.lookup_type = 'party_type'
  and flv_tl.lookup_code = hp.party_type
  and flv_tl.language = 'ptb'
  left join fnd_territories_tl ft_tl on ft_tl.territory_code = hp.country
  and ft_tl.language = 'ptb'
where
  1 = 1 
  -- and hp.party_number like '%03868183%'
  -- and hpsu.site_use_type = 'bill_to'
  -- and hp.party_name = 'maxicon'
  -- and hcpf.created_by = 'franciele.rossetto@plumaagro.com.br'
order by
  hps.creation_date desc
