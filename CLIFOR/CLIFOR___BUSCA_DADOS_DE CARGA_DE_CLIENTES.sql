select
    hp.party_id as id_cliente,
    hp.party_name as nome_cliente,
    hp.party_type as tipo_cliente,
    hca.cust_account_id as id_conta_cliente,
    hca.account_number as numero_conta,
    hp.orig_system_reference as party_orig_system_ref,
    hca.orig_system_reference as account_orig_system_ref,
    hp.created_by as party_criado_por_id,
    to_char(
        from_tz(cast(hp.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo',
        'dd/mm/yyyy hh24:mi:ss'
    ) as party_data_criacao_local,
    hp.last_updated_by as party_atualizado_por_id,
    to_char(
        from_tz(cast(hp.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo',
        'dd/mm/yyyy hh24:mi:ss'
    ) as party_data_atualizacao_local,
    hca.created_by as conta_criada_por_id,    
    to_char(
        from_tz(cast(hca.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo',
        'dd/mm/yyyy hh24:mi:ss'
    ) as conta_data_criacao_local,
    hca.last_updated_by as conta_atualizada_por_id,
    to_char(
        from_tz(cast(hca.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo',
        'dd/mm/yyyy hh24:mi:ss'
    ) as conta_data_atualizacao_local,
    hp.created_by_module as modulo_criacao_party
from
    hz_parties hp
    join hz_cust_accounts hca on hca.party_id = hp.party_id
where
    1 = 1
    -- and hp.party_type = 'organization'
    -- and hp.party_type = 'person'
    and hp.creation_date > sysdate - 30
    -- and hp.party_name like '%e outro%'
order by
    hp.last_update_date desc






