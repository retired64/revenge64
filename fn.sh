#!/bin/bash

# Script para descargar y administrar fuentes para el tema Super Mario Bros
# Autor: retired64
# Repositorio: github.com/retired64/revenge64

set -e  # Salir si hay algún error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directorio de fuentes
FONTS_DIR="fonts"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Super Mario Bros Font Manager${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Verificar que estamos en el directorio correcto
if [ ! -d "$FONTS_DIR" ]; then
    echo -e "${RED}Error: Directorio 'fonts' no encontrado${NC}"
    echo -e "${YELLOW}Por favor ejecuta este script desde la raíz del repositorio${NC}"
    exit 1
fi

cd "$FONTS_DIR"

echo -e "${GREEN}✓ Directorio de fuentes encontrado${NC}\n"

# Función para descargar fuentes
download_font() {
    local url=$1
    local output=$2
    local name=$3
    
    echo -e "${YELLOW}Descargando $name...${NC}"
    
    if [ -f "$output" ]; then
        echo -e "${BLUE}  → Ya existe, omitiendo${NC}"
        return 0
    fi
    
    if curl -L -f -o "$output" "$url" 2>/dev/null; then
        echo -e "${GREEN}  ✓ Descargado exitosamente${NC}"
        return 0
    else
        echo -e "${RED}  ✗ Error al descargar${NC}"
        return 1
    fi
}

# Verificar fuentes existentes
echo -e "${BLUE}Verificando fuentes existentes:${NC}"
for font in SuperMario-Bold.ttf SuperMario-Medium.ttf SuperMario-Regular.ttf; do
    if [ -f "$font" ]; then
        echo -e "${GREEN}  ✓ $font${NC}"
    else
        echo -e "${RED}  ✗ $font (faltante)${NC}"
    fi
done
echo ""

# Descargar fuentes de Google Fonts
echo -e "${BLUE}Descargando fuentes de Google Fonts:${NC}\n"

# Press Start 2P (para Regular/Normal)
download_font \
    "https://github.com/google/fonts/raw/main/ofl/pressstart2p/PressStart2P-Regular.ttf" \
    "PressStart2P-Regular.ttf" \
    "Press Start 2P (Regular)"

# Silkscreen Regular
download_font \
    "https://github.com/google/fonts/raw/main/ofl/silkscreen/Silkscreen-Regular.ttf" \
    "Silkscreen-Regular.ttf" \
    "Silkscreen (Regular)"

# Silkscreen Bold
download_font \
    "https://github.com/google/fonts/raw/main/ofl/silkscreen/Silkscreen-Bold.ttf" \
    "Silkscreen-Bold.ttf" \
    "Silkscreen (Bold)"

# VT323 (para Light)
download_font \
    "https://github.com/google/fonts/raw/main/ofl/vt323/VT323-Regular.ttf" \
    "VT323-Regular.ttf" \
    "VT323 (Light/Mono)"

# Pixelify Sans (Variable - opcional)
download_font \
    "https://github.com/google/fonts/raw/main/ofl/pixelifysans/PixelifySans%5BWGHT%5D.ttf" \
    "PixelifySans-Variable.ttf" \
    "Pixelify Sans (Variable)"

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}Descarga completada${NC}\n"

# Mostrar resumen
echo -e "${BLUE}Fuentes en el directorio:${NC}"
ls -lh *.ttf 2>/dev/null | awk '{print "  " $9 " (" $5 ")"}'

# Verificar font.json
echo ""
if [ -f "font.json" ]; then
    echo -e "${GREEN}✓ font.json encontrado${NC}"
else
    echo -e "${YELLOW}⚠ font.json no encontrado${NC}"
    echo -e "${YELLOW}  Crea el archivo usando el artifact 'mario_fonts_pack'${NC}"
fi

# Instrucciones finales
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Próximos pasos:${NC}"
echo -e "${YELLOW}1.${NC} Verifica que font.json esté actualizado"
echo -e "${YELLOW}2.${NC} Haz commit de las nuevas fuentes:"
echo -e "   ${GREEN}git add fonts/*.ttf${NC}"
echo -e "   ${GREEN}git commit -m 'Add Google Fonts for Mario theme'${NC}"
echo -e "   ${GREEN}git push${NC}"
echo -e "${YELLOW}3.${NC} Las URLs ya apuntan a GitHub y Google Fonts"
echo -e "${BLUE}========================================${NC}"
