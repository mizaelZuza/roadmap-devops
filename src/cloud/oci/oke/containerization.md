# 📦 Containerização: Docker e Conceitos Fundamentais

> **Resumo do Documento**
> Este documento aborda os conceitos essenciais de containerização, com foco na tecnologia Docker. O conteúdo detalha desde a definição de contêineres, suas diferenças em relação à virtualização tradicional, até os componentes, comandos e boas práticas do Docker.

---

## 🎯 O que é Containerização?

A containerização é uma técnica de virtualização em nível de sistema operacional que empacota uma aplicação e suas dependências em uma unidade isolada e portátil chamada **contêiner**.

> **Analogia:** Pense em **Máquinas Virtuais (VMs)** como casas separadas; cada uma tem sua própria infraestrutura (sistema operacional, encanamento, etc.). **Contêineres** são como apartamentos em um prédio; todos compartilham a mesma infraestrutura fundamental (o kernel do SO do hospedeiro), mas cada um é um espaço isolado e funcional.

### ✨ Características Principais

-   **Virtualização a Nível de SO:** Executa a virtualização diretamente no kernel do sistema operacional do hospedeiro.
-   **Runtime (Motor):** O **Container Engine** (como o Docker) atua como o ambiente de execução.
-   **Compartilhamento de Kernel:** Contêineres compartilham o SO do hospedeiro, contendo apenas a aplicação e suas bibliotecas.
-   **Portabilidade:** Aplicações em contêineres funcionam de maneira consistente em diferentes ambientes.

---

## 🆚 Containerização vs. Virtualização Tradicional

A principal diferença está na arquitetura de execução e no compartilhamento de recursos.

| Característica | Máquina Virtual (VM) | Contêiner |
| :--- | :--- | :--- |
| **Sistema Operacional** | Cada VM possui seu próprio SO Convidado (Guest OS). | Compartilham o mesmo kernel do SO hospedeiro. |
| **Recursos** | Consumo significativo de CPU e memória por VM. | Leves, com baixo overhead de recursos. |
| **Inicialização** | Lenta (minutos), pois precisa carregar um SO completo. | Rápida (segundos ou menos). |
| **Densidade** | Menor número de aplicações por host. | Maior densidade de aplicações no mesmo host. |
| **Camada de Software** | Aplicação > Bibliotecas > **Guest OS** > **Hypervisor** > Infraestrutura | Aplicação > Bibliotecas > **Container Engine** > **SO Host** > Infraestrutura |

---

## 🌟 Benefícios da Containerização

-   **Portabilidade:** Uma aplicação e suas dependências são empacotadas juntas, garantindo que ela funcione em qualquer ambiente que tenha um container engine.
-   **Agilidade:** Acelera o ciclo de vida do desenvolvimento, permitindo que desenvolvedores foquem no código sem se preocupar com o ambiente.
-   **Velocidade:** Contêineres podem ser criados e destruídos em segundos, otimizando pipelines de CI/CD e escalabilidade.
-   **Eficiência:** O compartilhamento do kernel do SO hospedeiro resulta em um uso muito menor de recursos em comparação com VMs.
-   **Isolamento de Falhas:** Processos dentro de um contêiner são isolados. Uma falha em um contêiner não afeta outros na mesma máquina.
-   **Reprodutibilidade:** Garante que os ambientes de desenvolvimento, teste e produção sejam idênticos, eliminando o clássico "mas funciona na minha máquina".

---

## 🐳 Componentes e Fluxo de Trabalho do Docker

O ecossistema Docker possui componentes que trabalham juntos para construir, executar e distribuir aplicações.

-   **Dockerfile:** Arquivo de texto com instruções para construir uma **Imagem**.
-   **Image:** Um template imutável (somente leitura) que contém a aplicação e suas dependências.
-   **Container:** Uma instância executável e isolada de uma **Imagem**.
-   **Docker Engine:** O "coração" do Docker, composto pelo **Daemon** (servidor `dockerd`) e pelo **Client** (CLI `docker`).
-   **Registry:** Um repositório para armazenar e compartilhar **Imagens** (ex: Docker Hub, AWS ECR, OCI Registry).

### Fluxo de Trabalho Típico

1.  O desenvolvedor escreve um `Dockerfile`.
2.  Executa `docker build` para criar uma **Imagem** a partir do `Dockerfile`.
3.  A **Imagem** é armazenada localmente no host Docker.
4.  Executa `docker run` para criar e iniciar um **Contêiner** a partir da **Imagem**.
5.  (Opcional) Executa `docker push` para enviar a **Imagem** para um **Registry**, compartilhando-a com outros.

---

## 📜 Instruções do Dockerfile

O `Dockerfile` é a receita para construir sua imagem.

