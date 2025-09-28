# Ferramentas

## 1. Docker

### O que é  
O **Docker** é uma plataforma de contêineres que permite empacotar aplicações e suas dependências em unidades leves, portáteis e isoladas. Ele usa a virtualização baseada em kernel para executar múltiplos containers simultaneamente com alto desempenho.

---

### Instalação  

| Distribuição | Comando |
|--------------|---------|
| **Debian/Ubuntu** | `sudo apt-get update && sudo apt-get install -y docker.io` |
| **CentOS/RHEL/Fedora** | `sudo dnf install -y dnf-plugins-core && sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && sudo dnf install -y docker-ce docker-ce-cli containerd.io` |
| **Arch Linux** | `sudo pacman -Syu docker` |

> **Obs.:** Após instalar, habilite e inicie o serviço:  
> ```bash
> sudo systemctl enable --now docker
> ```

---

### Sintaxe básica  

```bash
docker [OPÇÃO] COMANDO ARGS...
```

#### Comandos comuns

| Comando | Descrição |
|---------|-----------|
| `docker run` | Executa um container baseado em uma imagem. |
| `docker ps` | Lista containers ativos. |
| `docker images` | Lista imagens locais. |
| `docker pull` | Baixa uma imagem do registro remoto. |
| `docker build` | Constrói uma imagem a partir de um Dockerfile. |

---

### Exemplos

1. **Executar o Nginx em background**

   ```bash
   docker run -d --name meu-nginx -p 8080:80 nginx
   ```

2. **Listar containers ativos**

   ```bash
   docker ps
   ```

3. **Construir imagem a partir de Dockerfile**

   ```bash
   docker build -t minha-aplicacao .
   ```

4. **Remover um container parado**

   ```bash
   docker rm nome-ou-id-do-container
   ```

---

### Opções úteis

| Coluna (docker ps) | Descrição |
|--------------------|-----------|
| `CONTAINER ID` | Identificador curto do container. |
| `IMAGE` | Nome da imagem usada. |
| `COMMAND` | Comando que foi executado dentro do container. |
| `CREATED` | Quando o container foi criado. |
| `STATUS` | Estado atual (ex.: Up 5m). |
| `PORTS` | Portas mapeadas entre host e container. |
| `NAMES` | Nome atribuído ao container. |

---

### Quando usar

- **Desenvolvimento isolado:** Crie ambientes de teste independentes do sistema operacional principal.
- **CI/CD pipelines:** Automatize builds, testes e deploys em containers consistentes.
- **Micro-serviços:** Execute cada serviço em seu próprio container para escalabilidade horizontal.

---

### Diferenças principais

| Característica | Docker (conteiner) | Docker Compose |
|-----------------|--------------------|----------------|
| **Escopo** | Um único container por comando. | Grupo de containers definidos em `docker-compose.yml`. |
| **Persistência** | Persistência via volumes, bind mounts ou imagens. | Similar, mas facilita a configuração conjunta de múltiplos volumes e redes. |
| **Orquestração** | Não orquestrado (um comando por vez). | Gerencia dependências entre serviços (`depends_on`), redes e volumes automáticos. |

---

## 2. Docker Compose

### O que é  
O **Docker Compose** é uma ferramenta que permite definir, configurar e executar aplicações multi-container usando um único arquivo YAML (`docker-compose.yml`). Ele abstrai a complexidade de múltiplos comandos `docker run`.

---

### Instalação  

| Distribuição | Comando |
|--------------|---------|
| **Debian/Ubuntu** | `sudo apt-get update && sudo apt-get install -y docker.io docker-compose` |
| **CentOS/RHEL/Fedora** | ```bash
> sudo dnf install -y docker-ce docker-ce-cli containerd.io
> curl -L "https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
> chmod +x /usr/local/bin/docker-compose
> ``` |
| **Arch Linux** | `sudo pacman -Syu docker compose` |

> **Obs.:** Se a versão oficial do pacote não estiver atualizada, baixe o binário diretamente do GitHub como mostrado acima.

---

### Sintaxe básica  

```bash
docker compose [OPÇÃO] COMANDO ARGS...
```

#### Comandos principais

| Comando | Descrição |
|---------|-----------|
| `up` | Cria e inicia os serviços definidos. |
| `down` | Para e remove containers, redes e volumes criados pelo Compose. |
| `ps` | Lista os containers gerenciados pelo Compose. |
| `logs` | Exibe logs dos serviços. |

---

### Exemplos

1. **Criar um arquivo `docker-compose.yml`**

   ```yaml
   version: "3.8"
   services:
     web:
       image: nginx:latest
       ports:
         - "8080:80"
     db:
       image: postgres:15
       environment:
         POSTGRES_PASSWORD: secret
       volumes:
         - db-data:/var/lib/postgresql/data

   volumes:
     db-data:
   ```

2. **Iniciar os serviços**

   ```bash
   docker compose up -d
   ```

3. **Parar e remover tudo**

   ```bash
   docker compose down --volumes
   ```

4. **Ver logs do serviço `web`**

   ```bash
   docker compose logs web
   ```

---

### Opções úteis

| Opção | Descrição |
|-------|-----------|
| `-d`, `--detach` | Executa os containers em background. |
| `--build` | Constrói imagens antes de iniciar os serviços. |
| `--remove-orphans` | Remove containers que não estão mais definidos no arquivo Compose. |
| `--scale SERVICE=NUM` | Escala o número de réplicas de um serviço. |

---

### Quando usar

