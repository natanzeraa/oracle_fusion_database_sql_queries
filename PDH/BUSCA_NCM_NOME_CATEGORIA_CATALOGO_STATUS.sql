-- BUSCA NOME DA CATEGORIA DE NCM ATIVO
SELECT
  eict.category_set_name AS NCM,
  ectl.category_name as NOME_CATEGORIA,
  esib.inventory_item_status_code AS STATUS_DO_ITEM
FROM
  egp_item_categories eic
  JOIN egp_system_items_b esib ON esib.inventory_item_id = eic.inventory_item_id
  AND esib.organization_id = eic.organization_id
  JOIN egp_category_sets_tl eict ON eict.category_set_id = eic.category_set_id
  AND eict.language = 'PTB'
  JOIN inv_org_parameters iop ON iop.organization_id = esib.organization_id
  JOIN egp_categories_tl ectl ON ectl.category_id = eic.category_id
WHERE
  eict.category_set_name LIKE '%LACLS_NCM_SERVICE_CODE%'
  AND iop.organization_code = 'ITEM_ORG_MESTRE'
  AND esib.inventory_item_status_code = 'Active'
ORDER BY  
  eict.category_set_name             
;
  
  
select count(*)
from
  (
    SELECT
      eict.category_set_name AS NCM,
      ectl.category_name as NOME_CATEGORIA,
      esib.inventory_item_status_code AS STATUS_DO_ITEM
    FROM
      egp_item_categories eic
      JOIN egp_system_items_b esib ON esib.inventory_item_id = eic.inventory_item_id
      AND esib.organization_id = eic.organization_id
      JOIN egp_category_sets_tl eict ON eict.category_set_id = eic.category_set_id
      AND eict.language = 'PTB'
      JOIN inv_org_parameters iop ON iop.organization_id = esib.organization_id
      JOIN egp_categories_tl ectl ON ectl.category_id = eic.category_id
    WHERE
      eict.category_set_name LIKE '%LACLS_NCM_SERVICE_CODE%'
      AND iop.organization_code = 'ITEM_ORG_MESTRE'
      AND esib.inventory_item_status_code = 'Active'
    ORDER BY
      eict.category_set_name
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
  table_name = 'egp_item_categories'
ORDER BY
  column_id
;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

