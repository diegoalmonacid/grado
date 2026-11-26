#!/bin/bash
# Prepara el proyecto al iniciar una sesión en la nube de Claude Code.
# En sesiones locales no hace nada.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}"
npm ci --no-audit --no-fund
chmod +x scripts/*.sh 2>/dev/null || true
