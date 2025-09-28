# 📊 Ferramentas de Monitoramento: `vmstat` e `free`

> **Objetivo**  
> Este documento descreve as duas utilidades clássicas de *monitoramento* em sistemas Linux/Unix, apresentando sua finalidade, sintaxe básica, colunas principais, exemplos práticos e quando cada uma deve ser empregada.

---

## 🛠️ 1. `vmstat` - Virtual Memory Statistics

### 🔍 O que é
`vmstat` exibe estatísticas de uso da CPU, memória, processos e I/O em tempo real ou por intervalo. É ideal para identificar gargalos de **CPU**, **memória**, **swap** e **disco**.

### 📦 Instalação
```bash
# Debian/Ubuntu
sudo apt-get update && sudo apt-get install sysstat

# CentOS/RHEL/Fedora
sudo yum install sysstat   # ou dnf em versões mais recentes

# Arch Linux
sudo pacman -S sysstat
```

> **Observação**: Em algumas distribuições, o `vmstat` já vem instalado por padrão.

### 📑 Sintaxe Básica
```bash
vmstat [intervalo] [número_de_vezes]
```
- **intervalo**: segundos entre relatórios (ex.: `1`).
- **número_de_vezes**: quantos relatórios exibir.  
  Se omitido, continua indefinidamente.

### ⚡ Exemplo de Uso
```bash
# Relatório em tempo real a cada 2 segundos, 5 vezes
vmstat 2 5
```

### 📊 Principais Colunas

| Grupo | Coluna | Descrição |
|-------|--------|-----------|
| **procs** | `r` | Processos prontos para executar (fila da CPU). |
| | `b` | Processos em espera bloqueados por I/O. |
| **memory** | `free` | Memória livre. |
| | `buff/cache` | Memória usada como buffers e cache. |
| **swap** | `si/so` | Páginas que entram (`si`) ou saem (`so`) do swap. Se > 0, pode indicar falta de RAM. |
| **cpu** | `us` | Tempo gasto em processos de usuário. |
| | `sy` | Tempo gasto em código do kernel. |
| | `id` | Tempo ocioso da CPU. |
| | `wa` | Tempo esperando por I/O (I/O-bound). |

### 📌 Quando Usar
- Detectar **lentidão geral**: CPU 100%, I/O preso, uso de swap elevado.
- Diagnosticar problemas de **processos em espera** (`b > 0`).
- Avaliar o impacto de operações de disco em tempo real.

---

## 🛠️ 2. `free` - Estatísticas de Memória

### 🔍 O que é
`free` exibe estatísticas rápidas do uso da memória RAM e swap, sendo mais simples e direto que o `vmstat`.

### 📑 Sintaxe Básica
```bash
free [opções]
```
- **-h** | Exibe valores em formato legível (KB/MB/GB).
- **-m** | Em megabytes.
- **-g** | Em gigabytes.

### ⚡ Exemplo de Uso
```bash
# Saída legível
free -h
```

### 📊 Principais Campos

| Campo | Descrição |
|-------|-----------|
| `total` | Memória total do sistema. |
| `used` | Memória usada (inclui cache, que pode ser liberado). |
| `free` | Memória realmente livre. |
| `buff/cache` | Memória em buffers e cache (pode ser liberada se necessário). |
| `available` | Memória disponível para novos processos - métrica mais confiável do que `free`. |

### 📌 Quando Usar
- Verificar rapidamente se a máquina está com **falta de memória**.
- Avaliar o efeito de aplicações que consomem muita RAM.

---

## ⚖️ Diferença Entre `vmstat` e `free`

| Aspecto | `vmstat` | `free` |
|---------|----------|--------|
| Visão | Ampla (CPU, processos, memória, I/O) | Focada em memória RAM + swap |
| Complexidade | Mais detalhada, múltiplas colunas | Simples, poucos campos |
| Uso recomendado | Análise de performance geral | Verificação rápida de consumo de memória |

---

## 💡 Dicas Práticas

- **Performance geral** -> use `vmstat` para identificar a origem (CPU, I/O, swap).
- **Memória específica** -> use `free` ou `top -M` para foco em RAM.
- Combine as duas ferramentas: por exemplo, `vmstat 1 | grep "0 0"` para ver quando não há processos bloqueados nem I/O pendente.

---

> **Resumo**  
> *`vmstat`* oferece uma visão completa de recursos do sistema, ideal para diagnósticos profundos. *`free`* fornece métricas rápidas de memória, útil em verificações pontuais. Ambas são essenciais no conjunto de ferramentas de monitoramento Linux.