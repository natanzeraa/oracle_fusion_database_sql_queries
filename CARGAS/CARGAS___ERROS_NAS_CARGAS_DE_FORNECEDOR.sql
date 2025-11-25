select
  count(*) over() as total,
  psir.rejection_id,
  psir.parent_table,
  psir.parent_id,
  psir.value,
  psir.reject_lookup_code,
  psir.app_name,
  psir.attribute,
  --  psir.object_version_number,
  --  psir.request_id,
  --  psir.job_definition_name,
  --  psir.job_definition_package,
  psir.last_updated_by,
  to_char(from_tz(cast(psir.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as last_update_date,
  psir.created_by,
  to_char(from_tz(cast(psir.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as creation_date
from
  poz_supplier_int_rejections psir
where
  1 = 1
  and trunc(from_tz(cast(psir.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('24/11/2025', 'dd/mm/yyyy') and to_date('30/11/2025', 'dd/mm/yyyy')
order by
  psir.creation_date desc



