#!/usr/bin/env bash

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log_status() {
    local level="$1"; shift
    local message="$*"
    local color="$BLUE"

    case "$level" in
        success) color="$GREEN" ;;
        warn)    color="$YELLOW" ;;
        error)   color="$RED" ;;
        info|*)  color="$CYAN" ;;
    esac

    echo -e "${color}${message}${NC}"
}

BIN_DIR="$HOME/.local/bin"
BIN_NAME="orgmai"
REPO_URL="https://github.com/osmargm1202/orgmai"
BIN_URL="https://raw.githubusercontent.com/osmargm1202/orgmai/master/orgmai"

echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║      ORGMAI Installation Script       ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
echo

# Crear directorio si no existe
mkdir -p "$BIN_DIR"

log_status info "Descargando binario desde GitHub..."

# Descargar binario
if command -v curl &> /dev/null; then
    if curl -L -f -o "$BIN_DIR/$BIN_NAME" "$BIN_URL"; then
        log_status success "Binario descargado correctamente"
    else
        log_status error "Error descargando binario"
        exit 1
    fi
elif command -v wget &> /dev/null; then
    if wget -O "$BIN_DIR/$BIN_NAME" "$BIN_URL"; then
        log_status success "Binario descargado correctamente"
    else
        log_status error "Error descargando binario"
        exit 1
    fi
else
    log_status error "curl o wget no están instalados. Instala uno de ellos."
    exit 1
fi

# Dar permisos de ejecución
chmod +x "$BIN_DIR/$BIN_NAME"

# Verificar que ~/.local/bin esté en PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    log_status warn "\$HOME/.local/bin no está en PATH. Agrégalo a tu shell profile:"
    echo -e "${YELLOW}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
    echo
fi

echo
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ¡Instalación completada!            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo
echo -e "${BLUE}Binario instalado en:${NC} $BIN_DIR/$BIN_NAME"
echo -e "${BLUE}Ejecuta:${NC} orgmai"
echo
echo -e "${CYAN}Comandos disponibles:${NC}"
echo -e "  orgmai apikey    - Configurar API key de Claude"
echo -e "  orgmai config    - Seleccionar modelo Claude"
echo -e "  orgmai chat      - Iniciar conversación"
echo -e "  orgmai prev      - Continuar conversación anterior"
echo
