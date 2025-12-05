#!/bin/bash

# Alias para construir el devcontainer de orgmai
# Agrega esto a tu ~/.bashrc o ~/.zshrc:
# source /ruta/a/orgmai/.devcontainer/alias.sh

alias orgm-build='cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)/.devcontainer" && bash build.sh'
alias orgm-up='cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)/.devcontainer" && export GH_TOKEN=${GH_TOKEN:-$(gh auth token 2>/dev/null)} && if [ -z "$GH_TOKEN" ]; then echo "❌ Error: GH_TOKEN no configurado. Ejecuta: export GH_TOKEN=\$(gh auth token)"; exit 1; fi && docker-compose up -d'
alias orgm-down='cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)/.devcontainer" && docker-compose down'
alias orgm-logs='cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)/.devcontainer" && docker-compose logs -f'
alias orgm-restart='orgmai-down && orgmai-up'

