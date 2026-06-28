#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

ERROS=0
AVISOS=0

println() { printf "  %s\\n" "$1"; }
sucesso() { println "  [OK]   $1"; }
erro()   { println "  [ERR]  $1"; ERROS=$((ERROS+1)); }
aviso()  { println "  [AVISO] $1"; AVISOS=$((AVISOS+1)); }

echo ""
echo "=============================================="
echo "  Validacao do ambiente Swarm Hosts"
echo "=============================================="
echo ""

# --- 1. Arquivos existem? ---
echo "--- Arquivos necessarios ---"
[ -f Vagrantfile ] && sucesso "Vagrantfile encontrado" || erro "Vagrantfile nao encontrado"
[ -f stack.yml ]   && sucesso "stack.yml encontrado"   || aviso "stack.yml nao encontrado (verificando .yml)"
[ -f update-hosts.sh ] && sucesso "update-hosts.sh encontrado" || aviso "update-hosts.sh nao encontrado (mas nao e obrigatorio)"

if [ $ERROS -gt 0 ]; then
    echo ""
    echo "  Arquivos obrigatorios faltando. Abortando."
    echo "=============================================="
    exit 1
fi

# --- 2. Extrai IP do load-balancer ---
echo ""
echo "--- Load Balancer ---"
LB_IP=$(grep -A5 '"load-balancer"' Vagrantfile | grep -oP 'ip:\s*"\K[\d.]+' | head -1)

if [ -n "$LB_IP" ]; then
    sucesso "IP do load-balancer: $LB_IP"
else
    erro "Nenhum IP encontrado para load-balancer no Vagrantfile"
fi

# --- 3. Extrai Hosts do stack.yml ---
echo ""
echo "--- Dominios no stack.yml ---"
HOSTS=$(grep -h -oP 'Host\(`\K[^`]+' *.yml | sort -u)

if [ -n "$HOSTS" ]; then
    while IFS= read -r host; do
        sucesso "Host encontrado: $host"
    done <<< "$HOSTS"
else
    erro "Nenhum Host() encontrado nos arquivos .yml"
fi

# --- 4. Verifica formato das linhas ---
echo ""
echo "--- Consistencia ---"

# Cada Host() deve ter um traefik.enable=true correspondente no mesmo servico
LABELS=$(grep -h -c 'traefik.enable=true' *.yml | awk -F: '{s+=$NF}END{print s}')
ROUTERS=$(grep -h -cP 'Host\(`' *.yml | awk -F: '{s+=$NF}END{print s}')
[ "$LABELS" -eq "$ROUTERS" ] && sucesso "Cada servico com Host() tem traefik.enable (${LABELS}/${ROUTERS})" \
                               || aviso "Servicos com Host(): ${ROUTERS}, traefik.enable: ${LABELS}"

# --- 5. Dry-run: mostra o que seria escrito ---
echo ""
echo "--- Dry-run do /etc/hosts ---"
echo ""
if [ -n "$LB_IP" ] && [ -n "$HOSTS" ]; then
    HOSTS_LINE=$(echo "$HOSTS" | tr '\n' ' ')
    println "Linha a ser adicionada:"
    println ""
    println "  $LB_IP $HOSTS_LINE# gerenciado-por-swarm-hosts"
    println ""
    println "Entradas antigas com '# gerenciado-por-swarm-hosts' serao removidas."
else
    erro "Nao foi possivel montar a linha de dry-run"
fi

# --- 6. Backup test (simula) ---
echo ""
echo "--- Backup ---"
BACKUP="/etc/hosts.backup.$(date +%Y%m%d_%H%M%S)"
println "Backup seria criado em: $BACKUP"
println ""

# --- 7. Resumo ---
echo "=============================================="
if [ $ERROS -gt 0 ]; then
    echo "  $ERROS erro(s) encontrado(s). Corrija antes de aplicar."
    echo "=============================================="
    exit 1
else
    echo "  Validacao concluida com ${AVISOS} aviso(s)."
    echo "  Tudo pronto para aplicar."
    echo "=============================================="
    echo ""
    echo "Para aplicar: ./update-hosts.sh"
    echo ""
    exit 0
fi
