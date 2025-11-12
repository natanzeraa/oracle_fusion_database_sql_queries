-- BUSCA TODOS OS CATALOGOS + RESPONSAVEL POR ATUALIZAR + DATA DA ULTIMA ATUALIZACAO
SELECT
  eict.category_set_name as NOME_DO_CATALOGO,
  eict.description as DESCRICAO,
  eict.last_updated_by as ATUALIZADO_POR,
  to_char(
    from_tz(cast(eict.last_update_date as TIMESTAMP), 'UTC') at time zone 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) as ATUALIZADO_EM
FROM
  egp_category_sets_tl eict
WHERE
  1 = 1
ORDER BY
  eict.category_set_name
                    
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
  table_name = 'egp_category_sets_tl'
ORDER BY
  column_id
;
