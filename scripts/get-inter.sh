#!/bin/sh
# Baixa a fonte Inter (variável, subconjunto latin) para static/fonts/.
# Execute uma vez, com internet: sh scripts_get-inter.sh
mkdir -p static/fonts
curl -L -o static/fonts/inter-latin-var.woff2 \
  "https://cdn.jsdelivr.net/fontsource/fonts/inter:vf@latest/latin-wght-normal.woff2"
