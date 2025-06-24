#!/bin/bash
set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

check_bun() {
  if ! command -v bun &> /dev/null; then
    echo -e "${GREEN}🔧 Instalando Bun...${NC}"
    curl -fsSL https://bun.sh/install | bash
    export PATH="$HOME/.bun/bin:$PATH"
  fi
}

check_uv() {
  if ! command -v uv &> /dev/null; then
    echo -e "${GREEN}🔧 Instalando uv...${NC}"
    curl -Ls https://astral.sh/uv/install.sh | bash
    export PATH="$HOME/.local/bin:$PATH"
  fi
}

echo -e "${GREEN}🚀 Que tipo de projeto você está configurando?${NC}"
echo "1. Next.js (com Bun)"
echo "2. FastAPI (com uv)"
echo "3. Full Stack (Next.js + FastAPI)"
echo "4. Payload CMS"
read -p "Escolha uma opção (1-4): " choice

check_bun
check_uv

read -p "Iniciar Docker Compose? (s/n): " docker_choice
if [[ $docker_choice == "s" ]]; then
  docker compose up -d db
fi

case "$choice" in
  1)
    echo "⚛️ Instalando dependências com Bun..."
    bun install
    ;;
  2)
    echo "🐍 Instalando dependências com uv..."
    uv pip install -r requirements.txt
    ;;
  3)
    echo "⚛️ Instalando Next.js com Bun..."
    bun install
    echo "🐍 Instalando FastAPI com uv..."
    uv pip install -r requirements.txt
    ;;
  4)
    echo "🧱 Criando projeto Payload CMS com Bun..."
    bunx create-payload-app payload-cms
    cd payload-cms
    bun install
    echo "✅ Payload CMS criado em ./payload-cms"
    ;;
  *)
    echo -e "${RED}❌ Opção inválida. Abortando.${NC}"
    exit 1
    ;;
esac

echo -e "${GREEN}✅ Ambiente pronto para desenvolvimento!${NC}"
