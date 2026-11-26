#!/usr/bin/env bash
# Helper mínimo para Jira Cloud. Requiere JIRA_BASE_URL, JIRA_EMAIL y JIRA_API_TOKEN.
#
# Uso:
#   scripts/jira.sh transition APP-12 "En revisión"   # mueve el ticket al estado indicado
#   scripts/jira.sh comment    APP-12 "texto"          # agrega un comentario
#   scripts/jira.sh describe   APP-12 archivo.md       # reemplaza la descripción con el contenido del archivo
#   scripts/jira.sh get        APP-12                  # muestra resumen y descripción
set -euo pipefail

: "${JIRA_BASE_URL:?Falta JIRA_BASE_URL}"
: "${JIRA_EMAIL:?Falta JIRA_EMAIL}"
: "${JIRA_API_TOKEN:?Falta JIRA_API_TOKEN}"

CMD="${1:-}"; KEY="${2:-}"
[ -n "$CMD" ] && [ -n "$KEY" ] || { echo "Uso: $0 <transition|comment|describe|get> <KEY> [arg]"; exit 1; }

api() {
  curl -sS --fail-with-body -u "$JIRA_EMAIL:$JIRA_API_TOKEN" \
    -H "Content-Type: application/json" -H "Accept: application/json" "$@"
}

case "$CMD" in
  transition)
    TARGET="${3:?Falta el estado destino}"
    ID=$(api "$JIRA_BASE_URL/rest/api/3/issue/$KEY/transitions" |
      jq -r --arg t "$TARGET" '.transitions[] | select(.to.name == $t) | .id' | head -n1)
    if [ -z "$ID" ]; then
      echo "No hay transición disponible de $KEY hacia \"$TARGET\" (¿ya está en ese estado?)"
      exit 0
    fi
    api -X POST "$JIRA_BASE_URL/rest/api/3/issue/$KEY/transitions" \
      -d "$(jq -n --arg id "$ID" '{transition:{id:$id}}')"
    echo "$KEY → $TARGET"
    ;;
  comment)
    BODY="${3:?Falta el texto}"
    api -X POST "$JIRA_BASE_URL/rest/api/2/issue/$KEY/comment" \
      -d "$(jq -n --arg b "$BODY" '{body:$b}')" > /dev/null
    echo "Comentario agregado a $KEY"
    ;;
  describe)
    FILE="${3:?Falta el archivo}"
    api -X PUT "$JIRA_BASE_URL/rest/api/2/issue/$KEY" \
      -d "$(jq -n --rawfile d "$FILE" '{fields:{description:$d}}')"
    echo "Descripción de $KEY actualizada"
    ;;
  get)
    api "$JIRA_BASE_URL/rest/api/2/issue/$KEY?fields=summary,description,status" |
      jq -r '"[\(.fields.status.name)] \(.fields.summary)\n\n\(.fields.description // "")"'
    ;;
  *)
    echo "Comando desconocido: $CMD"; exit 1 ;;
esac
