# ☁️ Oracle Cloud Infrastructure (OCI) – Fundamentos de Rede e Segurança

> Este documento consolida os principais conceitos estudados sobre redes e segurança na Oracle Cloud Infrastructure (OCI).  
> O foco está em entender o funcionamento dos componentes que compõem uma Virtual Cloud Network (VCN), as regras de segurança e os tipos de gateways utilizados.

---

## 🧭 1. Virtual Cloud Network (VCN)

A **VCN** é a base da rede dentro da OCI — uma rede virtual isolada e personalizável que abriga sub-redes públicas e privadas.  
Ela é restrita a **uma única região**, mas pode **abranger múltiplos Availability Domains (ADs)**.

### 🔹 Características:
- Cada VCN é configurada com um **bloco CIDR** (ex: `10.0.0.0/16`).
- Permite criar **sub-redes públicas e privadas**.
- Suporta **roteamento interno e externo** via gateways.
- Pode ser conectada a outras VCNs por **peering** (local ou remoto).

---

## 🌐 2. Sub-redes e Peering

### 🔸 Sub-redes:
- **Pública:** associada ao *Internet Gateway* — acessível da internet.  
- **Privada:** utiliza *NAT Gateway* ou *Service Gateway* para tráfego de saída seguro.

### 🔸 Tipos de Peering:
- **Local Peering (LPG):** conecta VCNs **na mesma região**.
- **Remote Peering (RPG):** conecta VCNs **em regiões diferentes**.
- As VCNs **não podem ter CIDRs sobrepostos**.

---

## 🚪 3. Gateways

| Gateway | Função | Direção de Tráfego |
|----------|--------|-------------------|
| **Internet Gateway (IGW)** | Permite tráfego de entrada e saída da internet. | Ingress e Egress |
| **NAT Gateway** | Permite **somente tráfego de saída** da rede privada (sem acesso direto da internet). | Egress |
| **Service Gateway** | Permite acesso a serviços OCI sem passar pela internet. | Egress interno |
| **Dynamic Routing Gateway (DRG)** | Conecta redes on-premises via VPN ou FastConnect. | Bidirecional |

---

## 🔒 4. Segurança na VCN

A segurança é implementada em **nível de sub-rede** (via *Security Lists*) e em **nível de instância** (via *Network Security Groups - NSG*).

### **Security Lists**
Contêm regras **stateful ou stateless** que definem o tráfego permitido.

| Tipo | Direção | Origem/Destino | Protocolo | Porta | Descrição |
|------|----------|----------------|------------|--------|------------|
| Stateful | Ingress | 0.0.0.0/0 | TCP | 80 | Permite HTTP externo |
| Stateful | Ingress | 10.0.1.0/24 | TCP | 1521 | Permite comunicação entre sub-redes |
| Stateful | Egress | 10.0.2.0/24 | TCP | 1521 | Permite saída do tráfego para sub-rede privada |

🔸 *Stateful* → mantém o estado da conexão (respostas são automaticamente permitidas).  
🔸 *Stateless* → exige regras explícitas tanto para entrada quanto para saída.

---

## ⚙️ 5. Load Balancers

A OCI oferece dois tipos principais de balanceadores:

| Tipo | Camada OSI | Função |
|------|-------------|--------|
| **Network Load Balancer (NLB)** | Layer 4 (Transporte) | Roteia tráfego TCP/UDP com baixa latência. |
| **Application Load Balancer (ALB)** | Layer 7 (Aplicação) | Suporta regras HTTP/HTTPS, redirecionamentos e balanceamento baseado em conteúdo. |

---

## 🧱 6. Componentes Criados por Padrão

Ao criar uma VCN, são gerados automaticamente:

- **Default Route Table**
- **Default DHCP Options**
- **Default Security List**

🔸 *O Local Peering Gateway (LPG) não é criado automaticamente.*

---

## 📘 7. Conclusão

Compreender a estrutura e a interação entre os componentes da OCI é essencial para projetar redes seguras e escaláveis.  
O domínio de conceitos como **VCN**, **Gateways**, **Security Lists** e **Load Balancers** constitui a base para automação de infraestrutura em nuvem.

---
