# Swarm Cluster Local com Vagrant, Docker Swarm, Traefik e Portainer

## Problema Resolvido

Desenvolvedores precisam testar aplicacoes containerizadas em um **cluster Swarm multi-nó** antes de ir para producao. Montar esse ambiente manualmente é:

- **Lento**: instalar SO, Docker, configurar Swarm, proxy reverso, monitoramento
- **Inconsistente**: cada maquina configurada de um jeito
- **Caro**:多云 VMs ou maquinas fisicas dedicadas

Esta solucao entrega **4 VMs locais via Vagrant + libvirt/KVM** com:

| Componente | Funcao |
|------------|--------|
| 3 Managers | Cluster Docker Swarm (alta disponibilidade) |
| 1 Load Balancer | HAProxy com SSL terminando na porta 443 |
| Traefik | Proxy reverso interno (rota por hostname) |
| Portainer | Painel web para gerenciar o cluster |
| App exemplo | nginxdemos/hello exposto via `app1.swarm.lan` |

Tudo rodando na sua maquina via KVM (libvirt), sem depender de nuvem.

---

## Arquitetura

```
Seu Navegador
     |
     | HTTP/HTTPS
     v
192.168.56.10 (load-balancer)  ← HAProxy (SSL, round-robin)
     |
     +---> 192.168.56.11 (swarm-manager1)
     |         └── Traefik (proxy reverso)
     |              ├── app1.swarm.lan  →  meu-app (nginx)
     |              ├── app2.swarm.lan  →  meu-app2 (nginx)
     |              └── portainer.swarm.lan → Portainer
     |
     +---> 192.168.56.12 (swarm-manager2)
     |
     +---> 192.168.56.13 (swarm-manager3)
```

Fluxo da requisicao:
```
Browser → HAProxy:443 → Manager:80 → Traefik → app container
```

---

## Pre-requisitos

### Maquina Host

| Requisito | Versao minima |
|-----------|---------------|
| Linux (testado em Manjaro/Arch) | Kernel 6.x |
| libvirt + KVM | qemu 11.x |
| Vagrant | 2.4.x |
| VirtualBox | Removido (conflita com KVM) |

### Pacotes necessarios (Arch/Manjaro)

```bash
sudo pacman -S vagrant libvirt dnsmasq qemu-system-x86
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
# Faca logout e login novamente
```

### Plugin Vagrant

```bash
vagrant plugin install vagrant-libvirt
```

---

## Estrutura de Arquivos

```
docker-swarm/
├── Vagrantfile              # 4 VMs (3 managers + load-balancer)
├── stack.yml                # Stack principal: Traefik + apps
├── portainer-stack.yml      # Stack do Portainer
├── update-hosts.sh          # Script para atualizar /etc/hosts
├── validate-update.sh       # Validacao do script de hosts
└── README.md                # Este arquivo
```

---

## Passo a Passo

### 1. Subir as VMs

```bash
cd docker-swarm
vagrant up --provider=libvirt
```

Aguarde ~5 minutos. As 4 VMs serao criadas e provisionadas com Docker e HAProxy.

### 2. Inicializar o Swarm

```bash
vagrant ssh swarm-manager1
docker swarm init --advertise-addr 192.168.56.11
```

Copie o token de manager exibido e execute nos outros nos:

```bash
vagrant ssh swarm-manager2
docker swarm join --token <TOKEN-MANAGER> 192.168.56.11:2377

vagrant ssh swarm-manager3
docker swarm join --token <TOKEN-MANAGER> 192.168.56.11:2377
```

Verifique:

```bash
docker node ls
# ID          HOSTNAME         STATUS   MANAGER STATUS
# u6i695... * swarm-manager1   Ready    Leader
# pgix6w...   swarm-manager2   Ready    Reachable
# cmbmcc...   swarm-manager3   Ready    Reachable
```

### 3. Fazer o deploy da Stack principal

```bash
vagrant ssh swarm-manager1
cd stack
docker stack deploy -c stack.yml meu-cluster
```

Verifique:

```bash
docker service ls
# NAME                  MODE       REPLICAS  IMAGE
# meu-cluster_meu-app   replicated 3/3       nginxdemos/hello:plain-text
# meu-cluster_meu-app2  replicated 3/3       nginxdemos/hello:plain-text
# meu-cluster_traefik   replicated 1/1       traefik:latest
```

### 4. Fazer o deploy do Portainer

```bash
cd /home/vagrant/stack
curl -L https://downloads.portainer.io/ce2-19/portainer-agent-stack.yml \
  -o portainer-agent-stack.yml
docker stack deploy -c portainer-agent-stack.yml portainer
```

> **ATENCAO**: Nao use `curl https://portainer.io` — isso baixa o site HTML, nao o YAML!

**Ou** use o arquivo customizado deste projeto (com integracao Traefik):

```bash
docker stack deploy -c portainer-stack.yml portainer
```

