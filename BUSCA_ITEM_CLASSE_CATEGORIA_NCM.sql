
-- BUSCA ITEM CATEGORIA CLASSE E FORNECEDOR
SELECT
  class_tl.description AS ITEM_CLASS_DESCRIPTION,
  iop.organization_code AS ORGANIZATION_CODE,
  esib.item_number AS ITEM_NUMBER,
  esiv.description AS DESCRICAO_ITEM,
  -- eict.category_set_name AS CATALOGO,
  eict.category_set_name as NCM,
  ectl.category_name AS CATEGORY_NAME,
  ectl.description AS CATEGORY_DESCRIPTION
FROM
  egp_item_categories eic
  JOIN egp_system_items_b esib ON esib.inventory_item_id = eic.inventory_item_id
  AND esib.organization_id = eic.organization_id
  JOIN egp_system_items_vl esiv ON esiv.inventory_item_id = esib.inventory_item_id
  AND esiv.organization_id = esib.organization_id
  JOIN egp_categories_tl ectl ON ectl.category_id = eic.category_id
  AND ectl.language = 'PTB'
  JOIN inv_org_parameters iop ON iop.organization_id = esib.organization_id
  JOIN egp_category_sets_tl eict ON eict.category_set_id = eic.category_set_id
  AND eict.language = 'PTB'
  JOIN egp_item_classes_b class ON esib.item_catalog_group_id = class.item_class_id
  JOIN egp_item_classes_tl class_tl ON class.item_class_id = class_tl.item_class_id
  AND class_tl.language = 'PTB'
WHERE
  eict.category_set_name LIKE '%LACLS_NCM_SERVICE_CODE%'
  and iop.organization_code = 'ITEM_ORG_MESTRE'
ORDER BY
  esib.item_number
      
  ;
  
-- CONTAGEM TOTAL DE ITENS RETORNADOS PELA CONSULTA
SELECT COUNT(*) AS TOTAL_ITENS
FROM (
  SELECT
    class_tl.description AS ITEM_CLASS_DESCRIPTION,
    iop.organization_code AS ORGANIZATION_CODE,
    esib.item_number AS ITEM_NUMBER,
    esiv.description AS DESCRICAO_ITEM,
    eict.category_set_name AS NCM,
    ectl.category_name AS CATEGORY_NAME,
    ectl.description AS CATEGORY_DESCRIPTION
  FROM
    egp_item_categories eic
    JOIN egp_system_items_b esib
      ON esib.inventory_item_id = eic.inventory_item_id
     AND esib.organization_id = eic.organization_id
    JOIN egp_system_items_vl esiv
      ON esiv.inventory_item_id = esib.inventory_item_id
     AND esiv.organization_id = esib.organization_id
    JOIN egp_categories_tl ectl
      ON ectl.category_id = eic.category_id
     AND ectl.language = 'PTB'
    JOIN inv_org_parameters iop
      ON iop.organization_id = esib.organization_id
    JOIN egp_category_sets_tl eict
      ON eict.category_set_id = eic.category_set_id
     AND eict.language = 'PTB'
    JOIN egp_item_classes_b class
      ON esib.item_catalog_group_id = class.item_class_id
    JOIN egp_item_classes_tl class_tl
      ON class.item_class_id = class_tl.item_class_id
     AND class_tl.language = 'PTB'
  WHERE
    eict.category_set_name LIKE '%LACLS_NCM_SERVICE_CODE%'  
    AND iop.organization_code = 'ITEM_ORG_MESTRE'
)    

;



