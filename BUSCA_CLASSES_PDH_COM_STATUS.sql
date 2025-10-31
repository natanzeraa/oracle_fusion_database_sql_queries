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


select
  msp.SUPPLIER_NAME,
  msp.CREATED_BY,
  msp.CREATION_DATE,
  msp.LAST_UPDATED_BY,
  msp.LAST_UPDATE_DATE
from
  mss_supplies msp

;

SELECT 
  ps.creation_source,
  ps.vendor_type_lookup_code,
  ps.CREATED_BY,
  ps.CREATION_DATE,
  ps.LAST_UPDATED_BY,
  ps.LAST_UPDATE_DATE
FROM poz_suppliers ps

;

