-- BUSCA
-- CLASSE DO ITEM
-- ITEM_ORG_MESTRE
-- CODIGO DO ITEM
-- DESCRIÇÃO DO ITEM

SELECT
  class_tl.description AS CLASSE_DO_ITEM,
  iop.organization_code AS ORGANIZATION,
  esib.item_number AS CODIGO_DO_ITEM,
  esiv.description AS DESCRICAO_DO_ITEM
FROM
  egp_system_items_b esib
  JOIN egp_system_items_vl esiv 
    ON esiv.inventory_item_id = esib.inventory_item_id
    AND esiv.organization_id = esib.organization_id
  JOIN inv_org_parameters iop 
    ON iop.organization_id = esib.organization_id
  JOIN egp_item_classes_b class 
    ON esib.item_catalog_group_id = class.item_class_id
  JOIN egp_item_classes_tl class_tl 
    ON class.item_class_id = class_tl.item_class_id
    AND class_tl.language = 'PTB'
WHERE
  iop.organization_code = 'ITEM_ORG_MESTRE'
ORDER BY
  esib.item_number
      
  ;
  
-- CONTAGEM TOTAL DE ITENS RETORNADOS PELA CONSULTA
SELECT COUNT(*) AS TOTAL_ITENS
FROM ( 

SELECT
  class_tl.description AS CLASSE_DO_ITEM,
  iop.organization_code AS ORGANIZATION,
  esib.item_number AS CODIGO_DO_ITEM,
  esiv.description AS DESCRICAO_DO_ITEM
FROM
  egp_system_items_b esib
  JOIN egp_system_items_vl esiv 
    ON esiv.inventory_item_id = esib.inventory_item_id
    AND esiv.organization_id = esib.organization_id
  JOIN inv_org_parameters iop 
    ON iop.organization_id = esib.organization_id
  JOIN egp_item_classes_b class 
    ON esib.item_catalog_group_id = class.item_class_id
  JOIN egp_item_classes_tl class_tl 
    ON class.item_class_id = class_tl.item_class_id
    AND class_tl.language = 'PTB'
WHERE
  iop.organization_code = 'ITEM_ORG_MESTRE'
ORDER BY
  esib.item_number
)    

;



