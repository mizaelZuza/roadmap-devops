# ⚙️ Oracle Cloud Infrastructure (OCI) – Compute

> Este documento detalha os serviços de computação da Oracle Cloud Infrastructure (OCI), abrangendo desde máquinas virtuais e bare metal até orquestração de contêineres com Kubernetes (OKE) e computação sem servidor (Serverless).

---

## 🧭 1. Visão Geral do Serviço de Compute

O serviço de **Compute** da OCI permite provisionar e gerenciar hosts de computação, conhecidos como **instâncias**. A OCI oferece uma variedade de tipos de instância (shapes) para atender a diferentes requisitos de desempenho, custo e workload.

---

## 🧱 2. Tipos de Instâncias (Shapes)

A OCI classifica suas instâncias com base no tipo de hardware e na finalidade do workload.

| Tipo de Instância | Descrição | Casos de Uso Comuns |
|-------------------|-------------|---------------------|
| **Máquina Virtual (VM)** | Ambiente multitenant onde o hardware é compartilhado. Flexível e econômico. | Aplicações web, desenvolvimento, testes, workloads de pequeno a médio porte. |
| **Bare Metal (BM)** | Servidor físico dedicado, sem hypervisor. Oferece máximo desempenho e isolamento. | Bancos de dados de alta performance, workloads com requisitos de licenciamento específicos, virtualização customizada. |
| **Host Dedicado (DVH)** | Um servidor físico inteiro dedicado a um único cliente, permitindo múltiplas VMs. | Conformidade regulatória, isolamento de workloads, "traga sua própria licença" (BYOL). |
| **Instâncias Otimizadas** | Shapes específicos para workloads intensivos em CPU, memória, armazenamento (DenseIO) ou GPU. | HPC (High-Performance Computing), análise de dados, machine learning, renderização. |

---

## 🔄 3. Gerenciamento e Ciclo de Vida da Instância

### 🔸 Ciclo de Vida
Uma instância passa por vários estados, desde sua criação até sua exclusão. Entender esses estados é crucial para o gerenciamento e a cobrança.

- **Provisioning:** A OCI está preparando os recursos da instância.
- **Starting:** A instância está sendo ligada.
- **Running:** A instância está em execução. A cobrança ocorre neste estado.
- **Stopping:** A instância está sendo desligada. A cobrança de OCPU é interrompida para VMs Standard.
- **Stopped:** A instância está desligada. O armazenamento (Boot Volume) continua sendo cobrado.
- **Terminating/Terminated:** A instância e seus recursos anexados estão sendo excluídos permanentemente.

### 🔸 Metadados da Instância (Instance Metadata)
Cada instância possui um serviço de metadados acessível por meio de um endpoint de rede interno (`http://169.254.169.254/opc/v2/`). Ele fornece informações sobre a própria instância, como:
- ID da instância, shape, região e domínio de disponibilidade.
- Configurações de rede (VNICs, endereços IP).
- Scripts de inicialização (user_data).

É amplamente utilizado para automação e para que as aplicações se autoconfigurem dinamicamente.

---

## 🖼️ 4. Imagens e Templates

### 🔸 Imagens Customizadas e Marketplace
- **Imagens Oracle:** Imagens de sistema operacional otimizadas e fornecidas pela Oracle.
- **Imagens Customizadas:** Permitem criar uma imagem a partir de uma instância já configurada (com seu software e personalizações), garantindo a padronização de futuros deploys.
- **Marketplace:** Um catálogo de imagens e aplicações de parceiros, prontas para serem implantadas com poucos cliques.

### 🔸 Configurações de Inicialização (Launch Configurations)
Funcionam como um template que define todos os parâmetros para a criação de uma instância, incluindo imagem, shape, rede, metadados e chaves SSH. São a base para a criação de **Pools de Instâncias** e para as políticas de **Autoscaling**.

---

## 🚀 5. Escalabilidade e Elasticidade

A OCI oferece duas abordagens principais para escalar recursos de computação:

