/*----------------------------

BUSCA FORNECEDORES E ENDEREÃÂOS 

ESTA CONSULTA RETORNA TODOS OS FORNECEDORES CADASTRADOS NO SISTEMA, INCLUINDO SUAS INFORMAÃÂÃÂES PRINCIPAIS E ENDEREÃÂOS ASSOCIADOS.
ELA UTILIZA AS TABELAS DE CADASTRO DE FORNECEDOR (POZ_SUPPLIERS), PARTES (HZ_PARTIES), LOCAIS (HZ_PARTY_SITES) E ENDEREÃÂOS (HZ_LOCATIONS). 

CADA FORNECEDOR (POZ_SUPPLIERS) ESTÃÂ ASSOCIADO A UMA "PARTE" (HZ_PARTIES), QUE PODE TER UM OU MAIS LOCAIS DE NEGÃÂCIO (HZ_PARTY_SITES). 
CADA LOCAL, POR SUA VEZ, POSSUI UM ENDEREÃÂO FÃÂSICO (HZ_LOCATIONS).

UTILIZA JOIN ENTRE ESSAS TABELAS PARA TRAZER NOME, NÃÂMERO DO FORNECEDOR, TIPO, MODO DE CRIAÃÂÃÂO, DATA DE CRIAÃÂÃÂO/ATUALIZAÃÂÃÂO E ENDEREÃÂO.

FONTE: https://docs.oracle.com/en/cloud/saas/procurement/24b/oedsc/pozsuppliers-27481.html
----------------------------*/
SELECT
  hp.party_name AS FORNECEDOR,
  ps.segment1 AS NUMERO_FORNECEDOR,
  ps.creation_source as MODO_DE_CRIACAO,
  ps.vendor_type_lookup_code as TIPO,
  ps.created_by AS CRIADO_POR,
  TO_CHAR(
    FROM_TZ(CAST(ps.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS data_criacao,
  ps.last_updated_by AS quem_atualizou,
  TO_CHAR(
    FROM_TZ(CAST(ps.last_update_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS data_atualizacao,
  hps.party_site_name AS SITE,
  hl.address1 || NVL2(hl.address2, ', ' || hl.address2, '') || NVL2(hl.address3, ', ' || hl.address3, '') AS endereco,
  hl.city AS cidade,
  hl.state AS estado,
  hl.postal_code AS cep,
  hl.country AS pais
FROM
  poz_suppliers ps
  JOIN hz_parties hp ON ps.party_id = hp.party_id
  LEFT JOIN hz_party_sites hps ON hp.party_id = hps.party_id
  LEFT JOIN hz_locations hl ON hps.location_id = hl.location_id
WHERE
  1 = 1
  and ps.enabled_flag = 'Y' 
  --  and ps.created_by = 'leonardo.gomes@plumaagro.com.br'
  and ps.last_updated_by = 'natan.oliveira@plumaagro.com.br'
ORDER BY
  ps.last_update_date DESC
;

-- BUSCA TODAS AS COLUNAS PRESENTES NA TABELA
SELECT
  column_name,
  data_type,
  data_length,
  data_precision,
  data_scale,
  nullable,
  data_default
FROM  
  all_tab_columns
WHERE
  table_name = 'POZ_SUPPLIERS'
ORDER BY
  column_id
;


