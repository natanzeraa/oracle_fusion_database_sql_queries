/*---------------------------------------------------------------------------------------------------------------------------------------
| CONSULTA BASE — CAMPOS ESSENCIAIS PARA CARGA DE ITENS NO ORACLE PRODUCT DATA HUB (PDH)
|
| OBJETIVO:
|   Esta query retorna as principais informações de um item necessário para criação ou conferência
|   de cargas via API ou integração, trazendo:
|     - Código da organização
|     - Classe do item
|     - Número do item (com prefixo TEMPLATE)
|     - Descrição do item
|     - Status de aprovação
|     - Status de item (ativo/inativo)
|
| FONTES PRINCIPAIS:
|   - EGP_SYSTEM_ITEMS_B  → Dados básicos do item (ID, número, status, aprovação, etc.)
|   - EGP_SYSTEM_ITEMS_TL → Descrição multilíngue do item (campo DESCRIPTION)
|   - INV_ORG_PARAMETERS  → Código da organização (ORGANIZATION_CODE)
|   - EGP_ITEM_CLASSES_B/TL → Nome descritivo da classe do item
|   - EGP_ITEM_STATUS_TL → Tradução do status do item (“Active”, “Inactive”, etc.)
|
| OBSERVAÇÕES:
|   - Campos multilíngues (TL) usam LANGUAGE = 'PTB' para português.
|   - NVL() é usado para garantir retorno mesmo que não exista tradução na TL.
----------------------------------------------------------------------------------------------------------------------------------------*/

SELECT
  /* Código da organização — chave de referência do item */
  org.organization_code AS "OrganizationCode",

  /* Nome da classe de item (ex: INSUMO INDUSTRIAL FFO) */
  ic_tl.item_class_name AS "ItemClass",

  /* Número do item com prefixo TEMPLATE para cargas de teste */
  'TEMPLATE:' || i.item_number AS "ItemNumber",

  /* Descrição multilíngue do item (definida em EGP_SYSTEM_ITEMS_TL) */
  it.description AS "ItemDescription",

  /* Status de aprovação do item (ex: Approved, Pending, Rejected) */
  i.approval_status AS "ApprovalStatusValue",

  /* Status operacional do item (ex: Active, Inactive) — obtido da tradução ou do código base */
  NVL(st.description, i.inventory_item_status_code) AS "ItemStatusValue"

FROM
  /* Tabela base de itens (contém informações de status, tipo, UOM, etc.) */
  egp_system_items_b i

  /* Parâmetros da organização — retorna o código visível da organização */
  JOIN inv_org_parameters org
    ON org.organization_id = i.organization_id

  /* Classe de item — relacionamento hierárquico e nome descritivo */
  LEFT JOIN egp_item_classes_b ic
    ON ic.item_class_id = i.item_catalog_group_id

  /* Tradução do nome da classe (PTB = Português) */
  LEFT JOIN egp_item_classes_tl ic_tl
    ON ic_tl.item_class_id = ic.item_class_id
   AND ic_tl.language = 'PTB'

  /* Descrição multilíngue do item (PTB = Português) */
  JOIN egp_system_items_tl it
    ON it.inventory_item_id = i.inventory_item_id
   AND it.organization_id = i.organization_id
   AND it.language = 'PTB'

  /* Status traduzido do item (Active, Inactive, Obsolete, etc.) */
  LEFT JOIN egp_item_status_tl st
    ON st.inventory_item_status_code = i.inventory_item_status_code
   AND st.language = 'PTB'

WHERE
  1 = 1
  -- Filtros opcionais (descomente conforme necessário):
  -- AND i.organization_id = 300000014565305
  -- AND i.item_number = '300000059474856'  
;


