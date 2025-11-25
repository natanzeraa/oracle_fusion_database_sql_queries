select
    count(*) over() as total,

    -- identificadores do processo
    iteba.load_request_id,
    itepa.feeder_import_batch_id,
    itepa.temp_ext_payee_id,

    -- identificador da conta
    iteba.temp_ext_bank_acct_id as payee_bank_account_identifier,

    -- dados bancarios
    iteba.bank_name,
    iteba.branch_name,
    iteba.country_code as account_country_code,
    iteba.bank_account_name as account_name,
    iteba.bank_account_num as account_number,
    iteba.currency_code as account_currency_code,
    iteba.foreign_payment_use_flag as allow_international_payments,

    -- datas
    to_char(from_tz(cast(iteba.start_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as account_start_date,
    to_char(from_tz(cast(iteba.end_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as account_end_date,

    -- iban e detalhes
    -- iteba.iban,
    iteba.check_digits,
    -- iteba.bank_account_name_alt as account_alternate_name,
    iteba.bank_account_type as account_type_code,
    -- iteba.account_suffix,
    -- iteba.description as account_description,
    -- iteba.agency_location_code,

    -- acordos de cambio
    -- iteba.exchange_rate_agreement_num as exchange_rate_agreement_number,
    -- iteba.exchange_rate_agreement_type as exchange_rate_agreement_type,
    -- iteba.exchange_rate,

    -- referÃªncia secundaria
    -- iteba.secondary_account_reference as secondary_account_reference,

    -- metadados
    iteba.status,
    iteba.created_by,
    to_char(from_tz(cast(iteba.creation_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as creation_date, iteba.last_updated_by,
    to_char(from_tz(cast(iteba.last_update_date as timestamp), 'utc') at time zone 'america/sao_paulo', 'dd/mm/yyyy hh24:mi:ss') as last_update_date
from 
  iby_temp_ext_bank_accts iteba
  left join iby_temp_ext_payees itepa on itepa.feeder_import_batch_id = iteba.feeder_import_batch_id
where 1 = 1
  -- and iteba.load_request_id = '3606370'
  and trunc(from_tz(cast(iteba.creation_date as timestamp), 'utc')at time zone 'america/sao_paulo') between to_date('19/11/2025', 'dd/mm/yyyy') and to_date('20/11/2025', 'dd/mm/yyyy')
  -- and iteba.ext_bank_account_id is not null  
order by iteba.creation_date desc


