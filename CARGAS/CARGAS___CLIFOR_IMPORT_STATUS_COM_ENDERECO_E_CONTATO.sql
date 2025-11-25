select
    count(*) over() as total,
    pscai.contact_address_interface_id,
    pscai.batch_id,
    pscai.vendor_interface_id,
    pscai.vendor_id,
    pscai.vendor_name,
    pscai.contact_interface_id,
    pscai.address_interface_id,
    pscai.per_party_id,
    pscai.import_action,
    pscai.import_status,
    pscai.first_name,
    pscai.last_name,
    pscai.email_address,
    pscai.party_site_id,
    pscai.party_site_name,
    pscai.last_updated_by,
    to_char(from_tz(cast(pscai.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as last_update_date,
    pscai.created_by,
    to_char(from_tz(cast(pscai.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as creation_date,
    pscai.load_request_id,
    pscai.request_id
from
    poz_sup_contact_addresses_int pscai
where
    1 = 1
    and trunc(from_tz(cast(pscai.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo') between to_date('24/11/2025', 'dd/mm/yyyy') and to_date('24/11/2025', 'dd/mm/yyyy')
    and.
order by
    pscai.creation_date desc


