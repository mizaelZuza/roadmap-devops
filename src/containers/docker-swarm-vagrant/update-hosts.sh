#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

BACKUP="/etc/hosts.backup.$(date +%Y%m%d_%H%M%S)"

# --- Validacoes pre-execucao ---
[ ! -f Vagrantfile ] && { echo "ERRO: Vagrantfile nao encontrado em $SCRIPT_DIR"; exit 1; }
[ ! -f stack.yml ] && { echo "ERRO: stack.yml nao encontrado em $SCRIPT_DIR"; exit 1; }

# --- Extrai IP do load-balancer ---
LB_IP=$(grep -A5 '"load-balancer"' Vagrantfile \
    | grep -oP 'ip:\s*"\K[\d.]+' \
    | head -1)

[ -z "$LB_IP" ] && { echo "ERRO: IP do load-balancer nao encontrado no Vagrantfile"; exit 1; }

# --- Extrai todos os Host(...) de todos os *.yml ---
HOSTS=$(grep -h -oP 'Host\(`\K[^`]+' *.yml | sort -u | tr '\n' ' ')
[ -z "$HOSTS" ] && { echo "ERRO: Nenhum Host() encontrado nos arquivos .yml"; exit 1; }

# --- Backup ---
sudo cp /etc/hosts "$BACKUP"
echo "Backup criado: $BACKUP"

# --- Remove entradas antigas gerenciadas e adiciona novas ---
sudo sed -i '/# gerenciado-por-swarm-hosts/d' /etc/hosts
echo "$LB_IP $HOSTS # gerenciado-por-swarm-hosts" | sudo tee -a /etc/hosts > /dev/null

echo ""
echo "OK: /etc/hosts atualizado"
echo "    $LB_IP -> $HOSTS"
echo ""
echo "Para restaurar: sudo cp $BACKUP /etc/hosts"
