/*---------------------------------------------------------------------------------------------------------------------------------------
| BUSCA ITEM, CLASSE E STATUS + CONTAGEM DE ITENS INATIVADOS (ONTEM, POR <usuario@dominio.com>)
|
| OBJETIVO:
|   Exibir os itens com seus dados principais e incluir, em cada linha, o total de itens inativados
|   em 06/11/2025 pelo usuário "leonardo.gomes@plumaagro.com.br".
|
| FONTES DE DADOS:
|   - EGP_SYSTEM_ITEMS_B  -> Status e auditoria
|   - EGP_SYSTEM_ITEMS_VL -> Descrição textual
|   - INV_ORG_PARAMETERS  -> Organização
|   - EGP_ITEM_CLASSES_TL -> Classe do item (PTB)
----------------------------------------------------------------------------------------------------------------------------------------*/

SELECT
  (
    -- Subquery: total de itens inativados ontem pelo Leonardo
    SELECT
      COUNT(*) 
    FROM
      egp_system_items_b esib2
      JOIN inv_org_parameters iop2 
        ON iop2.organization_id = esib2.organization_id
      JOIN egp_system_items_vl esiv2 
        ON esiv2.inventory_item_id = esib2.inventory_item_id
        AND esiv2.organization_id = esib2.organization_id
      JOIN egp_item_classes_tl class_tl2 
        ON esib2.item_catalog_group_id = class_tl2.item_class_id
        AND class_tl2.language = 'PTB'
    WHERE
      esib2.inventory_item_status_code = 'Inactive'
      AND LOWER(esib2.last_updated_by) = 'leonardo.gomes@plumaagro.com.br' -- EMAIL DO USUARIO AQUI
      AND (
        FROM_TZ(CAST(esib2.last_update_date AS TIMESTAMP), 'UTC') 
        AT TIME ZONE 'America/Sao_Paulo'
      ) BETWEEN TO_TIMESTAMP('06/11/2025 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
        AND TO_TIMESTAMP('06/11/2025 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
  ) AS TOTAL_INATIVADOS,
  
  class_tl.description AS CLASSE_DO_ITEM,
  iop.organization_code AS ORGANIZACAO,
  CASE
    WHEN esib.inventory_item_status_code = 'Active' THEN 'ATIVO'
    ELSE 'INATIVO'
  END AS STATUS_DE_INVENTARIO,
  CASE
    WHEN esib.approval_status = 'A' THEN 'APROVADO'
    ELSE 'REPROVADO'
  END AS STATUS_APROVACAO,
  esib.item_number AS CODIGO_DO_ITEM,
  esiv.description AS DESCRICAO_DO_ITEM,
  esib.last_updated_by AS QUEM_ATUALIZOU,
  TO_CHAR(
    FROM_TZ(CAST(esib.last_update_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS ATUALIZADO_EM,
  esib.created_by AS QUEM_CRIOU,
  TO_CHAR(
    FROM_TZ(CAST(esib.creation_date AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Sao_Paulo',
    'DD/MM/YYYY HH24:MI:SS'
  ) AS CRIADO_EM

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

ORDER BY
  esib.inventory_item_status_code DESC
;
