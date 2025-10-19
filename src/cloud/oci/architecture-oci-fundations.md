# 🏗️ Oracle Cloud Infrastructure (OCI) – Arquitetura

> Este documento apresenta a visão geral da arquitetura da Oracle Cloud Infrastructure (OCI), seus principais componentes e como eles se relacionam para oferecer ambientes de nuvem de alto desempenho, segurança e escalabilidade.

---

## 🧭 1. Visão Geral da Arquitetura OCI

A **OCI (Oracle Cloud Infrastructure)** é construída sobre uma **rede global de data centers**, organizados em **regiões** e **domínios de disponibilidade**, oferecendo alta disponibilidade, isolamento de falhas e latência previsível.

### 🗺️ Estrutura Hierárquica

| Nível | Descrição |
|-------|------------|
| **Região (Region)** | Uma localização geográfica específica (ex: São Paulo, Ashburn, Frankfurt). |
| **Availability Domain (AD)** | Um ou mais data centers isolados dentro de uma região. |
| **Fault Domain (FD)** | Subdivisão dentro de um AD — garante resiliência distribuindo recursos. |

🔹 Cada **região** é independente.  
🔹 ADs dentro da mesma região possuem **conectividade rápida e gratuita**.

---

## ⚙️ 2. Componentes Principais

### 🧱 Compute
- Instâncias de máquinas virtuais ou bare metal.
- Permitem escalabilidade horizontal e vertical.
- Integradas a **VCN (Virtual Cloud Network)**.

### 💾 Storage
- **Block Volume:** armazenamento persistente para instâncias.
- **Object Storage:** dados não estruturados (imagens, backups, logs).
- **File Storage:** compartilhamento NFS para múltiplas VMs.
- **Local NVMe:** armazenamento de baixa latência diretamente no host.

### 🌐 Networking
- **VCN (Virtual Cloud Network):** rede isolada e configurável.
- **Subnets, Route Tables, Gateways e Security Lists** definem o tráfego.
- Suporte a conectividade **on-premises** via **DRG (Dynamic Routing Gateway)**.

### 🔐 Identity and Access Management (IAM)
- Gerencia **usuários, grupos, políticas e compartimentos**.
- Base de segurança para todos os serviços OCI.

---

## 🏢 3. Modelo de Regiões e Domínios

### 🔸 Regiões
Cada região contém recursos independentes — ideal para conformidade e baixa latência.  
Exemplo: `sa-saopaulo-1`.

### 🔸 Availability Domains
- Isolam falhas físicas e lógicas.
- Recursos em ADs diferentes não compartilham hardware.

### 🔸 Fault Domains
- Evitam downtime simultâneo em instâncias.
- Normalmente, cada AD contém **três fault domains**.

---

## 🔄 4. Alta Disponibilidade e Resiliência

A OCI foi projetada com **redundância em múltiplos níveis**:
- Diversos ADs por região.
- Recursos replicados automaticamente (como Object Storage).
- Balanceadores e gateways tolerantes a falhas.

---

## 🧩 5. Modelo de Responsabilidade Compartilhada

| Área | Responsabilidade do Cliente | Responsabilidade da Oracle |
|------|-----------------------------|-----------------------------|
| **Dados** | Gerenciamento, criptografia, backup | Infraestrutura de armazenamento |
| **Sistema Operacional e Aplicações** | Instalação, atualização e configuração | Patching do hypervisor |
| **Rede e Hardware** | Configuração de sub-redes, gateways e segurança | Operação física e monitoramento |
| **Segurança Física e Infraestrutura** | — | Controle de acesso e segurança do data center |

---

## 🧠 6. Conceitos-Chave

- A OCI é **multi-regional e multi-AD**, garantindo isolamento e redundância.  
- Recursos são organizados por **compartimentos** e protegidos via **IAM Policies**.  
- A rede é **totalmente configurável**, integrando-se a ambientes híbridos.  

---

## 📘 Referências
- [Documentação Oficial – OCI Architecture Overview](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm)
---