### 5. Atualizar o /etc/hosts da maquina host

Para acessar os servicos pelo nome, execute no **host** (nao na VM):

```bash
./validate-update.sh   # Simula e valida antes
./update-hosts.sh      # Aplica (pede sudo)
```

Isso adicionara:

```
192.168.56.10 app1.swarm.lan app2.swarm.lan portainer.swarm.lan
```

### 6. Acessar os servicos

| URL | Servico |
|-----|---------|
| `https://app1.swarm.lan` | App 1 (nginx) |
| `https://app2.swarm.lan` | App 2 (nginx) |
| `https://portainer.swarm.lan` | Portainer Web UI |
| `http://192.168.56.11:8080` | Dashboard Traefik (debug) |

No primeiro acesso ao Portainer, crie o usuario admin.

---

## Comandos uteis

### Gerenciamento das VMs

```bash
vagrant up --provider=libvirt     # Iniciar VMs
vagrant halt                      # Desligar VMs
vagrant destroy -f                # Destruir VMs (perde dados)
vagrant provision load-balancer   # Reprovisionar apenas o LB
vagrant ssh swarm-manager1        # SSH no manager 1
```

### Gerenciamento do Swarm

```bash
# Via SSH
vagrant ssh swarm-manager1 -c "docker service ls"
vagrant ssh swarm-manager1 -c "docker node ls"

# Via DOCKER_HOST remoto (host)
export DOCKER_HOST="ssh://vagrant@192.168.56.11"
docker service ls
docker node ls
unset DOCKER_HOST  # Voltar ao Docker local

# Ou via alias
alias dswarm='docker --host ssh://vagrant@192.168.56.11'
dswarm service ls
```

### Logs

```bash
vagrant ssh swarm-manager1 -c "docker service logs meu-cluster_traefik --tail 50"
vagrant ssh swarm-manager3 -c "docker service logs portainer_portainer --tail 50"
```

---

## Solucao de Problemas

### HAProxy nao sobe

```bash
vagrant ssh load-balancer
sudo haproxy -f /etc/haproxy/haproxy.cfg -c   # Validar config
sudo systemctl status haproxy                  # Ver status
sudo journalctl -u haproxy -n 30               # Ver logs
```

Erros comuns:
- Nome de backend com acentos (`nos_do_swarm` → `cluster_swarm`)
- Cipher SSL invalido (`PROFILE=SYSTEM` → lista explicita)
- Health check HTTP sem header Host (404 do Traefik)

### Traefik nao descobre servicos

```bash
curl -s http://192.168.56.11:8080/api/http/routers | python3 -m json.tool
```

Se o router `app1-rota@swarm` nao aparecer:
1. Verifique se os labels estao no servico e nao no container
2. Verifique se o provider Swarm esta ativo (`--providers.swarm=true`)
3. Verifique se Traefik e o servico estao na mesma overlay network
4. Nomes de router e service precisam ser **unicos** entre servicos

### Portainer: network not found

```bash
# Se usar external network, precisa do nome exato
docker network ls --filter scope=swarm
# Use `name: meu-cluster_public-net` no stack yml
```

### Conflito VirtualBox × KVM

```bash
# Remova o VirtualBox
sudo pacman -Rns virtualbox virtualbox-host-dkms
sudo rmmod vboxdrv vboxnetadp vboxnetflt
```

O modulo `vboxdrv` compete com `kvm_intel` pelo VT-x, impedindo novas VMs KVM de bootar.

---

## Scripts de Automacao

### update-hosts.sh

Extrai automaticamente do `Vagrantfile` e dos `*.yml`:

1. IP do load-balancer (maquina com nome "load-balancer")
2. Todos os `Host(...)` dos arquivos YML
3. Faz backup do `/etc/hosts`
4. Adiciona/atualiza as entradas

Uso:

```bash
./validate-update.sh  # Validar (nao altera nada)
./update-hosts.sh     # Aplicar
```

Funciona com qualquer projeto que siga a mesma estrutura (Vagrantfile + YMLs com labels Traefik).

---

## Notas Tecnicas

### Provider: libvirt (KVM) ao inves de VirtualBox

- **KVM** é nativo do Linux, mais performatico e estavel
- **VirtualBox** requer DKMS, conflita com KVM pelo VT-x
- O Vagrantfile usa `v.cpu_mode = "host-model"` para compatibilidade com QEMU 11.x

### Rede

- `192.168.56.0/24` — rede interna entre as VMs (criada pelo libvirt)
- As VMs tambem tem uma interface NAT (`192.168.121.x`) para acesso a internet
- O HAProxy no `load-balancer` é o ponto de entrada unico

### Seguranca

- HAProxy com SSL auto-assinado (para desenvolvimento)
- HTTP redireciona para HTTPS (301)
- Traefik com `exposedbydefault=false` — só expoe servicos com label explicita
- Portainer com `--tlsskipverify` (apenas dev)
