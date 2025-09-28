# Ferramentas: **AWK**, **STDIN**, **STDOUT** e **STDERR**

> Este documento descreve de forma prática cada ferramenta/conceito, mostrando como instalá‑las (quando necessário), sua sintaxe básica, exemplos de uso, opções mais relevantes, cenários ideais para aplicação e diferenças entre elas.

---

## AWK

### O que é
`awk` é uma linguagem de programação voltada ao processamento de texto baseada em padrões. Ela lê um arquivo linha por linha, divide cada linha em campos (por padrão, separados por espaços ou tabulações) e executa ações sobre esses campos. Muito usada para extrair colunas, filtrar registros, somar valores, etc.

### Instalação

| Sistema | Comando |
|---------|---------|
| **Debian/Ubuntu** | `sudo apt-get update && sudo apt-get install -y awk` <br>*(o pacote é `gawk`, mas o comando `awk` já está disponível)* |
| **CentOS/RHEL/Fedora** | `sudo yum install -y gawk` (ou `dnf install -y gawk` em Fedora) |
| **Arch Linux** | `sudo pacman -Syu gawk` |

> **Observação:** A maioria das distribuições já vem com o `awk` instalado por padrão, mas se precisar atualizar para a última versão, basta usar os comandos acima.

### Sintaxe básica

```bash
awk 'PATTERN { ACTION }' arquivo.txt
```

- **PATTERN**: expressão regular que identifica linhas a serem processadas.  
- **ACTION**: código `awk` executado quando o padrão corresponde (ex.: imprimir campos, somar valores).  
- Se omitido, o padrão assume `true`, e se omitida a ação assume `print $0`.

### Exemplos

| Exemplo | Comando | Resultado esperado |
|---------|--------|--------------------|
| Imprimir a 3ª coluna de cada linha | ```awk '{ print $3 }' dados.txt``` | Saída contendo apenas o terceiro campo. |
| Somar valores da segunda coluna | ```awk '{ soma += $2 } END { print soma }' dados.txt``` | Soma total dos valores da segunda coluna. |
| Filtrar linhas que contêm “erro” e imprimir a 1ª coluna | ```awk '/erro/ { print $1 }' log.txt``` | Lista de códigos ou IDs associados aos erros. |

### Colunas / Opções úteis

- `NR`: número da linha atual (ex.: `{ if (NR % 2 == 0) print $0 }` imprime linhas pares).  
- `NF`: número de campos na linha corrente.  
- `BEGIN { ... }`: bloco executado antes de ler qualquer arquivo.  
- `END { ... }`: bloco executado após terminar a leitura.  
- `FS=";"`: define o separador de campo (padrão é espaço/tab).  
- `OFS="\t"`: define o separador de saída.

### Quando usar

- Processamento rápido de arquivos grandes sem precisar carregar tudo na memória.
- Extração ou transformação de colunas específicas em logs, planilhas CSV, etc.
- Automatização de tarefas repetitivas via scripts shell (ex.: relatórios diários).

### Diferenças em relação a outras ferramentas

| Ferramenta | Principal vantagem | Limitação |
|------------|---------------------|-----------|
| `awk` | Processamento baseado em padrões com linguagem própria; suporta aritmética e strings. | Pode ser mais verboso que utilitários como `cut`, `sed`. |
| `sed` | Útil para substituições simples de texto, mas não lida bem com colunas/expressões matemáticas. | Não possui variáveis globais nem blocos `BEGIN/END`. |
| `grep` | Busca por padrões; ótimo para filtrar linhas. | Não oferece manipulação de campos ou cálculo. |

---

## STDIN, STDOUT e STDERR

### O que é
São **fluxos** (streams) de dados padrão em sistemas Unix/Linux:

- **STDIN** (`fd 0`): entrada padrão – onde um comando lê dados quando não recebe arquivos como argumento.
- **STDOUT** (`fd 1`): saída padrão – onde um comando escreve resultados normalmente exibidos no terminal.
- **STDERR** (`fd 2`): erro padrão – onde mensagens de erro são enviadas, separadas da saída normal para facilitar o tratamento.

Esses fluxos permitem encadear comandos (pipes) e redirecionar dados entre arquivos ou dispositivos.

### Como funcionam

```bash
comando1 | comando2 > saida.txt 2> erros.log
```

- `|` conecta **STDOUT** de `comando1` ao **STDIN** de `comando2`.  
- `>` redireciona o **STDOUT** para `saida.txt`.  
- `2>` redireciona o **STDERR** para `erros.log`.

### Exemplo prático com AWK

```bash
cat dados.csv | awk -F, '{ print $1 }' > primeiros_valores.txt 2> awk_erros.log
```

- `cat` envia os dados para **STDIN** do `awk`.  
- O resultado (coluna 1) vai para **STDOUT**, gravado em `primeiros_valores.txt`.  
- Qualquer mensagem de erro do `awk` vai para **STDERR**, gravada em `awk_erros.log`.

### Quando usar cada um

| Fluxo | Uso típico |
|-------|------------|
| **STDIN** | Receber dados de outro comando, de arquivos ou de entrada interativa. |
| **STDOUT** | Produzir resultados visíveis ao usuário ou passá‑los para outros comandos/arquivos. |
| **STDERR** | Emitir mensagens de erro, alertas ou avisos que não devem misturar com a saída principal. |

### Diferenças

- **STDOUT** e **STDERR** são independentes: redirecionar apenas o `>` afeta STDOUT; erros continuam no terminal a menos que sejam redirecionados explicitamente (`2>`).  
- **STDIN** pode ser substituído por arquivos usando `<` ou por comandos em sub-shell com `$(...)`.  

---

## Resumo rápido

| Ferramenta | Propósito | Instalação (se necessário) | Exemplo simples |
|------------|-----------|-----------------------------|----------------|
| `awk` | Processamento de texto baseado em padrões e colunas | Já vem na maioria das distros; use os comandos da tabela acima para atualizar | ```awk '{ print $1 }' arquivo.txt``` |
| STDIN / STDOUT / STDERR | Fluxos padrão de entrada, saída e erro | Não há instalação; fazem parte do shell | `cat file | awk '{print $2}' > out.txt 2> err.log` |

> **Dica prática:** sempre que precisar separar erros da saída principal, use `2>` para evitar confusão nos resultados. Se quiser combinar ambos em um único arquivo, basta usar `&>` (ou `>file 2>&1`).

---