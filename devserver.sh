#!/bin/sh
set -eu

if [ -n "${CODESPACE_NAME:-}" ] && [ -n "${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN:-}" ]; then
    base_url="https://${CODESPACE_NAME}-1313.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/"
else
    base_url="http://localhost:1313/"
fi

exec hugo server --bind 0.0.0.0 --baseURL "$base_url" --appendPort=false "$@"
