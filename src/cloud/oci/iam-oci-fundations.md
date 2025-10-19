# 🔐 Oracle Cloud Infrastructure (OCI) – Identity and Access Management (IAM)

> Este documento aborda os principais conceitos e componentes do IAM na Oracle Cloud Infrastructure (OCI), responsável por controlar **quem** pode acessar **quais recursos**, **de que forma** e **sob quais condições**.

---

## 🧭 1. Conceito de IAM

O **Identity and Access Management (IAM)** é o serviço central de controle de identidade e permissões na OCI.  
Ele garante que cada recurso seja acessado apenas por usuários ou sistemas devidamente autorizados.

---

## 🧱 2. Componentes Fundamentais

| Componente | Descrição |
|-------------|------------|
| **Usuários (Users)** | Representam pessoas ou sistemas que acessam a OCI. |
| **Grupos (Groups)** | Conjuntos de usuários com permissões em comum. |
| **Políticas (Policies)** | Definem o que grupos podem fazer (ex: `Allow group DevOps to manage instances in compartment Infra`). |
| **Compartimentos (Compartments)** | Estrutura lógica para organização e isolamento de recursos. |
| **Tenancy** | Raiz da hierarquia de identidade, representando toda a conta OCI. |
| **Domínios de Identidade (Identity Domains)** | Controlam autenticação e federação de identidades. |

---

## 🧩 3. Compartimentos (Compartments)

Os **compartimentos** organizam os recursos OCI logicamente.  
Permitem controle granular de acesso, delegação e auditoria.

- São **hierárquicos** — podem conter subcompartimentos.  
- As **políticas** se aplicam de forma recursiva (herdadas pelos subníveis).  
- Exemplo:
```

Root Tenancy
├── Compartment Dev
│   ├── Subcompartment Test
└── Compartment Prod

````

---

## 🔑 4. Autenticação e Autorização (AuthN e AuthZ)

### **AuthN (Authentication)**  
Processo de **verificar a identidade** do usuário ou sistema.  
Pode ser feito via:
- Nome de usuário e senha.
- API Key (para automação e scripts).
- Federated SSO (AD, IDCS, etc).
- MFA (fator adicional de segurança).

### **AuthZ (Authorization)**  
Define **o que o usuário autenticado pode fazer**.  
Baseado em **políticas** escritas em linguagem natural.

Exemplo:
```text
Allow group NetworkAdmins to manage virtual-network-family in compartment Infra
````

---

## 🧰 5. Tipos de Políticas

| Tipo                  | Descrição                                           | Exemplo                                                                |
| --------------------- | --------------------------------------------------- | ---------------------------------------------------------------------- |
| **Tenancy-Level**      | Válida para todos os compartimentos.                | `Allow group Admins to manage all-resources in tenancy`                |
| **Compartment-Level** | Restringe permissões a um compartimento específico. | `Allow group Devs to use instances in compartment Teste`               |
| **Dynamic Groups**    | Associam instâncias a permissões específicas.       | `Allow dynamic-group WebApps to manage objects in compartment Storage` |

---

## 🧾 6. Identity Domains

Os **Identity Domains** são ambientes de identidade independentes, integrados à OCI.
Permitem:

* **Gerenciar autenticação** de usuários e aplicações.
* **Federar acesso** com provedores externos (ex: Microsoft Entra ID).
* Controlar **políticas de senha, MFA e ciclo de vida** de identidades.

---

## 🧠 7. Boas Práticas de IAM

* Crie **grupos baseados em função**, não em indivíduo.
* Aplique o **princípio do menor privilégio**.
* Use **compartimentos** para separar ambientes (ex: Dev, Test, Prod).
* Habilite **MFA** para todas as contas administrativas.
* Utilize **políticas específicas** em vez de permissões amplas.

---

## 📘 Referências

* [Documentação Oficial – OCI Identity and Access Management](https://docs.oracle.com/en-us/iaas/Content/Identity/home.htm)
---
