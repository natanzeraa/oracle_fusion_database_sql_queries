SELECT
  hp.party_name cnpj,
  --
  ZPTI.TAX_PAYER_NUMBER id_conttibuinte,
  ZPTI.REPORTING_TYPE_CODE tipo_de_validacao,
  --
  HCA.account_number numero_da_conta,
  ZFT.classification_type_code classificacao_fiscal,
  ps.VENDOR_TYPE_LOOKUP_CODE,
  --
  hl.address1 || nvl2(hl.address2, ', ' || hl.address2, '') || nvl2(hl.address3, ', ' || hl.address3, '') endereco,
  hl.city cidade,
  hl.postal_code cep,
  hl.state estado,
  hl.country pais
FROM
  HZ_PARTY_SITES HPS,
  HZ_CUST_ACCT_SITES_ALL HCASA,
  HZ_CUST_ACCOUNTS HCA,
  --
  ZX_PARTY_TAX_PROFILE ZPTP,
  ZX_PARTY_TAXPAYER_IDNTFS ZPTI,
  --
  hz_code_assignments HCAX,
  hz_class_category_uses hccd,
  zx_fc_types_b ZFT,
  --
  HZ_LOCATIONS HL,
  POZ_SUPPLIERS PS,
 
  HZ_PARTIES HP
WHERE
  1 = 1
  AND ZPTP.PARTY_TYPE_CODE = 'THIRD_PARTY_SITE'
  AND ZPTP.SITE_FLAG = 'Y'
  AND TRUNC (SYSDATE) BETWEEN NVL (ZPTI.EFFECTIVE_FROM, TRUNC (SYSDATE) - 1)
  AND NVL (ZPTI.EFFECTIVE_TO, TRUNC (SYSDATE + 1))
  AND HCASA.PARTY_SITE_ID = HPS.PARTY_SITE_ID
  AND HCA.CUST_ACCOUNT_ID = HCASA.CUST_ACCOUNT_ID
  AND PS.PARTY_ID = HP.PARTY_ID                          
  AND hp.party_id = hca.party_id
  AND ZPTI.REPORTING_TYPE_CODE in ('ORA_BR_CNPJ', 'ORA_BR_CPF') 
  --
  AND ZPTP.PARTY_TAX_PROFILE_ID = ZPTI.ENTITY_ID
  AND HPS.PARTY_SITE_ID = ZPTP.PARTY_ID 
  --
  AND HCAX.owner_table_id = ZPTP.party_tax_profile_id
  and HCAX.class_category = hccd.class_category
  and HCAX.class_category = ZFT.owner_id_char 
  --
  AND HL.LOCATION_ID = HPS.LOCATION_ID

                      
