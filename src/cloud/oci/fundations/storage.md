# ☁️ Oracle Cloud Infrastructure – Storage

## 📘 Visão Geral

O módulo de **Storage** na Oracle Cloud Infrastructure (OCI) abrange os principais serviços de armazenamento disponíveis na plataforma, projetados para atender diferentes necessidades de desempenho, durabilidade e custo.  
Os três serviços principais são:

- **Object Storage** – ideal para dados não estruturados e escalabilidade.
- **Block Volume** – voltado para armazenamento em blocos de alta performance.
- **File Storage** – sistema de arquivos totalmente gerenciado e escalável.

Cada serviço é otimizado para um cenário específico, com políticas de resiliência e níveis de performance ajustáveis conforme a demanda do workload.

---

## 🧱 1. Object Storage

### 📦 Conceito
O **Object Storage** é um serviço de armazenamento de objetos usado para dados não estruturados (imagens, logs, backups, vídeos, etc.).  
Cada objeto é armazenado em **buckets**, com metadados e identificadores exclusivos.

### 🏗️ Classes de Armazenamento (Storage Tiers)

| Tier | Uso Ideal | Características |
|------|------------|-----------------|
| **Standard** | Dados acessados com frequência | Alta disponibilidade e baixa latência |
| **Infrequent Access (IA)** | Dados acessados ocasionalmente | Custo menor por GB armazenado, mas com taxa de recuperação |
| **Archive** | Dados raramente acessados | Armazenamento de baixo custo; requer restauração antes do acesso |

🔸 **Observações Importantes:**
- Objetos no **Archive tier** têm **período mínimo de retenção de 90 dias**.  
- A restauração (reidratação) de um objeto Archive leva **até 1 hora**.  
- Após restaurado, o objeto fica disponível por **24 horas** para download.  
- Buckets **não podem ter seu tier alterado** após criados (ex.: não é possível “atualizar” um bucket Archive para Standard).

### 🔐 Controle de Acesso

O acesso a objetos pode ser controlado de várias formas:
- **Políticas IAM** (Identity and Access Management);
- **Pre-Authenticated Requests (PARs)**: URLs temporárias que concedem **acesso seguro e controlado** a um objeto sem exigir autenticação adicional.

> Exemplo: permitir que um usuário externo baixe um arquivo específico por tempo limitado.

### 🔄 Recursos Adicionais

- **Políticas de Ciclo de Vida (Lifecycle Policies):** Permitem automatizar a gestão de objetos, movendo-os entre tiers (ex: Standard → Archive após 90 dias) ou excluindo-os automaticamente. Essencial para otimização de custos.
- **Replicação Cross-Region:** Permite replicar os dados de um bucket para outra região geograficamente distante, garantindo a continuidade do negócio em caso de desastres regionais.

---

## 💾 2. Block Volume

### ⚙️ Conceito
O **Block Volume** fornece armazenamento em blocos persistente e escalável, semelhante a um disco físico, utilizado por instâncias de **Compute**.

Pode ser usado para:
- Sistemas de arquivos (ext4, XFS, etc.);
- Bancos de dados;
- Aplicações empresariais que exigem alta performance de IOPS.

### 🧠 Níveis de Performance

| Nível | IOPS / GB | IOPS Máx. por Volume | Uso Recomendado |
|--------|------------|----------------------|-----------------|
| **Lower Cost** | 10 IOPS/GB | 25.000 | Workloads de baixo desempenho |
| **Balanced** | 30 IOPS/GB | 25.000 | Aplicações gerais e ambientes de teste |
| **Higher Performance** | 60 IOPS/GB | 35.000 | Workloads intensivos em I/O |
| **Ultra High Performance** | 90 IOPS/GB | 90.000 | Bancos de dados críticos e aplicações de alta performance |

### 🧩 Recursos de Durabilidade e Segurança
- **Replicação automática** entre domínios de falha (fault domains).
- **Backups e Clones:** Possibilidade de criar backups incrementais (armazenados no Object Storage) e clones completos de um volume.
- **Volume Groups:** Permitem agrupar múltiplos volumes para criar backups consistentes em um único ponto no tempo, essencial para aplicações distribuídas.
- **Replicação Cross-Region:** Capacidade de replicar volumes e seus backups para outras regiões para fins de recuperação de desastres.
- **Criptografia** em repouso e em trânsito habilitada por padrão.

---

## 📂 3. File Storage

### 📖 Conceito
O **File Storage Service (FSS)** é um sistema de arquivos totalmente gerenciado e distribuído, acessado via **NFS (Network File System)**.

Permite que múltiplas instâncias compartilhem os mesmos dados simultaneamente, mantendo consistência e durabilidade.

### 🌐 Características
- Armazenamento **elástico** e **automático** (sem necessidade de provisionamento prévio de capacidade).
- **Snapshots:** Suporte a cópias point-in-time (read-only) do sistema de arquivos, usadas para proteção de dados e clones.
- Ideal para workloads que precisam de **acesso compartilhado**, como:
  - Aplicações empresariais legadas;
  - Ambientes de desenvolvimento;
  - Containers e clusters Kubernetes (via Persistent Volumes).

---

## 🧾 4. Comparativo de Serviços

| Característica | Object Storage | Block Volume | File Storage |
|----------------|----------------|---------------|---------------|
| Tipo de dado | Não estruturado | Estruturado / Sistema de arquivos | Arquivos compartilhados |
| Acesso | Via API/SDK/Console | Anexado a instância | Montado via NFS |
| Escalabilidade | Alta | Limitado ao volume | Automática |
| Casos de uso | Backups, logs, dados imutáveis | Bancos de dados, VMs | Compartilhamento entre múltiplas instâncias |
| Custo | Variável por tier | Fixo por volume | Sob demanda |

---

## 🔒 5. Boas Práticas

- Utilize **Object Storage - Archive Tier** para backups de longo prazo e baixo custo.  
- Ajuste o nível de **Block Volume Performance** conforme a carga de trabalho.  
- Crie **snapshots** regulares dos volumes de bloco para recuperação de desastres.  
- Use **Pre-Authenticated Requests** para compartilhamentos temporários e seguros.  
- Habilite **replicação e versionamento** para garantir integridade e durabilidade.  
- Centralize logs e backups críticos em **Object Storage** com políticas de ciclo de vida (lifecycle policies).

---

## 🧠 6. Resumo

| Serviço | Foco Principal | Benefício Chave |
|----------|----------------|-----------------|
| **Object Storage** | Dados não estruturados e backups | Escalabilidade e custo eficiente |
| **Block Volume** | Dados transacionais e críticos | Alta performance e replicação |
| **File Storage** | Acesso compartilhado a arquivos | Simplicidade e gerenciamento automático |

---

## 🧩 7. Conclusão

Os serviços de **armazenamento da OCI** formam a base para construir infraestruturas resilientes, seguras e eficientes.  
Compreender como cada tipo de storage opera e suas respectivas otimizações permite desenhar soluções que equilibram custo, desempenho e disponibilidade — pilares essenciais em qualquer ambiente de nuvem empresarial.

---
