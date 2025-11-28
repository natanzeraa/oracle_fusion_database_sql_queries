with base as (
  select 
    count(*) over() as total
    ,hp.party_id as id
    ,hp.party_name as nome_clifor
    ,hp.party_type as tipo_parte
    ,hps.party_site_name
    
    ,case
      when ps.vendor_id is not null and hca.cust_account_id is not null then upper('clifor')
      when ps.vendor_id is not null then upper('fornecedor')
      when hca.cust_account_id is not null then upper('cliente')
      else upper('sem papel')
    end as tipo_clifor
    
    ,pssam.attribute1 as cnae
    
    ,hl.address1 || nvl2(hl.address2, ', ' || hl.address2, '') || nvl2(hl.address3, ', ' || hl.address3, '') as endereco
    ,hl.city
    ,hl.postal_code
    ,hl.state
    ,hl.country
    
    ,pscai.first_name as first_name_contato
    ,pscai.last_name as last_name_contato
    ,pscai.email_address as contato
    ,pscai.import_action
    ,pscai.import_status
    
    ,ps.created_by as criado_por
    ,to_char(from_tz(cast(ps.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as data_criacao
    ,ps.last_updated_by as atualizado_por
    ,to_char(from_tz(cast(ps.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as data_atualizacao
    
    -- chave da deduplicacao
    ,row_number() over (
      partition by hp.party_id
      order by ps.last_update_date desc
    ) as rn
    
    /*
    ,hca.created_by as criado_por
    ,to_char(from_tz(cast(hca.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as data_criacao
    ,hca.last_updated_by as atualizado_por
    ,to_char(from_tz(cast(hca.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as data_atualizacao
    */
  from
    hz_parties hp
    left join poz_suppliers ps on ps.party_id = hp.party_id
    left join hz_cust_accounts hca on hca.party_id = hp.party_id
    left join hz_party_sites hps on hp.party_id = hps.party_id
    left join hz_locations hl on hps.location_id = hl.location_id
    left join poz_sup_contact_addresses_int pscai on ps.vendor_id = pscai.vendor_id
    left join poz_supplier_sites_all_m pssam on ps.vendor_id = pssam.vendor_id
  where
    1 = 1
    -- and ps.enabled_flag = 'Y'  
    -- and ps.creation_date is not null
    -- and hp.party_id = '300000014686830'
    -- and (ps.vendor_id is not null and hca.cust_account_id is null) -- somente fornecedor
    -- and (ps.vendor_id is not null and hca.cust_account_id is not null) -- somente clifor
    -- and hp.party_name like '%MUNICIPIO%'
    -- and trunc(from_tz(cast(hp.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('18/11/2025', 'dd/mm/yyyy') and to_date('18/11/2025', 'dd/mm/yyyy') -- Parte
    -- and trunc(from_tz(cast(hca.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('18/11/2025', 'dd/mm/yyyy') and to_date('18/11/2025', 'dd/mm/yyyy') -- Cliente
    -- and trunc(from_tz(cast(ps.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('13/11/2025', 'dd/mm/yyyy') and to_date('30/11/2025', 'dd/mm/yyyy') -- Fornecedor   
  order by
    -- hp.creation_date desc
    -- hp.last_update_date desc
    -- ps.creation_date desc,
    ps.last_update_date desc 
    -- hca.creation_date desc
    -- hca.last_update_date desc                                                                                       
)
select *
from base
where rn = 1
order by data_atualizacao desc




