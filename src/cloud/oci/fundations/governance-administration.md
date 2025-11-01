# 🛡️ OCI – Governança e Administração

> Este documento aborda os principais conceitos de Governança e Administração na Oracle Cloud Infrastructure (OCI), focando em controle de custos, gerenciamento de limites, otimização de recursos e boas práticas para garantir um ambiente seguro e econômico.

---

## 🧭 1. Visão Geral

A **Governança e Administração** na OCI é o conjunto de práticas e ferramentas que garantem o gerenciamento, controle e otimização dos recursos da nuvem. Seus pilares são:
- **Organização e isolamento** de recursos com Compartimentos.
- **Transparência de custos** e controle de orçamento.
- **Gestão de limites e permissões** (quotas e service limits).
- **Otimização de uso** com o Cloud Advisor.
- **Identificação e rastreamento** de recursos via Tagging.
- **Auditoria e conformidade** com o serviço de Audit.

---

## 🏛️ 2. Design de Compartimentos

Os compartimentos são o alicerce da governança na OCI, permitindo organizar e isolar recursos. Uma estratégia de compartimentos bem definida é fundamental para a segurança e a gestão.

> ➡️ **Nota:** O conceito fundamental de compartimentos, sua hierarquia e como eles interagem com políticas de IAM são detalhados no documento **`iam-oci-fundations.md`**. Consulte-o para uma visão aprofundada.

---

## 💰 3. Gestão de Custos (Cost Management)

A ferramenta de **Cost Management** permite monitorar, analisar e otimizar os gastos na OCI.

| Ferramenta | Propósito |
| :--- | :--- |
| **Cost Analysis** | Painel interativo para visualizar e filtrar custos por data, serviço, compartimento e **tags**. Essencial para identificar rapidamente os maiores gastos. |
| **Budgets** | Permite definir limites de gasto (orçamentos) e configurar **alertas por e-mail** quando o consumo atinge um limiar predefinido. |
| **Usage Reports** | Relatórios detalhados em formato CSV, contendo dados de consumo em nível de recurso. Útil para análises financeiras aprofundadas e integração com ferramentas de BI. |
| **Forecasting** | Funcionalidade que prevê os gastos futuros com base no histórico de consumo, auxiliando no planejamento financeiro. |

---

## ⚙️ 4. Limites de Serviço e Cotas (Service Limits & Quotas)

Mecanismos de controle para evitar o uso excessivo e não planejado de recursos.

| Tipo | Definido Por | Escopo | Exemplo |
| :--- | :--- | :--- | :--- |
| **Service Limits** | **Oracle** | Por Tenancy/Região | Número máximo de instâncias de um determinado shape que podem ser criadas. |
| **Compartment Quotas**| **Usuário** | Por Compartimento | `set compute quota 'standard-e4-core-count' to 20 in compartment Project-A` → Limita o número de OCPUs para um projeto específico. |

🔸 **Diferença chave:** *Service Limits* são impostos pela Oracle para toda a conta, enquanto *Compartment Quotas* são definidas pelo administrador para gerenciar o consumo interno.

---

## 🏷️ 5. Estratégia de Tagging

O **Tagging** é o processo de associar metadados (etiquetas) aos recursos. Uma boa estratégia é crucial para a governança, permitindo organizar, automatizar e rastrear custos.

| Conceito | Descrição |
| :--- | :--- |
| **Free-form Tags** | Pares de chave-valor simples, sem estrutura. **Não recomendadas para governança** devido à falta de padronização. |
| **Defined Tags** | Tags com um esquema controlado e centralizado, organizadas em **Tag Namespaces**. Garantem consistência e evitam erros de digitação. |
| **Tag Namespace** | Um contêiner para um conjunto de chaves de tag definidas. Ex: um namespace `CostManagement` pode conter as chaves `Projeto`, `CentroDeCusto` e `Ambiente`. |
| **Cost-tracking Tags** | Tags que são processadas pelo sistema de faturamento da OCI, permitindo filtrar relatórios de custo diretamente por elas. |

💡 **Boa prática:** Padronize o uso de **Defined Tags** e aplique políticas que exijam a presença de tags específicas na criação de recursos para garantir o rastreamento de 100% dos custos.

---

## 📜 6. Auditoria e Logs (Audit)

Saber "quem fez o quê e quando" é um pilar da governança. O serviço **OCI Audit** fornece essa visibilidade.

- **O que é:** Um registro **imutável** de todas as chamadas de API (ações) realizadas na sua tenancy, seja pela console, SDK ou CLI.
- **Retenção:** Os logs de auditoria são retidos por padrão por **365 dias**, sem custo.
- **Utilidade:** Essencial para investigações de segurança, análise forense e para atender a requisitos de conformidade (compliance).
- **Integração:** Os eventos de auditoria podem ser usados para disparar alertas (via OCI Notifications) ou automações (via OCI Events).

---

## 🧠 7. Otimização com Cloud Advisor

O **Cloud Advisor** analisa o ambiente OCI e fornece **recomendações automatizadas** para otimização em quatro áreas:

| Categoria | Foco da Recomendação |
| :--- | :--- |
| **Cost (Custo)** | Reduzir gastos com recursos subutilizados (ex: instâncias ociosas). |
| **Performance** | Ajustar configurações para obter melhor desempenho. |
| **Security (Segurança)** | Aplicar boas práticas para fortalecer a segurança (ex: buckets públicos). |
| **Reliability (Confiabilidade)** | Melhorar a resiliência e a disponibilidade do ambiente. |

---

## 🔑 8. Conceitos-Chave e Boas Práticas

| Conceito | Descrição |
| :--- | :--- |
| **Resource Locking** | Funcionalidade que permite **bloquear recursos** para prevenir modificações (`Full` lock) ou exclusões acidentais (`Delete` lock). Essencial para proteger componentes críticos da infraestrutura. |
| **Oracle Support Rewards** | Programa que converte gastos na OCI em créditos para abater custos de contratos de **suporte on-premises** da Oracle. |
| **Custos de Transferência** | Lembre-se que o tráfego de **saída (Egress)** para a internet é cobrado, enquanto o de **entrada (Ingress)** é gratuito. |

---

## 📘 9. Referências
- [Documentação Oficial – Cost Management](https://docs.oracle.com/en-us/iaas/Content/Billing/Concepts/costanalysisoverview.htm)
- [Documentação Oficial – Tagging](https://docs.oracle.com/en-us/iaas/Content/Tagging/Concepts/taggingoverview.htm)
- [Documentação Oficial – OCI Audit](https://docs.oracle.com/en-us/iaas/Content/Audit/home.htm)
- [Documentação Oficial – Cloud Advisor](https://docs.oracle.com/en-us/iaas/Content/CloudAdvisor/Concepts/cloudadvisoroverview.htm)

---