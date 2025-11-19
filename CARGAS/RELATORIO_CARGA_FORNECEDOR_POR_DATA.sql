select
  count(*) over() as total,
  ps.vendor_id,
  hp.party_name as nome_fornecedor,
  hp.party_number as parte,
  ps.segment1 as codigo_fornecedor,
  ps.vendor_type_lookup_code as tipo_fornecedor,
  ps.taxpayer_country as pais_fiscal,
  ps.creation_source as tipo_criacao,
  ps.created_by as criado_por,
  to_char(
    from_tz(cast(ps.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as data_criacao,
  ps.last_updated_by,
  to_char(
    from_tz(cast(ps.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as data_atualizacao
from
  poz_suppliers ps
  left join hz_parties hp on ps.party_id = hp.party_id
where
  1 = 1
  /*trunc(
          from_tz(cast(ps.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo'
        )
        between to_date('11/11/2025', 'dd/mm/yyyy')
            and to_date('11/11/2025', 'dd/mm/yyyy')
      */
  and trunc(
    from_tz(cast(ps.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo'
  ) between to_date('10/11/2025', 'dd/mm/yyyy')
  and to_date('10/11/2025', 'dd/mm/yyyy') 
  --  and ps.created_by = 'leonardo.guilherme@ninecon.com.br'
order by
  ps.creation_date desc

