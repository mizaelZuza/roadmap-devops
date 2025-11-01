# 🔐 OCI – Identity and Access Management (IAM)

> Este documento aborda os conceitos e componentes do IAM na Oracle Cloud Infrastructure (OCI), responsável por controlar **quem** pode acessar **quais recursos**, **de que forma** e **sob quais condições**.

---

## 🧭 1. Conceito de IAM

O **Identity and Access Management (IAM)** é o serviço central de controle de identidade e permissões na OCI. Ele se baseia no conceito de **Principal**, que é uma entidade autorizada a interagir com os recursos. O IAM determina se um Principal é autenticado (AuthN) e se ele tem autorização (AuthZ) para realizar uma ação específica.

---

## 🧱 2. Principais e Componentes Fundamentais

| Principal / Componente | Descrição |
| :--- | :--- |
| **Usuários (Users)** | Pessoas ou processos que acessam a OCI. Um usuário pode pertencer a um ou mais grupos. |
| **Grupos (Groups)** | Conjuntos de usuários que compartilham as mesmas permissões. É a forma recomendada de gerenciar autorizações. |
| **Dynamic Groups** | Grupos de **recursos** (como instâncias de computação) cujos membros são definidos por regras, não por uma lista estática. |
| **Políticas (Policies)** | Documentos que definem as permissões. Conectam um Principal (quem) a uma ação (o quê) sobre um recurso. |
| **Compartimentos** | Coleções lógicas para organizar e isolar recursos, aplicando o controle de acesso. |
| **Identity Domains** | Solução completa para gerenciar identidades, incluindo autenticação, SSO e federação. |

---

## 🔑 3. Autenticação (AuthN) – Provando quem você é

Processo de verificar a identidade de um Principal. A OCI oferece múltiplos métodos, cada um para um caso de uso específico.

| Método | Principal Associado | Caso de Uso Principal |
| :--- | :--- | :--- |
| **Senha da Console** | Usuário | Acesso interativo de humanos à console web da OCI. Deve ser combinado com MFA. |
| **Chaves de API** | Usuário | Automação de scripts (CLI, SDK, Terraform). Consiste em um par de chaves RSA no formato PEM. |
| **Tokens de Autenticação** | Usuário | Autenticação em APIs que não suportam o IAM padrão (ex: OCI Registry - OCIR). É uma string opaca. |
| **Instance Principals** | Instância de Compute | Permite que uma instância se autentique para chamar outras APIs da OCI **sem armazenar credenciais**. É o método mais seguro para automação dentro da nuvem. |

---

## 📜 4. Autorização (AuthZ) – O que você pode fazer

Após a autenticação, o serviço IAM verifica se o Principal tem permissão para realizar a ação solicitada. Isso é feito através de **Políticas**.

### Sintaxe e Verbos de Políticas

Uma política é uma frase em linguagem quase natural com uma estrutura clara:
`Allow <principal> to <verb> <resource-type> in <location> where <conditions>`

Os **verbos** definem o nível de permissão, em ordem crescente de poder:

| Verbo | Permissões Concedidas | Exemplo de Ação |
| :--- | :--- | :--- |
| `inspect` | Listar recursos e ver suas propriedades (sem acesso a dados confidenciais). | `oci compute instance list` |
| `read` | Inclui `inspect` + a capacidade de ler os metadados do recurso e seus dados. | Obter os detalhes de uma instância, ler um arquivo de um bucket. |
| `use` | Inclui `read` + a capacidade de trabalhar com o recurso (ações que não criam nem excluem). | Iniciar/parar uma instância, atualizar regras de segurança. |
| `manage` | **Permissão total.** Inclui todas as anteriores + criar e excluir o recurso e seus componentes. | Criar uma VCN, terminar uma instância, excluir um bucket. |

---

## ⚙️ 5. Principais de Recurso (Resource Principals)

Permitir que os próprios recursos da OCI se autentiquem de forma segura é um conceito fundamental para automação e segurança, eliminando a necessidade de armazenar credenciais de longa duração (como chaves de API) em arquivos de configuração.

### Dynamic Groups
Um **Dynamic Group** agrupa recursos da OCI (atualmente, instâncias de computação) que atendem a um conjunto de **regras de correspondência (matching rules)**.

- **Exemplo de Regra:** Agrupar todas as instâncias que estão em um compartimento específico.
  `All {instance.compartment.id = 'ocid1.compartment.oc1..xxxxx'}`

- **Exemplo de Política:** Dar permissão para que todas as instâncias nesse grupo dinâmico leiam segredos no Vault.
  `Allow dynamic-group AppServer-Group to read secrets in compartment Secrets-Compartment`

### Instance Principals
É o mecanismo que permite que uma instância de computação (membro de um Dynamic Group) se autentique no IAM. O agente da instância troca um certificado de identidade da instância por um token de segurança temporário, que é usado para assinar as chamadas de API.

---

## 🌐 6. Federação e Identity Domains

Os **Identity Domains** são a solução de IAM da OCI para gerenciar o ciclo de vida de identidades e acessos. Uma de suas funcionalidades mais importantes é a **Federação**.

**Federação** é o processo de estabelecer uma relação de confiança entre a OCI e um **Provedor de Identidade (IdP)** externo, como:
- Microsoft Entra ID (Azure AD)
- Okta
- Active Directory Federation Services (ADFS)

**Como funciona (Single Sign-On - SSO):**
1. O usuário tenta acessar a console da OCI.
2. A OCI o redireciona para a página de login do IdP corporativo (ex: login da Microsoft).
3. O usuário se autentica no IdP.
4. O IdP envia uma asserção de segurança (SAML 2.0) para o IAM da OCI, confirmando a identidade do usuário.
5. O IAM da OCI mapeia o usuário federado a um grupo local e concede acesso.

**Benefício:** Os usuários utilizam suas credenciais corporativas para acessar a nuvem, e a empresa mantém um ponto central de gestão de identidades e políticas de segurança (MFA, complexidade de senha, etc.).

---

## 🧠 7. Boas Práticas de IAM

- **Princípio do Menor Privilégio:** Sempre conceda a menor permissão necessária. Comece com `inspect` e eleve conforme a necessidade.
- **Use Grupos:** Atribua permissões a grupos, não a usuários individuais.
- **Use Dynamic Groups para Recursos:** Prefira *Instance Principals* em vez de armazenar chaves de API em instâncias.
- **Use Compartimentos:** Separe ambientes (Dev, Test, Prod) e restrinja as políticas ao compartimento relevante.
- **Habilite MFA:** Exija autenticação multifator para todos os usuários administrativos.
- **Federação:** Em ambientes corporativos, use federação para centralizar a gestão de identidades.

---

## 📘 8. Referências

- [Documentação Oficial – OCI Identity and Access Management](https://docs.oracle.com/en-us/iaas/Content/Identity/home.htm)
---