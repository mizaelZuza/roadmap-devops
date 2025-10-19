# ☁️ Oracle Cloud Infrastructure (OCI)

> **Resumo do diretório**  
> Este diretório reúne anotações e conceitos sobre os pilares da Oracle Cloud Infrastructure (OCI). O conteúdo abrange desde a arquitetura fundamental e a gestão de identidades e acessos (IAM) até os componentes de redes (Networking), consolidando um guia de referência sobre os fundamentos da nuvem Oracle.

---

## 🎯 **Objetivo de Estudo**
Compreender a estrutura hierárquica da OCI, o funcionamento do controle de acesso com IAM e como construir e proteger redes virtuais (VCNs). O foco é entender como esses três pilares se integram para criar ambientes em nuvem seguros, resilientes e escaláveis.

---

## 🧩 **Principais Tópicos Abordados**

### 🏗️ Arquitetura
- **Estrutura Global:** Organização em Regiões, Domínios de Disponibilidade (ADs) e Domínios de Falha (FDs) para garantir alta disponibilidade e resiliência.
- **Componentes Essenciais:** Visão geral de serviços como Compute (VMs, Bare Metal), Storage (Block Volume, Object Storage) e seu papel no ecossistema.
- **Modelo de Responsabilidade Compartilhada:** Divisão clara das responsabilidades de segurança e gerenciamento entre a Oracle e o cliente.

### 🔐 Identidade e Acesso (IAM)
- **Componentes Fundamentais:** Gerenciamento de acesso através de Usuários, Grupos, Políticas e Compartimentos para organizar e isolar recursos.
- **Autenticação vs. Autorização (AuthN & AuthZ):** O processo de verificar quem você é e o que você tem permissão para fazer.
- **Políticas e Permissões:** Como as políticas (Policies) definem de forma granular as permissões, aplicando o princípio do menor privilégio.

### 🌐 Redes (Networking)
- **Virtual Cloud Network (VCN):** A rede virtual privada e isolada onde seus recursos são executados. Inclui a configuração de Sub-redes (públicas e privadas).
- **Gateways:** Componentes que controlam o fluxo de tráfego para a internet (Internet Gateway), para serviços Oracle (Service Gateway) ou de forma privada (NAT Gateway, DRG).
- **Segurança de Rede:** Controle de tráfego de entrada (Ingress) e saída (Egress) utilizando Security Lists e Network Security Groups (NSGs).
- **Balanceamento de Carga:** Distribuição de tráfego com Network Load Balancer (Camada 4) e Application Load Balancer (Camada 7).

---

## 🧠 **Aprendizados-Chave**
- A arquitetura da OCI é projetada para resiliência, distribuindo recursos entre múltiplos Domínios de Disponibilidade e de Falha.
- O IAM é o serviço central de segurança, onde o acesso a todos os recursos é negado por padrão e explicitamente concedido através de políticas.
- A VCN funciona como um data center virtual, onde gateways e regras de segurança fornecem controle total sobre a conectividade e o isolamento dos recursos.

---

## 📁 **Arquivos Relacionados**
- `architecture-oci-fundations.md` → Detalhes sobre a arquitetura global da OCI.
- `iam-oci-fundations.md` → Conceitos de identidade, acesso, políticas e compartimentos.
- `networking-oci-fundations.md` → Fundamentos de redes, gateways e segurança na VCN.
- `README.md` → Este arquivo (resumo do diretório).

---