| Comando | Descrição |
| :--- | :--- |
| **`FROM`** | Define a imagem base. Todo Dockerfile começa com um `FROM`. |
| **`WORKDIR`** | Define o diretório de trabalho para as instruções seguintes. |
| **`COPY`** | Copia arquivos do host para o filesystem da imagem. Mais transparente que o `ADD`. |
| **`ADD`** | Similar ao `COPY`, mas com funcionalidades extras como descompactar arquivos `.tar` e baixar de URLs (uso menos comum). |
| **`RUN`** | Executa comandos no shell da imagem durante o build (ex: `RUN apt-get update`). |
| **`ENV`** | Define variáveis de ambiente. |
| **`EXPOSE`** | Documenta a porta em que o serviço no contêiner irá escutar. Não publica a porta. |
| **`CMD`** | Define o comando e/ou parâmetros padrão para o contêiner. Pode ser facilmente sobrescrito na linha de comando (`docker run ... [outro_comando]`). |
| **`ENTRYPOINT`** | Configura o contêiner para ser executado como um executável. Mais difícil de sobrescrever que o `CMD`. |

### `ENTRYPOINT` vs. `CMD`

-   Use `ENTRYPOINT` para definir o executável principal e `CMD` para fornecer os argumentos padrão.
-   **Exemplo:** `ENTRYPOINT ["ping"]` e `CMD ["localhost"]`. O contêiner executará `ping localhost`, mas você pode rodar `docker run <imagem> google.com` para executar `ping google.com`.

### Builds Multi-Stage

Uma técnica essencial para criar imagens otimizadas. Permite usar uma imagem maior com ferramentas de build (ex: com JDK e Maven) e depois copiar apenas o artefato final (o `.jar`) para uma imagem final enxuta (apenas com JRE).

```Dockerfile
# Estágio de Build
FROM maven:3.8-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn package

# Estágio Final
FROM openjdk:17-jre-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
```

---

## ⚙️ Comandos Essenciais do Docker

### Flags Comuns para `docker run`

-   `-d`: **Detached** - Executa o contêiner em segundo plano.
-   `-p 8080:80`: **Port Mapping** - Mapeia a porta 8080 do host para a porta 80 do contêiner.
-   `--name meu-app`: **Name** - Atribui um nome legível ao contêiner.
-   `-v /path/no/host:/path/no/container`: **Volume** - Mapeia um diretório do host para dentro do contêiner para persistência de dados.
-   `--rm`: **Remove** - Remove o contêiner automaticamente quando ele para.

### Gerenciamento de Contêineres

| Ação | Comando |
| :--- | :--- |
| Criar e Iniciar | `docker run [FLAGS] [IMAGEM]` |
| Acessar Shell | `docker exec -it [CONTAINER] /bin/sh` (ou `/bin/bash`) |
| Listar em Execução | `docker ps` (ou `docker container ls`) |
| Parar | `docker stop [CONTAINER]` |
| Remover | `docker rm [CONTAINER]` |

### Gerenciamento de Imagens

| Ação | Comando |
| :--- | :--- |
| Baixar Imagem | `docker pull [IMAGEM]` |
| Construir Imagem | `docker build -t [NOME_DA_IMAGEM] .` |
| Listar Imagens | `docker images` (ou `docker image ls`) |
| Remover Imagem | `docker rmi [IMAGEM]` |

---

## 🌐 Redes Docker (Networking)

Por padrão, o Docker cria uma rede virtual do tipo **bridge**. Contêineres na mesma rede bridge podem se comunicar uns com os outros usando seus nomes como hostname. Para expor um serviço para fora do host, é necessário o mapeamento de portas (`-p`).

-   **Caso de uso:** Uma aplicação web em um contêiner (`meu-app`) pode se conectar a um banco de dados em outro contêiner (`meu-db`) usando o endereço `http://meu-db:5432`.

---

## 🚀 Além do Contêiner Único: Orquestração

Gerenciar um ou poucos contêineres é simples com `docker`. No entanto, em produção, aplicações são compostas por múltiplos serviços que precisam ser escaláveis, resilientes e detectáveis.

É aqui que entram os **orquestradores de contêineres**.

-   **Docker Compose:** Ferramenta para definir e executar aplicações multi-contêiner em um único host. Ideal para ambientes de desenvolvimento.
-   **Kubernetes (K8s) e Docker Swarm:** Orquestradores completos para gerenciar contêineres em um cluster de múltiplas máquinas. Eles automatizam a implantação, o escalonamento, a recuperação de falhas e o networking complexo.

---

## 📚 Referências Oficiais

-   [Documentação do Docker](https://docs.docker.com/)
-   [Referência do Dockerfile](https://docs.docker.com/engine/reference/builder/)
-   [Boas práticas para escrever Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

---

## 📁 Arquivos Relacionados

-   `../../containers/docker-dockercompose-kubernetes.md` → Guia detalhado sobre Docker, Docker Compose e Kubernetes.

---