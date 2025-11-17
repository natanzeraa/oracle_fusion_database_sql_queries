SELECT
  count(*) over() as TOTAL,
  ps.vendor_id,
  hp.party_name AS NOME_FORNECEDOR,
  hp.party_number AS PARTE,
  ps.segment1 AS CODIGO_FORNECEDOR,
  ps.vendor_type_lookup_code AS TIPO_FORNECEDOR,
  ps.taxpayer_country AS PAIS_FISCAL,
  ps.CREATION_SOURCE AS TIPO_CRIACAO,
  ps.created_by as criado_por,
  TO_CHAR(
    FROM_TZ(CAST(ps.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS DATA_CRIACAO,
  ps.last_updated_by,
  TO_CHAR(
    FROM_TZ(CAST(ps.last_update_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS DATA_ATUALIZACAO
FROM
  poz_suppliers ps
  LEFT JOIN hz_parties hp ON ps.party_id = hp.party_id  
WHERE
 1 = 1
  /*TRUNC(
      FROM_TZ(CAST(ps.last_update_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo'
    )
    BETWEEN TO_DATE('11/11/2025', 'DD/MM/YYYY')
        AND TO_DATE('11/11/2025', 'DD/MM/YYYY')
  */
  
  and TRUNC(
    FROM_TZ(CAST(ps.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo'
  ) BETWEEN TO_DATE('01/11/2025', 'DD/MM/YYYY')
  AND TO_DATE('30/11/2025', 'DD/MM/YYYY')
  
--  AND ps.created_by = 'leonardo.guilherme@ninecon.com.br'      
 
ORDER BY
  ps.creation_date DESC
  
