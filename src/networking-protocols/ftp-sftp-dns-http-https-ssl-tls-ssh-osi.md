# Ferramentas (Protocolos de Comunicação)

Esta documentação descreve os principais protocolos e ferramentas usados para comunicação na rede.  
Para cada protocolo, são apresentados:

1. **O que é** – breve descrição.  
2. **Instalação** – comandos de instalação nos sistemas mais comuns (`Debian/Ubuntu`, `CentOS/RHEL/Fedora` e `Arch Linux`).  
3. **Sintaxe** – forma básica de usar a ferramenta (ou a sintaxe da chamada HTTP, etc.).  
4. **Exemplos** – exemplos práticos em *code fences*.  
5. **Colunas / Opções** – principais opções/flags disponíveis.  
6. **Quando Usar** – cenários típicos de aplicação.  
7. **Diferenças** – comparações com protocolos relacionados.


---

## HTTP

### O que é
O protocolo HTTP (HyperText Transfer Protocol) permite a transferência de recursos (HTML, imagens, arquivos JSON, etc.) entre cliente e servidor na web. Ele funciona sobre TCP/IP.

### Instalação  
*Ferramentas comuns usadas para testar/usar HTTP: `curl`, `wget`.*

#### Debian/Ubuntu
```bash
# Debian/Ubuntu
sudo apt-get update && sudo apt-get install -y curl wget
```

#### CentOS/RHEL/Fedora
```bash
# CentOS/RHEL/Fedora
sudo yum install -y curl wget     # RHEL/CentOS 7
sudo dnf install -y curl wget     # Fedora, RHEL/CentOS 8+
```

#### Arch Linux
```bash
# Arch Linux
sudo pacman -Syu curl wget
```

### Sintaxe  
```bash
curl [opções] URL
```

### Exemplos  

**GET simples**
```bash
curl https://api.github.com/repos/octocat/Hello-World
```

**POST com corpo JSON**
```bash
curl -X POST \
     -H "Content-Type: application/json" \
     -d '{"name":"teste","value":123}' \
     https://example.com/api/resource
```

### Opções  

| Flag | Descrição |
|------|-----------|
| `-X` | Define o método HTTP (GET, POST, PUT, DELETE, etc.) |
| `-H` | Adiciona cabeçalhos HTTP (`User-Agent`, `Authorization`, etc.) |
| `-d` | Envia dados no corpo da requisição |
| `-I` | Exibe apenas os cabeçalhos de resposta |
| `-L` | Segue redirecionamentos (HTTP 3xx) |
| `--compressed` | Solicita gzip/deflate e descompacta automaticamente |

### Quando Usar  
- Aplicações web que consomem APIs REST.  
- Download ou upload de arquivos via HTTP.  
- Testes rápidos de endpoints.

### Diferenças  
O HTTP é *não‑criptografado*. Para segurança, use **HTTPS** (HTTP sobre TLS).  

---

## HTTPS

### O que é
HTTPS (HTTP Secure) combina HTTP com TLS/SSL para fornecer confidencialidade e integridade dos dados. É o padrão de fato para sites seguros.

### Instalação  
> *A mesma instalação de `curl` e `wget` cobre HTTPS, pois eles já incluem suporte a TLS.*

**Instalação adicional de certificados CA (se necessário)**

#### Debian/Ubuntu
```bash
# Debian/Ubuntu
sudo apt-get install -y ca-certificates
```

#### CentOS/RHEL/Fedora
```bash
# CentOS/RHEL/Fedora
sudo yum install -y ca-certificates   # RHEL/CentOS 7
sudo dnf install -y ca-certificates   # Fedora, RHEL/CentOS 8+
```

#### Arch Linux
```bash
# Arch Linux
sudo pacman -Syu ca-certificates
```

### Sintaxe  
Identica ao HTTP: `curl`/`wget` com URLs que começam em `https://`.

### Exemplos  

**GET seguro**
```bash
curl https://api.github.com/repos/octocat/Hello-World
```

**Verificar certificado TLS**
```bash
openssl s_client -connect example.com:443 -servername example.com
```

### Opções  
Além das opções de HTTP, pode usar:

| Flag | Descrição |
|------|-----------|
| `--cert` | Caminho para um certificado cliente (PEM) |
| `--key`  | Chave privada correspondente ao certificado |
| `--cacert` | Arquivo com certificados CA customizados |

### Quando Usar  
- Transações financeiras ou de dados sensíveis.  
- Sites que exigem autenticação do usuário (`HTTPS` é obrigatório).  

### Diferenças  
HTTPS = HTTP + TLS/SSL. Se o servidor não suportar TLS, a conexão falhará.

---

## FTP / SFTP

> **Nota**: FTP (File Transfer Protocol) funciona em texto claro e pode usar portas 20/21; **SFTP** (SSH File Transfer Protocol) é seguro, operando sobre SSH na porta 22.

### O que é  
- **FTP**: protocolo padrão de transferência de arquivos.  
- **SFTP**: variante segura baseada em SSH, evita a exposição de credenciais e dados.

### Instalação  

#### Debian/Ubuntu
```bash
# Debian/Ubuntu
sudo apt-get install -y ftp openssh-client   # ftp + sftp (ssh)
```

#### CentOS/RHEL/Fedora
```bash
# CentOS/RHEL/Fedora
sudo yum install -y ftp openssh-clients    # RHEL/CentOS 7
sudo dnf install -y ftp openssh-clients    # Fedora, RHEL/CentOS 8+
```

#### Arch Linux
```bash
# Arch Linux
sudo pacman -Syu ftp openssh
```

### Sintaxe  

**FTP**
```bash
ftp [opções] host
```

**SFTP**
```bash
sftp [opções] usuário@host
```

### Exemplos  

**FTP (texto claro)**
```bash
ftp example.com
# login: usuario
# senha: ********
put localfile.txt remotefile.txt
quit
```

**SFTP (seguro)**
```bash
sftp -P 2222 user@example.com
# > put localfile.txt
# > get remotefile.txt
# > exit
```

### Opções  

| Ferramenta | Flag | Descrição |
|------------|------|-----------|
| `ftp` | `-v` | Verbose (exibe todas as interações) |
| `sftp` | `-P` | Porta personalizada (padrão 22) |
| `sftp` | `-o ProxyJump=host:port` | Usa SSH Jump Host |

### Quando Usar  
- **FTP**: quando o servidor legado exige FTP e não há requisitos de segurança estrita.  
- **SFTP**: quando a transferência segura é necessária (dados sensíveis, ambientes corporativos).

### Diferenças  
- **Segurança**: FTP transmite tudo em texto; SFTP usa criptografia SSH.  
- **Portas**: 20/21 vs 22.  

---

## DNS

### O que é
DNS (Domain Name System) resolve nomes de domínio legíveis (`example.com`) para endereços IP e vice‑versa.

### Instalação  

#### Debian/Ubuntu
```bash
# Debian/Ubuntu
sudo apt-get install -y bind9-utils dnsutils
```

#### CentOS/RHEL/Fedora
```bash
# CentOS/RHEL/Fedora
sudo yum install -y bind-utils            # RHEL/CentOS 7
sudo dnf install -y bind-utils            # Fedora, RHEL/CentOS 8+
```

#### Arch Linux
```bash
# Arch Linux
sudo pacman -Syu bind dnsutils
```

### Sintaxe  

**Consulta simples (dig)**
```bash
dig @servidor tipo nome
```

**Exemplo de resolução de domínio**
```bash
dig example.com A
```

### Exemplos  

**Obter registros MX**
```bash
dig example.com MX
```

**Verificar servidor autoritativo**
```bash
dig @ns1.example.com example.com NS +noall +answer
```

### Opções  

| Flag | Descrição |
|------|-----------|
| `@servidor` | Especifica o servidor DNS a consultar |
| `+short` | Resposta curta (apenas valores) |
| `+trace` | Mostra caminho completo da resolução |
| `+noall +answer` | Exibe apenas a seção de resposta |

### Quando Usar  
- Diagnóstico de conectividade de rede.  
- Configuração de serviços que dependem de DNS (web, e‑mail).  

### Diferenças  
DNS não é um protocolo de transferência de arquivos; ele resolve nomes para endereços IP.  

---

## SSL/TLS

