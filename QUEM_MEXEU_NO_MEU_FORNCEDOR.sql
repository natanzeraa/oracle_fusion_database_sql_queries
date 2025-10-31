SELECT
  hp.party_name AS supplier_name,
  ps.segment1 AS supplier_number,
  ps.creation_source,
  ps.vendor_type_lookup_code,
  ps.created_by as CRIADO_POR,
  to_char(
    from_tz(cast(ps.creation_date as TIMESTAMP), 'UTC') at time zone 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) as DaTA_CRIACAO,
  ps.last_updated_by as QUEM_ATUALIZOU,
  to_char(
    from_tz(cast(ps.last_update_date as timestamp), 'UTC') at time zone 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) as DATA_ATUALIZACAO
FROM
  poz_suppliers ps
  JOIN hz_parties hp ON ps.party_id = hp.party_id
ORDER BY
  ps.last_update_date DESC
  ;
