# 🛡️ Oracle Cloud Infrastructure (OCI) – Segurança

> Este documento resume os principais serviços e conceitos de segurança da OCI, abordando desde a prevenção com Security Zones e a detecção com Cloud Guard, até o gerenciamento de chaves com o serviço Vault e a proteção de identidade com IAM.

---

## 🧭 1. Modelo de Responsabilidade Compartilhada

O pilar da segurança na nuvem é o **Modelo de Responsabilidade Compartilhada** (Shared Responsibility Model). Ele define claramente as responsabilidades de segurança entre a Oracle (provedor) e o cliente.

| Responsável | Foco | Exemplos de Responsabilidade |
| :--- | :--- | :--- |
| **Oracle** (Provedor) | Segurança **DA** Nuvem | Infraestrutura física (data centers), Hardware, Rede física, Camada de Virtualização (Hypervisor). |
| **Cliente** (Usuário) | Segurança **NA** Nuvem | Dados e sua classificação, IAM (Usuários, Grupos, Políticas), Configuração de Rede (VCN, Firewalls, NSGs), Patches do SO Convidado, Aplicações. |

🔸 **Ponto-chave:** A Oracle garante a segurança da infraestrutura global, enquanto o cliente é responsável por configurar corretamente os serviços e proteger seus próprios dados e acessos.

---

## 🕵️ 2. Cloud Guard – Detecção e Remediação

O **Cloud Guard** é o principal serviço de **Detecção e Remediação** da OCI, funcionando como uma solução de Gerenciamento de Postura de Segurança na Nuvem (CSPM).

*   **Propósito:** Monitora continuamente o ambiente em busca de configurações incorretas e atividades de risco.
*   **Mecanismo:** Atua **após** a ocorrência de um evento (Detecção) e pode **remediar** (corrigir) problemas automaticamente.

### Componentes Principais

| Componente | Propósito |
| :--- | :--- |
| **Targets** (Alvos) | O escopo que o Cloud Guard monitora (ex: todo o tenancy ou compartimentos específicos). |
| **Detectors** (Detectores) | As "receitas" (recipes) que contêm as regras para identificar problemas (ex: regra "Bucket is public"). |
| **Problems** (Problemas) | O registro criado quando um Detector encontra uma violação de regra em um recurso. |
| **Responders** | As ações (automatizadas ou assistidas) que o Cloud Guard executa para corrigir um *Problem*. |

### Exemplo de Fluxo: Remediação de Bucket Público

1.  **Risco:** Um usuário torna um Object Storage Bucket público.
2.  **Detecção:** O **Detector** do Cloud Guard identifica a violação e cria um **Problem**.
3.  **Remediação:** O **Responder** é acionado (via OCI Events/Functions) e reverte o bucket para o estado "Privado" automaticamente.

---

## 🧱 3. Security Zones – Prevenção

Enquanto o Cloud Guard foca em Detecção, as **Security Zones** focam em **Prevenção**.

*   **Propósito Principal:** Garantir a adesão rigorosa às melhores práticas, **impedindo** que ações inseguras ocorram desde o início.
*   **Mecanismo:** Atua **antes** que a ação seja concluída. Se um usuário tenta criar um Bucket público dentro de uma Security Zone, a operação é **bloqueada** (negada).

### Diferença Chave: Cloud Guard vs. Security Zone

| Serviço | Mecanismo | Quando Atua | Exemplo de Ação |
| :--- | :--- | :--- | :--- |
| **Security Zone** | **Prevenção** | **Antes** da Ação | **BLOQUEIA** a tentativa de criar um Bucket público. |
| **Cloud Guard** | **Detecção & Remediação** | **Depois** da Ação | **CORRIGE** um Bucket que *foi* tornado público. |

🔸 **Maximum Security Zone:** É uma "receita" de Security Zone pré-configurada pela Oracle que aplica as políticas de segurança mais rigorosas, como exigir criptografia com chaves gerenciadas pelo cliente (KMS) e impedir a criação de IPs públicos.

🔸 O **Security Advisor** trabalha em conjunto com ambos, fornecendo recomendações para fortalecer a postura de segurança.


---

## 🔐 4. Vault – Gerenciamento de Criptografia e Segredos

O **OCI Vault** é o serviço centralizado para gerenciamento seguro de chaves de criptografia e segredos. 

### Proteção e Gerenciamento de Chaves
- **Hardware de Alta Segurança:** As chaves no Vault são armazenadas e processadas em **Hardware Security Modules (HSMs)** com certificação **FIPS 140-2 Level 3**, garantindo que não possam ser extraídas.
- **Tipos de Gerenciamento:**
  - **Chaves Gerenciadas pela Oracle:** A Oracle cuida de todo o ciclo de vida, incluindo a rotação.
  - **Chaves Gerenciadas pelo Cliente:** O cliente tem controle total sobre o ciclo de vida da chave (criação, rotação, exclusão).