> **SSL** (Secure Sockets Layer) foi substituído por **TLS** (Transport Layer Security), mas o termo ainda aparece nas documentações.

### O que é
Conjunto de protocolos criptográficos que garantem confidencialidade, integridade e autenticidade em comunicações TCP. Usado principalmente por HTTPS, SMTPS, IMAPS, etc.

### Instalação  

#### Debian/Ubuntu
```bash
# Debian/Ubuntu
sudo apt-get install -y openssl
```

#### CentOS/RHEL/Fedora
```bash
# CentOS/RHEL/Fedora
sudo yum install -y openssl          # RHEL/CentOS 7
sudo dnf install -y openssl          # Fedora, RHEL/CentOS 8+
```

#### Arch Linux
```bash
# Arch Linux
sudo pacman -Syu openssl
```

### Sintaxe  

**Verificar certificado**
```bash
openssl s_client -connect host:443 -servername host
```

**Gerar chave RSA de 2048 bits**
```bash
openssl genrsa -out key.pem 2048
```

### Exemplos  

**Obter informações do certificado TLS**
```bash
openssl x509 -in cert.pem -text -noout
```

**Criar CSR (Certificate Signing Request)**
```bash
openssl req -new -key key.pem -out request.csr
```

### Opções  

| Comando | Flag | Descrição |
|---------|------|-----------|
| `s_client` | `-connect host:port` | Conecta ao servidor TLS |
| `s_client` | `-servername name` | HSTS/ALPN (Server Name Indication) |
| `x509` | `-text` | Exibe detalhes do certificado |
| `genrsa` | `-out arquivo.pem 2048` | Gera chave privada RSA |

### Quando Usar  
- Configuração de HTTPS em servidores web.  
- Criptografia de dados sensíveis em outras aplicações que suportam TLS.

### Diferenças  
SSL/TLS não é um protocolo de aplicação; ele fornece a camada de segurança subjacente para HTTP, SMTP, etc.

---

## SSH (Secure Shell)

### O que é
O **SSH** é um protocolo de rede que permite acesso remoto seguro a sistemas Unix-like (Linux, macOS) e Windows. Ele fornece autenticação criptografada e confidencialidade dos dados transmitidos, substituindo protocolos antigos como Telnet e rlogin.

---

#### Instalação

| Sistema | Comando |
|---------|---------|
| **Debian/Ubuntu** | `sudo apt update && sudo apt install openssh-client openssh-server` |
| **CentOS/RHEL/Fedora** | `sudo yum install openssh-clients openssh-server` *(ou `dnf` em versões mais recentes)* |
| **Arch Linux** | `sudo pacman -S openssh` |

> **Observação:**  
> 1. O *client* (`openssh-client`) já vem pré‑instalado na maioria das distribuições.  
> 2. Para habilitar o servidor SSH, rode: `sudo systemctl enable --now sshd`.

---

#### Sintaxe

**Conectar**
```bash
ssh [opções] usuário@host
```

**Copiar arquivo (scp)**
```bash
scp localfile.txt usuário@host:/caminho/destino/
```

- `<usuário>` – nome de usuário remoto (pode ser omitido se for igual ao local).  
- `<host>` – endereço IP ou domínio.  
- `[comando]` – comando opcional a ser executado no host remoto; caso não seja informado, abre‑se uma sessão interativa.

---

#### Exemplos

| Caso | Comando | Saída esperada |
|------|---------|----------------|
| **Conexão básica** | `ssh alice@192.168.1.10` | Prompt de senha → terminal remoto |
| **Usar porta customizada** | `ssh -p 2222 bob@example.com` | Conecta‑se na porta 2222 |
| **Chave pública (autenticação sem senha)** | `ssh -i ~/.ssh/id_rsa alice@server.com` | Conexão automática se a chave estiver autorizada |
| **Execução de comando remoto** | `ssh root@host "df -h"` | Exibe o uso do disco no host remoto |
| **Túnel reverso (port forwarding)** | `ssh -R 8080:localhost:80 user@remote` | Redireciona a porta 8080 do remoto para a porta 80 local |

---

#### Opções Comuns

