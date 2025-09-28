```markdown
# lsof – List Open Files

> **Definição**  
> `lsof` (List Open Files) é uma ferramenta de linha de comando que lista todos os arquivos abertos por processos em sistemas Linux/Unix, incluindo sockets, pipes e dispositivos.

---

## 📌 Propósito Principal

| Área | O que o lsof ajuda a fazer |
|------|---------------------------|
| **Monitoramento** | Ver quais arquivos, portas e dispositivos um processo está usando. |
| **Diagnóstico de Rede** | Descobrir qual processo está escutando em uma porta específica (`lsof -i :80`). |
| **Resolução de Conflitos** | Identificar qual processo mantém um arquivo travado (ex.: para liberar arquivos bloqueados). |
| **Segurança** | Verificar conexões abertas inesperadas ou arquivos acessados por processos suspeitos. |
| **Administração** | Entender dependências entre processos, arquivos e usuários. |

---

## ⚙️ Instalação

```bash
# Debian/Ubuntu
sudo apt-get update && sudo apt-get install lsof

# CentOS/RHEL/Fedora
sudo yum install lsof   # ou dnf em versões mais recentes

# Arch Linux
sudo pacman -S lsof
```

---

## 📑 Sintaxe Básica

```bash
lsof [opções] [arquivo|processo]
```

- **Sem argumentos**: lista todos os arquivos abertos.
- **`-i`**: filtra por conexões de rede.
- **`-u <user>`**: mostra arquivos abertos pelo usuário especificado.
- **`-p <pid>`**: mostra arquivos abertos por um PID específico.

---

## 🚀 Exemplos Práticos

| Exemplo | Descrição |
|---------|-----------|
| `lsof -i :80` | Lista processos que estão escutando na porta 80. |
| `lsof -u root` | Mostra todos os arquivos abertos pelo usuário **root**. |
| `lsof -p 1234` | Exibe arquivos usados pelo processo com PID 1234. |
| `lsof +D /var/www/html` | Recursivamente lista arquivos dentro do diretório `/var/www/html`. |
| `lsof | grep "txt"` | Filtra resultados que contêm a string “txt”. |

---

## 🔧 Opções Úteis

| Flag | Descrição |
|------|-----------|
| `-n` | Não resolve endereços IP em nomes de host (mais rápido). |
| `-P` | Exibe portas numéricas em vez de serviços. |
| `-s` | Filtra por estado da conexão (`ESTABLISHED`, `LISTENING`, etc.). |
| `-t` | Apenas retorna PIDs, útil em scripts. |
| `-c <char>` | Filtra processos cujo nome começa com a string fornecida. |

---

## 📚 Uso em Scripts

```bash
#!/bin/bash
# Exemplo: encontrar e terminar processo que está bloqueando um arquivo

FILE="/var/lib/mysql/data.ibd"
PID=$(lsof -t "$FILE")
if [[ -n $PID ]]; then
  echo "Processo $PID bloqueia $FILE. Terminando..."
  kill -9 $PID
else
  echo "Nenhum processo bloqueando $FILE."
fi
```

---

## 📌 Dicas de Segurança

- **Evite executar `lsof` como root** quando não for necessário; privilégios elevados podem exibir informações sensíveis.
- Combine com `netstat`, `ss` ou `tcpdump` para análise aprofundada de tráfego.

---

## 🎓 Referências Adicionais

- Manual: `man lsof`
- Documentação oficial: https://linux.die.net/man/8/lsof
- Tutoriais online e exemplos de uso em blogs especializados.

--- 
