# 🌐 Ferramentas de Rede: dig, ping, ip, ssh, iperf3

> **Objetivo**
> Este documento detalha cinco ferramentas essenciais para diagnóstico e gerenciamento de redes em sistemas Linux. Cada seção aborda a finalidade, instalação, sintaxe e exemplos práticos.

---

## 1️⃣ `dig` – Domain Information Groper

### 🔍 O que é
`dig` é uma ferramenta poderosa para realizar consultas DNS e obter informações detalhadas sobre registros de domínio (A, MX, NS, TXT, etc.).

### ⚙️ Instalação
```bash
# Debian/Ubuntu
sudo apt update && sudo apt install dnsutils

# CentOS/RHEL/Fedora
sudo yum install bind-utils   # ou dnf install bind-utils

# Arch Linux
sudo pacman -S dnsutils
```

### 📑 Sintaxe Básica
```bash
dig [opções] <domínio> [tipo_de_registro] [@servidor_dns]
```

### 🚀 Exemplos Práticos
| Comando | Descrição |
|---|---|
| `dig google.com` | Consulta o registro A (endereço IPv4) do domínio. |
| `dig google.com MX` | Busca os registros MX (servidores de e-mail). |
| `dig @8.8.8.8 google.com` | Realiza a consulta usando o servidor DNS do Google. |
| `dig +trace google.com` | Mostra o caminho completo da resolução DNS. |
| `dig +short google.com` | Exibe uma resposta curta, apenas com o resultado. |

### 🔧 Opções Úteis
| Opção | Descrição |
|---|---|
| `+short` | Fornece uma saída limpa, ideal para scripts. |
| `+noall +answer` | Exibe apenas a seção de resposta da consulta. |
| `AXFR` | Tenta uma transferência de zona (geralmente restrito). |

### 📌 Quando Usar
- Para diagnosticar problemas de resolução de nomes.
- Para verificar a propagação de alterações de DNS.
- Para auditar a configuração de DNS de um domínio.

---

## 2️⃣ `ping` – Packet Internet Groper

### 🔍 O que é
`ping` envia pacotes ICMP "echo request" para um destino a fim de testar a conectividade e medir a latência (tempo de ida e volta).

### ⚙️ Instalação
```bash
# Debian/Ubuntu
sudo apt update && sudo apt install iputils-ping

# CentOS/RHEL/Fedora
sudo yum install iputils   # ou dnf install iputils

# Arch Linux
sudo pacman -S iputils
```

### 📑 Sintaxe Básica
```bash
ping [opções] <host_ou_ip>
```

### 🚀 Exemplos Práticos
| Comando | Descrição |
|---|---|
| `ping 8.8.8.8` | Envia pacotes contínuos até ser interrompido (Ctrl+C). |
| `ping -c 5 google.com` | Envia exatamente 5 pacotes e encerra. |
| `ping -i 0.5 192.168.1.1` | Define um intervalo de 0.5 segundos entre os pings. |
| `ping -s 1024 google.com` | Altera o tamanho do pacote para 1024 bytes. |

### 🔧 Opções Úteis
| Opção | Descrição |
|---|---|
| `-c <número>` | Define o número de pacotes a serem enviados. |
| `-i <intervalo>` | Especifica o intervalo em segundos entre os pacotes. |
| `-W <tempo>` | Define o tempo de espera por uma resposta (timeout). |
| `-q` | Saída silenciosa, exibe apenas o resumo final. |

### 📌 Quando Usar
- Para verificar se um host está online e acessível.
- Para medir a latência e a perda de pacotes em uma rede.
- Como uma primeira etapa básica no diagnóstico de problemas de conectividade.

---

## 3️⃣ `ip` – iproute2

### 🔍 O que é
O comando `ip` é a ferramenta moderna para visualizar e manipular roteamento, dispositivos de rede, interfaces e túneis. Ele substitui comandos legados como `ifconfig` e `route`.

### ⚙️ Instalação
```bash
# Debian/Ubuntu
sudo apt update && sudo apt install iproute2

# CentOS/RHEL/Fedora
sudo yum install iproute   # ou dnf install iproute

# Arch Linux
sudo pacman -S iproute2
```