| Opção | Significado | Exemplo |
|-------|-------------|---------|
| `-p <porta>` | Define porta SSH | `ssh -p 2222 user@host` |
| `-i <arquivo_chave>` | Usa chave privada específica | `ssh -i ~/.ssh/id_ed25519 user@host` |
| `-v`, `-vv`, `-vvv` | Verbose (debug) | `ssh -vvv user@host` |
| `-C` | Ativa compressão | `ssh -C user@host` |
| `-X`, `-Y` | Habilita X11 forwarding | `ssh -X user@host` |
| `-L <local_port>:<remote_host>:<remote_port>` | Local port forwarding | `ssh -L 3306:db.internal:3306 user@gateway` |
| `-R <remote_port>:<local_host>:<local_port>` | Remote port forwarding | `ssh -R 80:localhost:8080 user@server` |

---

#### Quando usar

1. **Administração Remota** – login seguro em servidores e switches.  
2. **Execução de Scripts/Comandos** – automatização via SSH com `-oBatchMode=yes`.  
3. **Túnel VPN Simples** – port forwarding para acessar serviços internos (ex.: banco de dados).  
4. **Transferência Segura** – `scp`, `sftp` ou `rsync -e ssh`.  
5. **Autenticação Baseada em Chaves** – ambientes com alta exigência de segurança.

---

## Modelo OSI (Open Systems Interconnection)

> **Nota:** O Modelo OSI não é um software, mas uma arquitetura conceitual que descreve como dados são transmitidos entre dispositivos de rede. Ele serve como referência para a padronização e design de protocolos de comunicação.

### O que é
O Modelo OSI define **sete camadas** que organizam as funções da comunicação em redes:

1. **Camada Física (Physical)** – transmissão física dos bits (cabo, conector).  
2. **Camada de Enlace de Dados (Data Link)** – controle de acesso ao meio e correção de erros.  
3. **Camada de Rede (Network)** – roteamento e endereçamento lógico (IP).  
4. **Camada de Transporte (Transport)** – entrega confiável ou não, controle de fluxo.  
5. **Camada de Sessão (Session)** – estabelecimento, manutenção e encerramento de sessões.  
6. **Camada de Apresentação (Presentation)** – tradução, compressão, criptografia.  
7. **Camada de Aplicação (Application)** – interfaces para aplicações do usuário final.

---

#### Exemplos Práticos

| Camada | Protocolo/Serviço Comum | Exemplo |
|--------|-------------------------|---------|
| 1 – Física | Ethernet (cabo RJ45) | Conector e transmissão de bits |
| 2 – Enlace | MAC (IEEE 802.3) | Endereçamento físico, CSMA/CD |
| 3 – Rede | IP, ICMP | Roteamento entre sub‑redes |
| 4 – Transporte | TCP, UDP | Conexão orientada vs não‑orientada |
| 5 – Sessão | NetBIOS, RPC | Controle de sessão em aplicações |
| 6 – Apresentação | SSL/TLS, JPEG | Criptografia e compressão |
| 7 – Aplicação | HTTP, FTP, SSH | Interfaces para usuários |

---

#### Opções (Resumo das Funções)

| Camada | Responsabilidade Principal | Protocolos Relevantes |
|--------|----------------------------|-----------------------|
| 1 | Transmissão física de bits | Ethernet, Wi‑Fi, Bluetooth |
| 2 | Controle de erro e acesso ao meio | MAC, PPP, VLAN |
| 3 | Endereçamento lógico & roteamento | IP, ICMP, OSPF |
| 4 | Entrega confiável & controle de fluxo | TCP, SCTP, UDP |
| 5 | Gerenciamento de sessões | NFS, SMB, RPC |
| 6 | Conversão e segurança da informação | TLS/SSL, JPEG, GIF |
| 7 | Serviços finais para usuários | SMTP, FTP, SSH |

---

#### Quando usar

- **Análise de Redes** – identificar onde um problema ocorre (ex.: falha na camada física vs. aplicação).  
- **Design de Protocolos** – estruturar novos protocolos em camadas lógicas.  
- **Educação e Treinamento** – ensinar fundamentos de networking a estudantes e profissionais.

---

## Resumo

- **Modelo OSI** fornece a base conceitual que orienta o entendimento de como os dados são processados nas redes, facilitando diagnóstico e desenvolvimento de protocolos.