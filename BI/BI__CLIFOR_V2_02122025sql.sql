select
  hp.party_name								razao_social,
  zpti.tax_payer_number							cpf_cnpj,
  ps.vendor_type_lookup_code 					        tipo_clifor,
  hca.customer_type							tipo_cliente,
  zpti.reporting_type_code						tipo_de_validacao,
  hca.account_number							numero_da_conta,
  zft.classification_type_code						tipo_classificacao_fiscal,
  hcax.class_code 							cod_classificacao_fiscal,
  hl.address1 || 
  nvl2(hl.address2, ', ' || hl.address2, '') || 
  nvl2(hl.address3, ', ' || hl.address3, '') 	                    	endereco,
  hl.city 								cidade,
  hl.postal_code 							cep,
  hl.state 								estado,
  hl.country 								pais
from
  hz_party_sites 							hps,
  hz_cust_acct_sites_all 						hcasa,
  hz_cust_accounts 							hca,
  hz_locations 								hl,
  --
  zx_party_tax_profile 							zptp,
  zx_party_taxpayer_idntfs 						zpti,
  --
  hz_code_assignments 							hcax,
  hz_class_category_uses 						hccd,
  zx_fc_types_b 							zft,
  poz_suppliers 							ps,
  --
  hz_parties 								hp
where
  1 = 1
  and zptp.party_type_code 						= 'THIRD_PARTY_SITE'
  and zptp.site_flag 						= 'Y'
  and trunc (sysdate) between 
  nvl (zpti.effective_from, trunc (sysdate) - 1)
  and nvl (zpti.effective_to, trunc (sysdate + 1))
  and hcasa.party_site_id 						= hps.party_site_id
  and hca.cust_account_id 						= hcasa.cust_account_id
  and hp.party_id 							= hca.party_id
  --
  and zptp.party_tax_profile_id 					= zpti.entity_id
  and hps.party_site_id 						= zptp.party_id 
  --
  and hcax.owner_table_id 						= zptp.party_tax_profile_id
  and hcax.class_category 						= hccd.class_category
  and hcax.class_category 						= zft.owner_id_char
  and hl.location_id 							= hps.location_id   
  and ps.party_id 							= hp.party_id        
  and hcax.end_date_active						<= trunc(sysdate) 
  -- and zft.end_date_active 						is null
  -- and hp.party_name 							like '%MUNICIPIO%'        
  --
  and hcax.class_category 						= zft.owner_id_char
  and owner_table_name 							= 'ZX_PARTY_TAX_PROFILE'
  and classification_type_categ_code 					= 'PARTY_FISCAL_CLASS'
  and zptp.party_tax_profile_id 					= hcax.owner_table_id
  and zptp.party_id 							= hps.party_site_id
  -- and ps.vendor_type_lookup_code 					= 'SUPPLIER'
  -- and hca.customer_type not 						like '%R%' 
order by 
  hp.party_name	asc 
