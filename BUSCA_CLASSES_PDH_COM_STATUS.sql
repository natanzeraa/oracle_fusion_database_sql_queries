-- 
select
  eicb.ITEM_CLASS_TYPE as TIPO_DA_CLASSE,
  eicb.ITEM_CLASS_CODE as NOME_DA_CLASSE,
  case
    when eicb.ENABLED_FLAG = 'Y' then 'ATIVA'
    else 'INATIVA'
  end as STATUS_DA_CLASSE
from
  egp_item_classes_b eicb
;
