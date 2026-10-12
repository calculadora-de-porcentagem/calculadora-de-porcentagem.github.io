# Calculadora de Porcentagem (Hugo)

Site estático em pt-BR. baseURL: https://calculadora-de-porcentagem.github.io/

## Antes de publicar
1. `sh scripts/get-inter.sh` baixa a fonte Inter para `static/fonts/inter-latin-var.woff2`.
2. Em `hugo.toml`, preencha `params.email` (aparece em Contato e Privacidade).
3. Para anúncios, preencha `params.adsenseClient` (ca-pub-...) e `params.adsenseSlot`. Vazio = nenhum anúncio.
4. Use Hugo extended recente (0.128 ou mais novo). `hugo server` para ver localmente e `hugo --minify` para gerar `public/`.

## Regras aplicadas pelo build
- `<title>` é sempre só o título da página, sem sufixo.
- Toda página precisa de `description` com 150 a 155 caracteres; fora disso o build falha.
- Glosário: cada verbete tem `definicao` (até 50 palavras) como primeiro parágrafo, 1 link de fonte e link para a home.

## Estrutura
- `data/calculadoras.yaml`: 9 calculadoras, na ordem de exibição.
- `assets/js/calc.js`: lógica das calculadoras (inline, sem dependências).
- `content/glossario/*.md`: 39 verbetes. `content/_index.md`: homepage.
- `layouts/partials/schema.html`: JSON-LD (Organization, WebSite, WebPage, BreadcrumbList, WebApplication, Article, FAQPage, DefinedTermSet, DefinedTerm).
- `static/robots.txt` e `static/llms.txt`.