- **Rotação Automática:** O Vault suporta a rotação automática de chaves e segredos em um cronograma definido, uma prática essencial para a higiene de segurança.

### Componentes Principais

| Componente | Descrição |
| :--- | :--- |
| **Vault (Cofre)** | O recurso contêiner onde as chaves e segredos são armazenados de forma segura. |
| **Master Encryption Key** | A chave (ex: AES) usada para criptografar e decriptografar dados em outros serviços. |
| **Secret (Segredo)** | Utilizado para armazenar credenciais, senhas ou tokens de API, com rotação automática. |

### Tipos de Chave e Uso

| Tipo de Chave | Algoritmo (Exemplo) | Uso Principal | Permite Assinatura Digital? |
| :--- | :--- | :--- | :--- |
| **Simétrica** | AES | Criptografar e Decriptografar dados (a mesma chave faz ambos). | **Não** |
| **Assimétrica**| RSA | Criptografar/Decriptografar (par de chaves) e Assinatura Digital. | **Sim** |
| **Assimétrica**| ECDSA | *Apenas* Assinatura Digital (não usado para criptografar dados). | **Sim (Apenas isso)** |

---

## 🌐 5. Outros Serviços de Segurança

### Proteção de Infraestrutura e Rede

| Serviço | Propósito |
| :--- | :--- |
| **WAF (Web Application Firewall)** | Protege aplicações web (Camada 7) contra ataques como XSS e SQL Injection. |
| **Network Firewall** | Firewall de próxima geração (NGFW) com inspeção profunda, filtragem de URL e prevenção de intrusão (IDPS). |
| **DDoS Protection** | Proteção (automática e por padrão) contra ataques de Negação de Serviço. |
| **Security Lists / NSGs** | Firewalls virtuais (Camada 3/4) para controlar tráfego de VCNs e VNICs. |
| **Certificates** | Gerencia e implanta certificados TLS/SSL para proteger endpoints de serviços. |

### Proteção de Carga de Trabalho e Identidade

| Serviço | Propósito |
| :--- | :--- |
| **Bastion** | Fornece acesso **seguro, efêmero e auditável** a recursos privados (VMs, DBs) sem expor portas públicas. Suporta sessões com tempo limitado e gravação de sessão. |
| **OS Management (OSMS)** | Automação de patches e atualizações de segurança nos sistemas operacionais das instâncias. |
| **IAM (Identity & Access)** | Controla "Quem pode fazer o quê" (Autenticação e Autorização). Inclui **Instance Principals** e **Dynamic Groups**, que permitem que recursos OCI se autentiquem sem armazenar credenciais. |
| **Vulnerability Scanning (VSS)** | Analisa hosts em busca de portas abertas e vulnerabilidades conhecidas (CVEs). |
| **Data Safe** | Plataforma unificada para segurança de bancos de dados. Suas funções incluem: **Avaliação de Segurança**, **Avaliação de Usuários**, **Descoberta e Mascaramento de Dados** e **Auditoria de Atividade**. |
| **Logging & Audit** | O serviço de **Audit** grava um log imutável de todas as chamadas de API (retido por 365 dias). O serviço de **Logging** agrega logs de infraestrutura e aplicações para análise e alertas. |

---

## 🧠 6. Boas Práticas e Conceitos-Chave

*   **Prevenção Primeiro:** Use **Security Zones** (especialmente a *Maximum Security Zone*) para compartimentos com workloads críticos.
*   **Defesa em Camadas:** Combine **Cloud Guard** (detecção) com **Security Zones** (prevenção) para uma estratégia de segurança robusta.
*   **Centralize Segredos:** Armazene todas as chaves, senhas e tokens no **OCI Vault**.
*   **Ciclo de Vida de Chaves:** Implemente um ciclo de vida para chaves e segredos, utilizando a **rotação automática do Vault** para reduzir o risco de credenciais comprometidas.
*   **Menor Privilégio:** Sempre aplique políticas de **IAM** que concedam apenas as permissões estritamente necessárias.
*   **Acesso Seguro:** Utilize o serviço **Bastion** para acesso a recursos privados, evitando o uso de *jump hosts* com IPs públicos permanentes.
*   **Monitoramento Contínuo:** Revise regularmente os logs do **Audit** e os problemas reportados pelo **Cloud Guard** para identificar e responder a ameaças.

---

## 📘 7. Referências
- [Documentação Oficial – Cloud Guard](https://docs.oracle.com/en-us/iaas/cloud-guard/using/index.htm)
- [Documentação Oficial – Security Zones](https://docs.oracle.com/en-us/iaas/security-zone/using/security-zones.htm)