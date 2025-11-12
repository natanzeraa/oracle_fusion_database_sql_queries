/*---------------------------------------------------------------------------------------------------------------------------------------
| CONSULTA CLIENTES - ORACLE CLOUD ERP (HZ_PARTIES / HZ_CUST_ACCOUNTS)
|
| OBJETIVO:
|   Retornar a lista de clientes criados ou atualizados recentemente no Oracle Cloud ERP,
|   exibindo informacoes de identificacao, origem da carga, responsaveis pela criacao/atualizacao
|   e datas formatadas no fuso horario de Sao Paulo.
|
| DESCRICAO GERAL:
|   - Essa consulta e utilizada para monitorar integracoes de clientes (via API ou FBDI)
|     no modulo de Customer Data Management (TCA) do Oracle Fusion Cloud.
|   - Permite identificar a origem da criacao de registros, bem como auditar quem criou ou atualizou
|     os cadastros no periodo especificado.
|
| FONTES DE DADOS:
|   - HZ_PARTIES ................. Contem dados da entidade base (cliente, fornecedor, pessoa).
|   - HZ_CUST_ACCOUNTS ........... Relaciona a entidade a uma conta de cliente no ERP.
|
| CAMPOS RETORNADOS:
|   - ID_CLIENTE ................ Identificador do cliente (PARTY_ID)
|   - NOME_CLIENTE .............. Nome do cliente (PARTY_NAME)
|   - TIPO_CLIENTE .............. Tipo da entidade ('ORGANIZATION' = PJ, 'PERSON' = PF)
|   - ID_CONTA_CLIENTE .......... Identificador da conta de cliente
|   - NUMERO_CONTA .............. Numero da conta atribuida
|   - PARTY_ORIG_SYSTEM_REF ..... Referencia de origem do cliente (ex: sistema legado, FBDI, integracao)
|   - ACCOUNT_ORIG_SYSTEM_REF ... Referencia de origem da conta
|   - PARTY_CRIADO_POR_ID ....... ID do usuario que criou o registro da entidade
|   - PARTY_DATA_CRIACAO_LOCAL .. Data/hora local de criacao do cliente
|   - PARTY_ATUALIZADO_POR_ID ... ID do usuario que atualizou a entidade
|   - PARTY_DATA_ATUALIZACAO_LOCAL Data/hora local da ultima atualizacao do cliente
|   - CONTA_CRIADA_POR_ID ....... ID do usuario que criou a conta do cliente
|   - CONTA_DATA_CRIACAO_LOCAL .. Data/hora local de criacao da conta
|   - CONTA_ATUALIZADA_POR_ID ... ID do usuario que atualizou a conta
|   - CONTA_DATA_ATUALIZACAO_LOCAL Data/hora local da ultima atualizacao da conta
|   - MODULO_CRIACAO_PARTY ...... Modulo responsavel pela criacao (ex: ORA_HZ_DATA_IMPORT, HZ, etc.)
|
| FILTROS SUGERIDOS:
|   - Por padrao, traz registros criados nos ultimos 30 dias.
|   - Para segmentar por tipo:
|       - Pessoas Juridicas (PJ): hp.party_type = 'ORGANIZATION'
|       - Pessoas Fisicas (PF):   hp.party_type = 'PERSON'
|
| AUTOR: Natan Felipe de Oliveira
| DATA: 06/11/2025
| CONTEXTO: Projeto de Integracao e Auditoria de Clientes no Oracle Cloud ERP
---------------------------------------------------------------------------------------------------------------------------------------*/

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
;




