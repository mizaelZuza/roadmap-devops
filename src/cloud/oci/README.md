# ☁️ Oracle Cloud Infrastructure (OCI)

> **Resumo do diretório**
> Este diretório reúne anotações e conceitos sobre os pilares da Oracle Cloud Infrastructure (OCI). O conteúdo abrange desde a arquitetura fundamental, computação, gestão de identidades e acessos (IAM), redes (Networking), segurança e armazenamento, consolidando um guia de referência sobre os fundamentos da nuvem Oracle.

---

## 🎯 **Objetivo de Estudo**
Compreender a estrutura hierárquica da OCI, o funcionamento dos seus principais serviços e como eles se integram para criar ambientes em nuvem seguros, resilientes e escaláveis.

---

## 🧩 **Principais Tópicos Abordados**

### 🏗️ Arquitetura
- **Estrutura Global:** Organização em Regiões, Domínios de Disponibilidade (ADs) e Domínios de Falha (FDs).
- **Componentes Essenciais:** Visão geral de serviços como Compute, Storage e seu papel no ecossistema.
- **Modelo de Responsabilidade Compartilhada:** Divisão das responsabilidades de segurança entre a Oracle e o cliente.

### ⚙️ Compute
- **Tipos de Instâncias:** Máquinas Virtuais (VMs), Bare Metal (BM) e instâncias otimizadas.
- **Gerenciamento:** Ciclo de vida, metadados, imagens e templates.
- **Escalabilidade:** Pools de Instâncias e Autoscaling.
- **Workloads em Contêineres:** Oracle Container Engine for Kubernetes (OKE).

### 🔐 Identidade e Acesso (IAM)
- **Componentes Fundamentais:** Usuários, Grupos, Políticas e Compartimentos.
- **Autenticação vs. Autorização (AuthN & AuthZ):** O processo de verificar quem você é e o que tem permissão para fazer.
- **Domínios de Identidade:** Controle de autenticação e federação de identidades.

### 🌐 Redes (Networking)
- **Virtual Cloud Network (VCN):** A rede virtual privada e isolada.
- **Gateways:** Componentes que controlam o fluxo de tráfego (Internet, NAT, Service, DRG).
- **Segurança de Rede:** Security Lists e Network Security Groups (NSGs).
- **Balanceamento de Carga:** Network Load Balancer (NLB) e Application Load Balancer (ALB).

### 🛡️ Segurança
- **Cloud Guard:** Detecção e remediação de configurações de risco.
- **Security Zones:** Prevenção de ações que violem políticas de segurança.
- **Vault:** Gerenciamento de chaves de criptografia e segredos.
- **Outros Serviços:** WAF, Network Firewall, Bastion, e mais.

### 💾 Armazenamento (Storage)
- **Object Storage:** Para dados não estruturados com tiers (Standard, Infrequent Access, Archive).
- **Block Volume:** Armazenamento em blocos de alta performance para instâncias.
- **File Storage:** Sistema de arquivos compartilhado (NFS).

---

## 🧠 **Aprendizados-Chave**
- A arquitetura da OCI é projetada para resiliência e alta disponibilidade.
- O IAM é o serviço central para controle de acesso, seguindo o princípio do menor privilégio.
- A VCN oferece um ambiente de rede configurável e seguro.
- Os serviços de segurança atuam em prevenção (Security Zones) e detecção/remediação (Cloud Guard).
- Os serviços de armazenamento são otimizados para diferentes casos de uso, equilibrando performance e custo.

---

## 📁 **Arquivos Relacionados**
- `architecture-oci-fundations.md` → Detalhes sobre a arquitetura global da OCI.
- `compute.md` → Conceitos sobre os serviços de computação.
- `iam-oci-fundations.md` → Conceitos de identidade, acesso, políticas e compartimentos.
- `networking-oci-fundations.md` → Fundamentos de redes, gateways e segurança na VCN.
- `security.md` → Detalhes sobre os serviços de segurança da OCI.
- `storage.md` → Conceitos sobre os serviços de armazenamento.
- `README.md` → Este arquivo (resumo do diretório).

---