### 🔸 **Pools de Instâncias e Autoscaling**
- **Pool de Instâncias:** Um grupo de instâncias gerenciadas em conjunto, permitindo atualizações e gerenciamento simplificados.
- **Configuração de Autoscaling:** Ajusta automaticamente o número de instâncias em um pool com base em regras predefinidas.
  - **Escalabilidade Baseada em Métricas:** Aumenta ou diminui o número de instâncias com base em métricas de desempenho, como utilização de CPU ou memória.
  - **Escalabilidade Agendada:** Ajusta a contagem de instâncias em horários específicos, ideal para prever picos de demanda.

---

## 📍 6. Posicionamento e Capacidade

### 🔸 Domínios de Falha (Fault Domains)
Ao criar uma instância, é possível escolher o **Fault Domain (FD)** em que ela será alocada. FDs são agrupamentos de hardware e infraestrutura dentro de um mesmo Domínio de Disponibilidade. Distribuir instâncias entre diferentes FDs protege a aplicação contra falhas de hardware ou manutenção no nível do rack.

### 🔸 Reservas de Capacidade (Capacity Reservations)
Permitem reservar capacidade de computação (shapes específicos) em um Domínio de Disponibilidade, garantindo que os recursos estarão disponíveis quando você precisar. Ideal para workloads críticos e recuperação de desastres.

---

## 🛡️ 7. Recursos Avançados de Instância

### 🔸 Shielded Instances
Oferecem uma camada adicional de segurança, utilizando um **Trusted Platform Module (TPM)** para medir e verificar a integridade do firmware da instância durante a inicialização. Isso protege contra bootkits e rootkits.

### 🔸 VNICs Secundárias
Uma instância pode ter múltiplas **placas de interface de rede virtual (VNICs)**. Cada VNIC pode estar em uma sub-rede diferente e ter seus próprios endereços IP privados e públicos. Isso é útil para criar appliances de rede ou isolar diferentes tipos de tráfego.

---

## 🐳 8. Workloads em Contêineres

### 🔸 **Oracle Container Engine for Kubernetes (OKE)**
- Serviço gerenciado de Kubernetes que simplifica a criação, o gerenciamento e a escalabilidade de clusters.
- Os **Nós de Trabalho (Worker Nodes)** são instâncias de compute (VMs ou Bare Metal) que executam os pods das aplicações.

### 🔸 **Oracle Cloud Infrastructure Registry (OCIR)**
- Um registro de imagens de contêiner privado e gerenciado, compatível com o Docker.

---

## ⚡ 9. Computação Serverless

### 🔸 **Oracle Functions**
- Plataforma de **Funções como Serviço (FaaS)**, totalmente gerenciada e baseada no projeto open-source Fn Project.
- Permite executar código sob demanda sem provisionar ou gerenciar servidores.

---

## 🛠️ 10. Ferramentas de Gerenciamento

### 🔸 **Oracle Cloud Shell**
- Terminal baseado em navegador, pré-configurado com a CLI da OCI e outras ferramentas (Git, kubectl, etc.).
- Oferece acesso rápido e seguro para gerenciar recursos da OCI.

---

## 🧠 11. Conceitos-Chave

- **Shape:** Define o número de OCPUs, a quantidade de memória e o armazenamento local de uma instância.
- **OCPU (Oracle Compute Unit):** Equivalente a um núcleo físico de um processador Intel Xeon ou a dois vCPUs de outros provedores.
- **Imagem:** Um template de um disco virtual que determina o sistema operacional e o software de uma instância.
- **Chave SSH:** Utilizada para autenticação segura ao acessar instâncias Linux.

---

## 📘 12. Referências
- [Documentação Oficial – OCI Compute](https://docs.oracle.com/en-us/iaas/Content/Compute/home.htm)
- [Documentação Oficial – OKE](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)
- [Documentação Oficial – Oracle Functions](https://docs.oracle.com/en-us/iaas/Content/Functions/home.htm)
