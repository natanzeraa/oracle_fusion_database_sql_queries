WITH categorias_filtradas AS (
    SELECT 
        eic.inventory_item_id,
        eic.organization_id,
        eic.category_id,
        eic.category_set_id
    FROM 
        egp_item_categories eic
        JOIN egp_category_sets_tl eict 
            ON eict.category_set_id = eic.category_set_id
           AND eict.language = 'PTB'
           AND eict.category_set_name IN (
               'Compras',
               'Custos',
               'INVENTARIO',
               'LACLS_NCM_SERVICE_CODE',
               'LACLS_BR_CEST_CODE',
               'PLU_TAX_PRODUTIVO_IMPRODUTIVO',
               'PLU_UNID_PRODUZIDA_E_CONVENIO',
               'LACLS_BR_ITEM_ORIGIN',
               'LACLS_BR_ITEM_TYPE'
           )
)
SELECT 
    -- COUNT(*) OVER()                                  AS total,
    esib.item_number                                 AS codigo_do_item,
    esiv.description                                 AS descricao_do_item,
    esib.primary_uom_code 		             AS unidade_de_medida,
    class_tl.description                             AS classe_do_item,
    iop.organization_code                            AS organizacao,
    eict.category_set_name                           AS tipo_categoria,
    ectl.category_name                               AS nome_categoria

    /*CASE
        WHEN esib.inventory_item_status_code = 'Active' THEN 'ATIVO'
        ELSE 'INATIVO']
    END                                              AS status_de_inventario,

    esib.created_by                                  AS quem_criou,
    to_char(from_tz(cast(esib.creation_date as timestamp),'utc') 
        at time zone 'america/sao_paulo','dd/mm/yyyy hh24:mi:ss') AS criado_em,

    esib.last_updated_by                              AS quem_atualizou,
    to_char(from_tz(cast(esib.last_update_date as timestamp),'utc') 
        at time zone 'america/sao_paulo','dd/mm/yyyy hh24:mi:ss') AS atualizado_em*/

FROM 
    egp_system_items_b esib

    /* Catálogo de descrição */
    INNER JOIN egp_system_items_vl esiv 
        ON esiv.inventory_item_id = esib.inventory_item_id
       AND esiv.organization_id   = esib.organization_id

    /* Organização */
    INNER JOIN inv_org_parameters iop
        ON iop.organization_id = esib.organization_id

    /* Classe do item */
    INNER JOIN egp_item_classes_b class
        ON class.item_class_id = esib.item_catalog_group_id

    INNER JOIN egp_item_classes_tl class_tl
        ON class_tl.item_class_id = class.item_class_id
       AND class_tl.language      = 'PTB'

    INNER JOIN categorias_filtradas cf
        ON cf.inventory_item_id = esib.inventory_item_id
       AND cf.organization_id   = esib.organization_id

    INNER JOIN egp_category_sets_tl eict
        ON eict.category_set_id = cf.category_set_id
       AND eict.language        = 'PTB'

    INNER JOIN egp_categories_tl ectl
        ON ectl.category_id = cf.category_id
       AND ectl.language    = 'PTB'

WHERE 
    1 = 1
    and esib.inventory_item_status_code = 'Active'

ORDER BY
    eict.category_set_name ASC