### 📑 Sintaxe Básica
```bash
ip [objeto] [comando]
```
- **Objetos comuns**: `addr`, `route`, `link`, `neigh`.

### 🚀 Exemplos Práticos
| Comando | Descrição |
|---|---|
| `ip addr show` | Exibe os endereços IP de todas as interfaces (similar a `ifconfig`). |
| `ip route show` | Mostra a tabela de roteamento do sistema (similar a `route -n`). |
| `ip link set eth0 up` | Ativa a interface de rede `eth0`. |
| `ip neigh show` | Exibe a tabela de vizinhos (cache ARP). |

### 📌 Quando Usar
- Para configurar endereços IP estáticos ou dinâmicos.
- Para gerenciar tabelas de roteamento.
- Para inspecionar o estado das interfaces de rede.

---

## 4️⃣ `ssh` – Secure Shell

### 🔍 O que é
`ssh` é o protocolo e a ferramenta padrão para acessar e gerenciar servidores remotos de forma segura. Ele criptografa toda a comunicação entre o cliente e o servidor.

### ⚙️ Instalação
```bash
# Debian/Ubuntu
sudo apt update && sudo apt install openssh-client

# CentOS/RHEL/Fedora
sudo yum install openssh-clients   # ou dnf install openssh-clients

# Arch Linux
sudo pacman -S openssh
```

### 📑 Sintaxe Básica
```bash
ssh [usuário]@[host] [opções]
```

### 🚀 Exemplos Práticos
| Comando | Descrição |
|---|---|
| `ssh user@192.168.1.100` | Conecta-se ao host `192.168.1.100` com o usuário `user`. |
| `ssh -p 2222 user@host` | Conecta-se a uma porta não padrão (2222). |
| `ssh -i ~/.ssh/chave_priv user@host` | Usa uma chave privada específica para autenticação. |
| `ssh user@host 'ls -l'` | Executa um comando remoto sem iniciar uma sessão interativa. |

### 📌 Quando Usar
- Para administração remota de servidores.
- Para transferir arquivos de forma segura com `scp` ou `sftp`.
- Para criar túneis seguros (port forwarding).

---

## 5️⃣ `iperf3` – Network Bandwidth Measurement

### 🔍 O que é
`iperf3` é uma ferramenta para medir a largura de banda máxima que uma rede pode suportar. Funciona em modo cliente/servidor.

### ⚙️ Instalação
```bash
# Debian/Ubuntu
sudo apt update && sudo apt install iperf3

# CentOS/RHEL/Fedora
sudo yum install iperf3   # ou dnf install iperf3

# Arch Linux
sudo pacman -S iperf3
```

### 📑 Sintaxe Básica
- **Servidor**: `iperf3 -s`
- **Cliente**: `iperf3 -c [ip_do_servidor]`

### 🚀 Exemplos Práticos
| Comando | Descrição |
|---|---|
| `iperf3 -s` | Inicia um servidor `iperf3` na porta padrão (5201). |
| `iperf3 -c 10.0.0.1` | Conecta-se a um servidor `iperf3` em `10.0.0.1` e mede a banda. |
| `iperf3 -c host -R` | Realiza um teste reverso (servidor envia, cliente recebe). |
| `iperf3 -c host -u -b 100M` | Testa a performance UDP com uma banda de 100 Mbits/s. |

### 📌 Quando Usar
- Para validar a capacidade de um link de rede.
- Para diagnosticar problemas de performance em redes locais ou WAN.
- Para comparar a performance de diferentes configurações de rede.

---

## ⚖️ Resumo Comparativo

| Ferramenta | Finalidade Principal | Substitui (Legado) |
|---|---|---|
| `dig` | Consultas e diagnósticos de DNS | `nslookup`, `host` |
| `ping` | Teste de conectividade e latência | - |
| `ip` | Gerenciamento de interfaces e rotas | `ifconfig`, `route`, `arp` |
| `ssh` | Acesso remoto seguro | `telnet`, `rlogin` |
| `iperf3` | Medição de largura de banda | `iperf` (versão antiga) |
