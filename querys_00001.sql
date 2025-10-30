-- | Alias     | Tabela                 | Significado                                      | Função                                                                                             |
-- | --------- | ---------------------- | ------------------------------------------------ | -------------------------------------------------------------------------------------------------- |
-- | **esib**  | `EGP_SYSTEM_ITEMS_B`   | *E-Business Global Product System Items (Base)*  | Tabela **base** (B) de itens mestres — contém dados técnicos e administrativos do item.            |
-- | **esiv**  | `EGP_SYSTEM_ITEMS_VL`  | *View Layer (Language)*                          | Versão multilíngue da tabela de itens (descritivos). Guarda a **descrição legível** do item.       |
-- | **eic**   | `EGP_ITEM_CATEGORIES`  | *Item–Category Link Table*                       | Faz o vínculo entre o item e suas **categorias** (ex: Compras, Inventário, Contabilidade).         |
-- | **ectl**  | `EGP_CATEGORIES_TL`    | *Category Translations (TL = Translation Layer)* | Tabela de **descrições** das categorias (nome da categoria, idioma, etc.).                         |
-- | **eict**  | `EGP_CATEGORY_SETS_TL` | *Category Set Translations*                      | Contém os **nomes dos conjuntos de categorias** (Category Set), ex: Compras, Inventário, Contábil. |
-- | **class** | `EGP_ITEM_CLASSES_B`   | *Item Classes (Base)*                            | Estrutura hierárquica das classes de item (famílias, subfamílias).                                 |
-- | **iop**   | `INV_ORG_PARAMETERS`   | *Inventory Organization Parameters*              | Contém os **códigos e parâmetros das organizações de estoque** (por exemplo: ITEM_ORG_MESTRE).     |
;

select to_char(esib.creation_date,'dd-mon-yyyy hh24:mi') creation_date
       ,iop.organization_code
       ,esib.item_number
       ,esiv.description
       ,esib.primary_uom_code
       ,esib.inventory_item_status_code
       --,esib.item_type
       ,ectl.category_name
       ,eict.category_set_name
       ,class.item_class_code
       ,esib.list_price_per_unit
       --count(*) qtd_itens
from egp_item_categories  eic
      ,egp_system_items_b  esib 
      ,egp_system_items_vl  esiv
      ,egp_categories_tl  ectl
      ,inv_org_parameters  iop
      ,egp_category_sets_tl  eict
      ,egp_item_classes_b  class
where 1 = 1
   and esib.inventory_item_id     = eic.inventory_item_id (+)
 and esib.inventory_organization_id = eic.organization_id   (+)
 and esiv.inventory_item_id       = esib.inventory_item_id
 and esiv.organization_id       = eic.organization_id
 and ectl.category_id        = eic.category_id
 and iop.organization_id      = esib.organization_id
 and eic.category_set_id     = eict.category_set_id
 and esib.item_catalog_group_id     = class.item_class_id
 and iop.organization_code     = 'ITEM_ORG_MESTRE'
   and eict.category_set_name     = 'Compras'
 and eict.language      = 'PTB'
 and ectl.language      = 'PTB'
 --and ECTL.CATEGORY_NAME = some('HIGIENE PESSOAL')
 --and esib.creation_date > sysdate - 1
 --and esib.item_number = ''
order by esib.item_number;


-- Listando funcionários por centro de custo;
select * from EGP_CATEGORY_SETS_B eictb;

select distinct ppn.display_name 
     , gcc.segment5 	cc
from gl_code_combinations 	gcc
   , per_all_assignments_m	paa
   , per_person_names_f 	ppn
where 1=1
and gcc.code_combination_id = paa.default_code_comb_id
and paa.person_id 	    = ppn.person_id
and paa.assignment_type     = 'E'
and ppn.name_type 	    = 'BR';

 