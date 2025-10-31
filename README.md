## 🧠 Oracle Fusion Data Insights — Master Data Analytics

**Autor:** Natan Felipe de Oliveira
**Função:** Analista de Segurança da Informação & Cientista de Dados (MDM / ERP)
**Tecnologias:** Oracle SQL, PL/SQL, Fusion Cloud ERP, Data Governance, Python, PostgreSQL

---

### 📋 Visão Geral

Este projeto reúne um conjunto de **consultas analíticas e operacionais** desenvolvidas para extração, padronização e auditoria de dados mestres do **Oracle Fusion Cloud Applications**, com foco em quatro domínios principais:

* 🧩 **Itens (Produtos e Materiais)**
* 👥 **Funcionários e Usuários de Sistema**
* 🏢 **Fornecedores (Vendors)**
* 🧾 **Clientes e Organizações**

Cada script foi projetado para **auxiliar times de governança, compras e TI** na **visualização, rastreabilidade e integridade dos cadastros**, garantindo consistência entre módulos como *Procurement*, *Product Information Management (PDH)*, *Inventory* e *Human Capital Management (HCM)*.

---

### 🧱 Estrutura dos Scripts

| Script                                           | Domínio        | Finalidade                                                                                                      | Destaques                                                                 |
| ------------------------------------------------ | -------------- | --------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| `BUSCA_ITEM_CLASSE_CATEGORIA_NCM.sql`            | Itens          | Lista todos os itens vinculando **classe, categoria e NCM** com suporte multilíngue.                            | Integra `EGP_SYSTEM_ITEMS_B`, `EGP_ITEM_CLASSES`, `EGP_CATEGORY_SETS_TL`. |
| `BUSCA_ITEM_CLASSE_STATUS_ITEM.sql`              | Itens          | Exibe **status dos itens (Active/Inactive)** com sua respectiva classe e organização.                           | Permite análises de ativos por categoria.                                 |
| `BUSCA_NCM_NOME_CATEGORIA_CATALOGO_STATUS.sql`   | Itens          | Mostra a **associação entre NCM, categoria e status** do item.                                                  | Ideal para auditorias de compliance fiscal.                               |
| `BUSCA_CLASSES_PDH_COM_STATUS.sql`               | PDH            | Retorna todas as **classes de itens do Product Data Hub**, com status ativo/inativo.                            | Usa `EGP_ITEM_CLASSES_B` para gestão de hierarquia.                       |
| `CONSULTA_ITENS_CLASSE_ORG_MESTRE.sql`           | Itens          | Foco na **organização mestre de itens (ITEM_ORG_MESTRE)**, consolidando descrições e classes.                   | Suporte multilíngue via `EGP_SYSTEM_ITEMS_VL`.                            |
| `BUSCA_TODAS_AS_TABELAS_DO_BANCO_ORACLE_ERP.sql` | Infraestrutura | Lista tabelas do ERP que contenham colunas relacionadas a **clientes (CUSTOMER)**.                              | Exploração estrutural do dicionário `ALL_TAB_COLUMNS`.                    |
| `BUSCA_CRACHA_FUNCIONARIO.sql`                   | Funcionários   | Consulta **funcionários ativos** com informações de cargo, departamento, supervisor e nível hierárquico.        | Integra módulos HCM (`PER_ALL_PEOPLE_F`, `PER_JOBS`, `PER_DEPARTMENTS`).  |
| `QUEM_MEXEU_NO_MEU_FORNCEDOR.sql`                | Fornecedores   | Traz **histórico de criação e atualização de fornecedores**, incluindo timestamps convertidos para timezone BR. | Log detalhado de auditoria (`POZ_SUPPLIERS`, `HZ_PARTIES`).               |
| `querys_00001.sql`                               | Itens e RH     | Scripts auxiliares e consultas de apoio a mapeamentos de centro de custo e itens.                               | Inclui dicionário técnico de tabelas Oracle Fusion.                       |

---

### 🧮 Objetivos Técnicos

1. **Auditar consistência entre cadastros mestres**

   * Identificar divergências entre status de itens e suas classes.
   * Validar integridade de vínculos entre NCM e categorias fiscais.

2. **Analisar rastreabilidade e ciclo de vida dos registros**

   * Fornecedores: quem criou, quem alterou e quando.
   * Funcionários: relação entre cargo, centro de custo e hierarquia.

3. **Mapear estrutura de dados Oracle Fusion (MDM)**

   * Explorar joins entre tabelas base (`_B`) e multilíngues (`_TL`, `_VL`).
   * Documentar entidades de negócio com significados e relacionamentos.

4. **Gerar bases de apoio para dashboards e integração com Python / PostgreSQL**

   * Criação de visões exportáveis (CSV ou DB link) para uso em ETL e BI.
   * Integração com pipelines de saneamento e padronização.

---

### 🧩 Modelo Conceitual de Dados (Simplificado)

```
Fornecedores ─┬─ POZ_SUPPLIERS
               └─ HZ_PARTIES

Itens ─┬─ EGP_SYSTEM_ITEMS_B
        ├─ EGP_SYSTEM_ITEMS_VL
        ├─ EGP_ITEM_CLASSES_B / TL
        ├─ EGP_ITEM_CATEGORIES
        └─ EGP_CATEGORY_SETS_TL

Funcionários ─┬─ PER_ALL_PEOPLE_F
               ├─ PER_JOBS
               ├─ PER_DEPARTMENTS
               └─ PER_ALL_ASSIGNMENTS_M
```

---

### 📊 Exemplos de Insights Obtidos

* **Mapeamento de 100% dos itens ativos no PDH** com sua respectiva classe, NCM e categoria de compra.
* **Rastreamento de alterações em fornecedores**, com timezone convertido de UTC → America/São_Paulo.
* **Listagem hierárquica de funcionários ativos**, com cargo, departamento e nível de aprovação.
* **Auditoria cruzada entre status de itens e classes inativas**, identificando registros órfãos.

---

### 🧰 Ferramentas & Stack Técnica

| Tipo                       | Ferramenta                    |
| -------------------------- | ----------------------------- |
| **Banco de Dados**         | Oracle Fusion ERP / PDH       |
| **Linguagem SQL**          | Oracle SQL & PL/SQL           |
| **ETL e Análise**          | Python (pandas, SQLAlchemy)   |
| **Armazenamento local**    | PostgreSQL / SQLite           |
| **Visualização**           | Streamlit / Power BI          |
| **Governança e Segurança** | MDM, Roles, Integration Users |

---

### 🚀 Próximos Passos

* Integração automatizada via **Oracle REST APIs (Fusion ERP / Procurement / HCM)**.
* Criação de **dashboards interativos** para acompanhamento de saneamento e evolução dos cadastros.
* Uso de **modelos de NLP** para padronizar descrições e sugerir categorias de itens automaticamente.

---

### 💡 Sobre o Projeto

> “A base de qualquer inteligência organizacional é a qualidade dos dados mestres.
> Este repositório representa o alicerce técnico da governança de cadastros —
> onde SQL se encontra com ciência de dados corporativa.”
