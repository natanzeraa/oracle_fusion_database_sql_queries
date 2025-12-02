select
  item_class_id,
  item_class_code,
  nir_reqd,
  attribute5,
  enabled_flag
from
  egp_item_classes_b
where
  attribute5 = 'Y'
  and enabled_flag = 'Y'
