SELECT
  esib.last_updated_by AS EMAIL,
  COUNT(*) AS TOTAL_ATUALIZADOS
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
  esib.approval_status = 'A'
--  AND esib.last_updated_by LIKE '%@ninecon%'
GROUP BY
  esib.last_updated_by
ORDER BY
  TOTAL_ATUALIZADOS DESC
