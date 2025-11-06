-- BUSCA TODAS AS CLASSES DE PRODUTOS DO PDH
select
  eicb.ITEM_CLASS_TYPE as TIPO_DA_CLASSE,
  eicb.ITEM_CLASS_CODE as NOME_DA_CLASSE,
  eicb.PARENT_ITEM_CLASS_ID as CLASSE_PAI,
  case
    when eicb.ENABLED_FLAG = 'Y' then 'ATIVA'
    else 'INATIVA'
  end as STATUS_DA_CLASSE
from
  egp_item_classes_b eicb
where eicb.ENABLED_FLAG = 'Y'      
order by eicb.ITEM_CLASS_CODE asc
;
 
-- BUSCA TOTAL DE CLASSES DE PRODUTOS DO PD
select
  count(*)
from
  (
    select
      eicb.ITEM_CLASS_TYPE as TIPO_DA_CLASSE,
      eicb.ITEM_CLASS_CODE as NOME_DA_CLASSE,
      case
        when eicb.ENABLED_FLAG = 'Y' then 'ATIVA'
        else 'INATIVA'
      end as STATUS_DA_CLASSE
    from
      egp_item_classes_b eicb
    where eicb.ENABLED_FLAG = 'Y'        
  )      
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
  table_name = 'egp_item_classes_b'
ORDER BY
  column_id
;
