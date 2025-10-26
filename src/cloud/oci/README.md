# ☁️ Oracle Cloud Infrastructure (OCI)

> **Resumo do diretório**
> Este diretório reúne anotações e conceitos sobre os pilares da Oracle Cloud Infrastructure (OCI). O conteúdo abrange desde a arquitetura fundamental, computação, governança, identidade e acessos (IAM), redes (Networking), segurança e armazenamento, consolidando um guia de referência sobre os fundamentos da nuvem Oracle.

---

## 🎯 **Objetivo de Estudo**
Compreender a estrutura hierárquica da OCI, o funcionamento dos seus principais serviços e como eles se integram para criar ambientes em nuvem seguros, resilientes, escaláveis e com custos controlados.

---

## 🧩 **Principais Tópicos Abordados**

### 🏗️ Arquitetura
- **Estrutura Global:** Regiões, Domínios de Disponibilidade (ADs) e Domínios de Falha (FDs).
- **Componentes Essenciais:** Visão geral de serviços como Compute, Storage e seu papel no ecossistema.
- **Modelo de Responsabilidade Compartilhada:** Divisão das responsabilidades de segurança.

### ⚙️ Compute
- **Tipos de Instâncias:** Máquinas Virtuais (VMs), Bare Metal (BM) e instâncias otimizadas.
- **Gerenciamento e Escalabilidade:** Ciclo de vida, metadados, imagens, templates e Autoscaling.
- **Workloads em Contêineres:** Oracle Container Engine for Kubernetes (OKE).

### 🏛️ Governança e Administração
- **Gestão de Custos:** Análise de custos, orçamentos (Budgets) e relatórios de uso.
- **Controle de Recursos:** Limites de serviço (Service Limits) e Cotas de compartimento (Quotas).
- **Otimização e Boas Práticas:** Recomendações do Cloud Advisor e rastreamento com Tags.
- **Auditoria:** Rastreamento de atividades com o serviço OCI Audit.

### 🔐 Identidade e Acesso (IAM)
- **Principais e Autenticação:** Usuários, Grupos, métodos de autenticação (API Keys, Auth Tokens).
- **Autorização e Políticas:** Sintaxe de políticas e os verbos de permissão (`inspect`, `read`, `use`, `manage`).
- **Principais de Recurso:** Conceito de `Instance Principals` e `Dynamic Groups` para automação segura.
- **Federação:** Integração com provedores de identidade externos (Azure AD, Okta) para SSO.

### 🌐 Redes (Networking)
- **Virtual Cloud Network (VCN):** A rede virtual privada e isolada.
- **Gateways e Roteamento:** Controle do fluxo de tráfego (Internet, NAT, Service, DRG).
- **Segurança de Rede:** Security Lists e Network Security Groups (NSGs).

### 🛡️ Segurança
- **Prevenção e Detecção:** Security Zones (prevenção) e Cloud Guard (detecção e remediação).
- **Gerenciamento de Segredos:** OCI Vault para chaves de criptografia e segredos.
- **Serviços de Proteção:** WAF, Network Firewall, Bastion e OS Management.

### 💾 Armazenamento (Storage)
- **Object Storage:** Tiers de armazenamento, ciclo de vida e Pre-Authenticated Requests.
- **Block Volume:** Níveis de performance, backups e replicação.
- **File Storage:** Sistema de arquivos compartilhado (NFS).

---

## 🧠 **Aprendizados-Chave**
- A arquitetura da OCI é projetada para resiliência e alta disponibilidade.
- A governança eficaz combina controle de custos (budgets), organização (compartments, tags) e rastreabilidade (audit).
- O IAM é o serviço central para controle de acesso. O uso de `Instance Principals` e `Dynamic Groups` é a prática recomendada para automação segura.
- A VCN oferece um ambiente de rede configurável e seguro, protegido em camadas por Security Lists e NSGs.
- Os serviços de segurança atuam em prevenção (Security Zones) e detecção/remediação (Cloud Guard).

---

## 📁 **Arquivos Relacionados**
- `architecture-oci-fundations.md` → Detalhes sobre a arquitetura global da OCI.
- `compute.md` → Conceitos sobre os serviços de computação.
- `governance-administration.md` → Guia sobre controle de custos, cotas, tags e auditoria.
- `iam-oci-fundations.md` → Guia detalhado de IAM, incluindo políticas, `Dynamic Groups` e federação.
- `networking-oci-fundations.md` → Fundamentos de redes, gateways e segurança na VCN.
- `security.md` → Detalhes sobre os serviços de segurança da OCI.
- `storage.md` → Conceitos sobre os serviços de armazenamento.
- `README.md` → Este arquivo (resumo do diretório).

---