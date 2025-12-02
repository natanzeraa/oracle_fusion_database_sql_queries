select
  class_tl.description as classe_do_item,
  iop.organization_code as organizacao,
  /*case
    when esib.inventory_item_status_code = 'active' then 'ativo'
    else 'inativo'
  end as status_de_inventario,*/
  /*case
    when esib.approval_status = 'a' then 'aprovado'
    else 'reprovado'
  end as status_aprovacao,*/
  esib.item_number as codigo_do_item,
  esiv.description as descricao_do_item,
  case
    when esiv.planning_make_buy_code = '1' then 'FABRICADO'
    when esiv.planning_make_buy_code = '2' then 'COMPRA'
    else 'SEM VALOR'
  end as compra_ou_fabricado,
  esib.last_updated_by as quem_atualizou,
  to_char(
    from_tz(cast(esib.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as atualizado_em,
  esib.created_by as quem_criou,
  to_char(
    from_tz(cast(esib.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo',
    'dd/mm/yyyy hh24:mi:ss'
  ) as criado_em
from
  egp_system_items_b esib
  join egp_system_items_vl esiv on esiv.inventory_item_id = esib.inventory_item_id
  and esiv.organization_id = esib.organization_id
  join inv_org_parameters iop on iop.organization_id = esib.organization_id
  join egp_item_classes_b class on esib.item_catalog_group_id = class.item_class_id
  join egp_item_classes_tl class_tl on class.item_class_id = class_tl.item_class_id
  and class_tl.language = 'PTB'
where
  1 = 1
  -- and esib.approval_status = 'A' 
  and class_tl.description = 'USO E CONSUMO'
  -- and esiv.planning_make_buy_code = '2'
  -- and esib.inventory_item_status_code = 'INACTIVE'
  -- and esiv.description like '%bag vacina%'
  -- and esib.last_updated_by like '%@ninecon%'  
order by
  esib.item_number