- **Aplicações multi-container:** Gerencie bancos de dados, filas e APIs em conjunto.
- **Ambientes de desenvolvimento local:** Imite a produção com poucos comandos.
- **Integração contínua (CI):** Defina o `docker-compose.yml` para testes automatizados.

---

### Diferenças principais

| Característica | Docker Compose | Docker |
|-----------------|----------------|--------|
| **Definição de stack** | Arquivo YAML (`docker-compose.yml`). | Linha de comando ou Dockerfile. |
| **Orquestração básica** | Gerencia dependências e redes entre serviços. | Não possui orquestração; cada container é gerenciado individualmente. |
| **Escalabilidade simples** | `docker compose scale` para múltiplas réplicas. | Requer scripts ou Docker Swarm/Kubernetes para escala. |

---

## 3. Kubernetes

### O que é  
O **Kubernetes** (k8s) é uma plataforma open-source de orquestração de containers, projetada para automatizar a implantação, escala e operação de aplicações em contêineres distribuídos.

Ele abstrai o ambiente subjacente (servidores físicos ou virtuais), permitindo que você descreva seu estado desejado por meio de manifests YAML e deixe o Kubernetes cuidar da execução.

---

### Instalação (Cluster Local com Minikube)

O **Minikube** é a forma mais simples de rodar um cluster Kubernetes localmente em sua máquina para fins de desenvolvimento e aprendizado.

| Plataforma | Comando de Instalação |
|------------|-----------------------|
| **Linux (x86-64)** | `curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/` |
| **macOS (x86-64)** | `curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/` |
| **Windows (PowerShell)** | `New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force; Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://storage.googleapis.com/minikube/releases/latest/minikube-windows-amd64.exe' -UseBasicParsing` |

> **Nota:** O Minikube é uma ferramenta para desenvolvimento e testes locais. **Não é recomendado para ambientes de produção.** Para produção, considere soluções como `kubeadm` ou serviços gerenciados em nuvem (GKE, EKS, AKS).

Após a instalação, você pode iniciar seu cluster com:
```bash
minikube start
```

---

### Sintaxe básica  

```bash
kubectl [OPÇÃO] COMANDO ARGS...
```

#### Comandos comuns

| Comando | Descrição |
|---------|-----------|
| `apply` | Aplica um manifesto YAML. |
| `get` | Lista recursos (pods, services, deployments). |
| `describe` | Exibe detalhes de um recurso. |
| `delete` | Remove um recurso. |
| `logs` | Mostra logs de pods. |

---

### Exemplos

1. **Criar um Deployment simples**

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx-deploy
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: nginx
     template:
       metadata:
         labels:
           app: nginx
       spec:
         containers:
           - name: nginx
             image: nginx:latest
             ports:
               - containerPort: 80
   ```

   ```bash
   kubectl apply -f deployment.yaml
   ```

2. **Criar um Service para expor o Deployment**

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx-service
   spec:
     selector:
       app: nginx
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
     type: LoadBalancer   # ou NodePort em ambientes locais
   ```

   ```bash
   kubectl apply -f service.yaml
   ```

3. **Ver status dos pods**

   ```bash
   kubectl get pods
   ```

4. **Obter logs de um pod específico**

   ```bash
   kubectl logs <nome-do-pod>
   ```

5. **Escalar manualmente**

   ```bash
   kubectl scale deployment nginx-deploy --replicas=5
   ```

---

### Opções e colunas úteis

| Coluna (`kubectl get pods -o wide`) | Descrição |
|-------------------------------------|-----------|
| `NAME` | Nome do pod. |
| `READY` | Quantidade de containers prontos / total. |
| `STATUS` | Estado atual (Running, Pending, CrashLoopBackOff). |
| `RESTARTS` | Número de reinicializações recentes. |
| `AGE` | Tempo desde que o pod foi criado. |
| `IP` | Endereço IP interno do pod. |

---

### Quando usar

- **Ambientes de produção distribuída:** Orquestração automática de milhares de pods.
- **Escalabilidade dinâmica:** Ajuste automático baseado em métricas (Horizontal Pod Autoscaler).
- **Multi-cluster e híbridos:** Gerencie clusters locais, nuvem pública ou privada a partir de um único `kubectl`.

---

### Diferenças principais vs Docker/Compose

| Característica | Docker / Compose | Kubernetes |
|-----------------|------------------|------------|
| **Escopo** | Containers individuais ou grupos pequenos (dev). | Cluster completo de nós e recursos. |
| **Persistência** | Volumes locais ou bind mounts. | PersistentVolumeClaims + StorageClasses. |
| **Orquestração** | Manual ou via Compose (dependências simples). | Automática, declarativa e extensível (Deployments, StatefulSets). |
| **Escalabilidade** | `docker compose scale` (limite de algumas dezenas). | Autoscaling horizontal/vertical baseado em métricas. |
| **Ambiente** | Host local ou VM isolada. | Cluster distribuído com nós master/control-plane e worker. |

---

### Referências rápidas

- [Kubernetes Docs – kubectl Reference](https://kubernetes.io/docs/reference/kubectl/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Minikube – Instalar um cluster local](https://minikube.sigs.k8s.io/docs/start/)

---

## Conclusão

- Use **Docker** quando precisar de controle granular sobre um único container ou quando a aplicação for pequena.
- Use **Docker Compose** para coordenar vários containers que fazem parte da mesma stack, simplificando o deploy e a manutenção.

> **Dica final:** Mantenha seu `docker-compose.yml` versionado no Git e documente os comandos essenciais (up/down/logs) no README do projeto. Isso garante consistência entre desenvolvedores e pipelines de CI/CD.