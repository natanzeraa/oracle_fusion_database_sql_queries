-- BUSCA
-- CLASSE DO ITEM
-- ITEM_ORG_MESTRE
-- CODIGO DO ITEM
-- DESCRICAO DO ITEM

SELECT
  class_tl.description AS CLASSE_DO_ITEM,
  iop.organization_code AS ORGANIZATION,
  esib.item_number AS CODIGO_DO_ITEM,
  esiv.description AS DESCRICAO_DO_ITEM,
  count(*) over() as TOTAL  
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
  table_name = 'egp_system_items_b'
 --   and nullable = 'N'
ORDER BY
  column_name
;
SELECT
  class_tl.description AS CLASSE_DO_ITEM,
  iop.organization_code AS ORGANIZATION,
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
WHERE
  1 = 1
  and iop.organization_code = 'ITEM_ORG_MESTRE'
  and esib.item_number IN (
    '00301192',
    '00301581',
    '00301719',
    '00301727',
    '00301743',
    '00301751',
    '00301792',
    '00301857',
    '00301898',
    '00301921',
    '00301954',
    '00301995',
    '00302018',
    '00302026',
    '00302034',
    '00302059',
    '00302067',
    '00302107',
    '00302204',
    '00302237',
    '00302253',
    '00302278',
    '00302286',
    '00302301',
    '00312208',
    '00312216',
    '00317993',
    '00318008',
    '00331998',
    '00332012',
    '00332029',
    '00594681',
    '00596293',
    '00596325',
    '00596333',
    '00596341',
    '00596358',
    '00596374',
    '00625825',
    '00626027',
    '00738212',
    '00754429',
    '00774663',
    '00774671',
    '00885406',
    '00885414',
    '00934962',
    '00934979',
    '00934987',
    '00935001',
    '00935067',
    '00960606',
    '00987264',
    '01042886',
    '01056445',
    '01098266',
    '00109206',
    '00109214',
    '00294446',
    '00305397',
    '00305412',
    '01111476',
    '01111484',
    '01111492',
    '00293993',
    '00301054',
    '00301062'
  )
ORDER BY
  esib.item_number
  
