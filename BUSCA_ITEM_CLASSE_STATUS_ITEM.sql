-- BUSCA ITEM CATEGORIA CLASSE E FORNECEDOR COM STATUS (ATIVO ou INATIVO)
SELECT
class_tl.description AS CLASSE_DO_ITEM,
iop.organization_code AS ORGANIZACAO,
esib.inventory_item_status_code AS STATUS_DO_ITEM,
esib.item_number AS CODIGO_DO_ITEM,
esiv.description AS DESCRICAO_DO_ITEM
FROM
  egp_system_items_b esib
  JOIN egp_system_items_vl esiv ON esiv.inventory_item_id = esib.inventory_item_id
  AND esiv.organization_id = esib.organization_id
  JOIN inv_org_parameters iop ON iop.organization_id = esib.organization_id
  JOIN egp_item_classes_b class ON esib.item_catalog_group_id = class.item_class_id
  JOIN egp_item_classes_tl class_tl ON class.item_class_id = class_tl.item_class_id
  AND class_tl.language = 'PTB'
where
  1 = 1
--  and esib.inventory_item_status_code = 'Inactive'
ORDER BY
  esib.item_number
;
  
 
-- CONTAGEM
select
  count(*) as total
from
  (
    SELECT
      class_tl.description AS CLASSE_DO_ITEM,
      iop.organization_code AS ORGANIZACAO,
      esib.inventory_item_status_code AS STATUS_DO_ITEM,
      esib.item_number AS CODIGO_DO_ITEM,
      esiv.description AS DESCRICAO_DO_ITEM
    FROM
      egp_system_items_b esib
      JOIN egp_system_items_vl esiv ON esiv.inventory_item_id = esib.inventory_item_id
      AND esiv.organization_id = esib.organization_id
      JOIN inv_org_parameters iop ON iop.organization_id = esib.organization_id
      JOIN egp_item_classes_b class ON esib.item_catalog_group_id = class.item_class_id
      JOIN egp_item_classes_tl class_tl ON class.item_class_id = class_tl.item_class_id
      AND class_tl.language = 'PTB'
    ORDER BY
      esib.item_number
  )
  
;
