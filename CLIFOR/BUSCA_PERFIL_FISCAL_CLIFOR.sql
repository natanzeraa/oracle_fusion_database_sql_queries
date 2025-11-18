-------------------------------------------------------------------------------------------------------
-- BUSCA PERFIL FISCAL
-- https://docs.oracle.com/en/cloud/saas/financials/24b/oedmf/zxpartytaxprofile-29027.html#Foreign-Keys
-------------------------------------------------------------------------------------------------------
SELECT
  count(*) over() as TOTAL,
  zptp.PARTY_TAX_PROFILE_ID,  
  hp.PARTY_ID,  
  hp.party_name,  
  zptp.PARTY_TYPE_CODE COD_TIPO_PARTE,  	  	  
  case
    when zptp.CUSTOMER_FLAG = 'Y'  then 'SIM'
    else 'NAO' 
  end as CLIENTE_CONTROLE_TERCEIROS,    
  case
    when zptp.SITE_FLAG = 'Y' then 'SIM'
    else 'NAO'
  end as SITE_TERCEIRO,
  zptp.created_by AS CRIADO_POR,
  TO_CHAR(
    FROM_TZ(CAST(zptp.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS data_criacao,
  zptp.last_updated_by AS quem_atualizou,
  TO_CHAR(
    FROM_TZ(CAST(zptp.last_update_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS data_atualizacao    
FROM
  ZX_PARTY_TAX_PROFILE zptp
  JOIN hz_parties hp ON hp.party_id = zptp.party_id
WHERE
  1 = 1
  -- zptp.tax = '06209369839'
  -- and hp.party_name = 'CONSELHO REGIONAL DE MEDICINA VETERINARIA DO EST DE SP'                   
ORDER BY
  zptp.last_update_date DESC         
    
