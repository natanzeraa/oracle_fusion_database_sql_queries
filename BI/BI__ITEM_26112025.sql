select count(*) over() 		as total
  ,esib.item_number 		as codigo_do_item
  ,esiv.description 		as descricao_do_item
  ,esib.unit_of_issue 		as unidade_de_medida
  ,class_tl.description 	as classe_do_item
  ,iop.organization_code 	as organizacao
  ,eict.category_set_name 	as tipo_categoria
  ,ectl.category_name 		as nome_categoria
  
  ,case
    when esib.inventory_item_status_code = 'Active' then upper('ativo')
    else upper('inativo')
  end as status_de_inventario
  
  ,esib.created_by 		as quem_criou
  ,to_char(from_tz(cast(esib.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as criado_em
  
  ,esib.last_updated_by 	as quem_atualizou
  ,to_char(from_tz(cast(esib.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as atualizado_em
from
  egp_system_items_b esib
  
  left join egp_system_items_vl esiv 		on esiv.inventory_item_id = esib.inventory_item_id and esiv.organization_id = esib.organization_id
  left join inv_org_parameters iop 		on iop.organization_id = esib.organization_id
  left join egp_item_classes_b class 		on class.item_class_id = esib.item_catalog_group_id
  left join egp_item_classes_tl class_tl 	on class_tl.item_class_id = class.item_class_id and class_tl.language = 'PTB'
  left join egp_item_categories eic 		on eic.inventory_item_id = esib.inventory_item_id and eic.organization_id   = esib.organization_id
  left join egp_category_sets_tl eict 		on eict.category_set_id = eic.category_set_id and eict.language = 'PTB'
  left join egp_categories_tl ectl 		on ectl.category_id = eic.category_id and ectl.language = 'PTB'
where
  1 = 1
  and esib.inventory_item_status_code = 'Active'
  and eict.category_set_name in (
  	'Compras',
  	'Custos',
  	'INVENTARIO',
  	'LACLS_NCM_SERVICE_CODE',
  	'LACLS_BR_CEST_CODE',
  	'PLU_TAX_PRODUTIVO_IMPRODUTIVO',
  	'PLU_UNID_PRODUZIDA_E_CONVENIO',
  	'LACLS_BR_ITEM_ORIGIN',
  	'LACLS_BR_ITEM_TYPE'
  	-- 'LACLS_SERVICE_CODE',
  )
  -- and eict.category_set_name = 'Compras'
  -- and eict.category_set_name = 'Custos'
  -- and eict.category_set_name = 'INVENTARIO'  
  -- and eict.category_set_name = 'LACLS_NCM_SERVICE_CODE'
  -- and eict.category_set_name = 'LACLS_BR_CEST_CODE'
  -- and eict.category_set_name = 'PLU_TAX_PRODUTIVO_IMPRODUTIVO'
  -- and eict.category_set_name = 'LACLS_SERVICE_CODE' -- nao encontrado
  -- and eict.category_set_name = 'PLU_UNID_PRODUZIDA_E_CONVENIO'
  -- and eict.category_set_name = 'LACLS_BR_ITEM_ORIGIN'
  -- and eict.category_set_name = 'LACLS_BR_ITEM_TYPE'
order by
  class_tl.description asc  
                                                                              
