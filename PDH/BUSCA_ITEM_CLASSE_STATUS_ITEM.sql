-- BUSCA ITEM CATEGORIA CLASSE E FORNECEDOR COM STATUS (ATIVO ou INATIVO)
SELECT
  class_tl.description AS CLASSE_DO_ITEM,
  iop.organization_code AS ORGANIZACAO,
  case
    when esib.inventory_item_status_code = 'Active' then 'ATIVO'
    else 'INATIVO'
  end as STATUS_DE_INVENTARIO,
  case
    when esib.approval_status = 'A' then 'APROVADO'
    else 'REPROVADO'
  end as STATUS_APROVACAO,
  esib.item_number AS CODIGO_DO_ITEM,
  esiv.description AS DESCRICAO_DO_ITEM,
  esib.last_updated_by as QUEM_ATUALIZOU,
  to_char(
    from_tz(cast(esib.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as ATUALIZADO_EM,
  esib.created_by as QUEM_CRIOU,
  to_char(
    from_tz(cast(esib.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as CRIADO_EM
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
  and esib.approval_status = 'A' 
  -- and esib.inventory_item_status_code = 'Inactive'
  -- and esiv.description like '%BAG VACINA%'
  and esib.last_updated_by like '%@ninecon%'  
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


-- BUSCA ITEM CATEGORIA CLASSE E FORNECEDOR COM STATUS (ATIVO ou INATIVO)

SELECT  
  iop.organization_code AS ORGANIZACAO,
  esib.item_number AS CODIGO_DO_ITEM,
  esiv.description AS DESCRICAO_DO_ITEM,
  class_tl.description AS CLASSE_DO_ITEM,
  case
    when esib.inventory_item_status_code = 'Active' then 'ATIVO'
    else 'INATIVO'
  end as STATUS    
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
  --and esib.inventory_item_status_code = 'Active'
  and esib.item_number = '05072839'
  -- and esiv.description like '%BAG VACINA%'
ORDER BY
  esib.item_number




  

