#!/usr/bin/env bash
set -e
cd "$(dirname "${BASH_SOURCE[0]}")/.."
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then . "$NVM_DIR/nvm.sh"; fi
nvm install 24
nvm use 24
if [ ! -d node_modules/vite ]; then PUPPETEER_SKIP_DOWNLOAD=true npm ci; fi
if curl -fsS http://127.0.0.1:4173/ >/dev/null 2>&1; then exit 0; fi
export GEV_ALLOWED_HOSTS="$CODESPACE_NAME-4173.$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN"
nohup npm run dev -- --port 4173 --strictPort >/tmp/gods-eye-view.log 2>&1 </dev/null &
echo "God's Eye View is starting on private port 4173."
