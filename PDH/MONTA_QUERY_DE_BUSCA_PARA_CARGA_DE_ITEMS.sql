/*---------------------------------------------------------------------------------------------------------------------------------------
| CONSULTA BASE — CAMPOS ESSENCIAIS PARA CARGA DE ITENS NO ORACLE PRODUCT DATA HUB (PDH)
|
| OBJETIVO:
|   Esta query retorna as principais informacoes de um item necessario para criacao ou conferencia
|   de cargas via API ou integracao, trazendo:
|     - Codigo da organizacao
|     - Classe do item
|     - Numero do item (com prefixo TEMPLATE)
|     - Descricao do item
|     - Status de aprovacao
|     - Status de item (ativo/inativo)
|
| FONTES PRINCIPAIS:
|   - EGP_SYSTEM_ITEMS_B  -> Dados basicos do item (ID, numero, status, aprovacao, etc.)
|   - EGP_SYSTEM_ITEMS_TL -> Descricao multilingue do item (campo DESCRIPTION)
|   - INV_ORG_PARAMETERS  -> Codigo da organizacao (ORGANIZATION_CODE)
|   - EGP_ITEM_CLASSES_B/TL -> Nome descritivo da classe do item
|   - EGP_ITEM_STATUS_TL -> Traducao do status do item ("Active", "Inactive", etc.)
|
| OBSERVACOES:
|   - Campos multilingues (TL) usam LANGUAGE = 'PTB' para portugues.
|   - NVL() e usado para garantir retorno mesmo que nao exista traducao na TL.
----------------------------------------------------------------------------------------------------------------------------------------*/

SELECT
  org.organization_code AS "OrganizationCode",
  ic_tl.item_class_name AS "ItemClass",
  'TEMPLATE:' || i.item_number AS "ItemNumber",
  it.description AS "ItemDescription",
  i.approval_status AS "ApprovalStatusValue",
  NVL(st.description, i.inventory_item_status_code) AS "ItemStatusValue"
FROM
  egp_system_items_b i
  JOIN inv_org_parameters org ON org.organization_id = i.organization_id
  LEFT JOIN egp_item_classes_b ic ON ic.item_class_id = i.item_catalog_group_id
  LEFT JOIN egp_item_classes_tl ic_tl ON ic_tl.item_class_id = ic.item_class_id
  AND ic_tl.language = 'PTB'
  JOIN egp_system_items_tl it ON it.inventory_item_id = i.inventory_item_id
  AND it.organization_id = i.organization_id
  AND it.language = 'PTB'
  LEFT JOIN egp_item_status_tl st ON st.inventory_item_status_code = i.inventory_item_status_code
  AND st.language = 'PTB'
WHERE
  1 = 1 
    
;
 
