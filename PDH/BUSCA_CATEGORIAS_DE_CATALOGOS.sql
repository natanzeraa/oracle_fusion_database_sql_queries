/*------------------------------

BUSCA CATEGORIAS DE CATÁLOGOS

ESSA TABELA REGISTRA OS MAPEAMENTOS ENTRE CATEGORIAS DE CATÁLOGO — OU SEJA:
QUANDO VOCÊ TEM “CATÁLOGO FONTE” E “CATÁLOGO ALVO” E PRECISA RELACIONAR OU MAPEAR CATEGORIAS ENTRE ELES, 
ESTE É O LOCAL ONDE ESSA RELAÇÃO FICA ARMAZENADA. 

FONTE: https://docs.oracle.com/en/cloud/saas/supply-chain-and-manufacturing/24b/oedsc/egpcatgmapdtls-8799.html#egpcatgmapdtls-8799 

------------------------------*/

select
  eica.inventory_item_id as ID_ITEM_INVENTARIO,
  eica.category_id as ID_CATEGORIA,
  ecb.CATEGORY_CODE as CODIGO_CATEGORIA  
from
  egp_item_cat_assignments eica
  join egp_categories_b ecb on ecb.category_id = eica.category_id
where
  1 = 1
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
  table_name = 'egp_item_cat_assignments'
ORDER BY
  column_id
;
