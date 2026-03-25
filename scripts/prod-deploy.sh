#!/usr/bin/env bash
set -euo pipefail

APP_NAME="web-porfolio"
REMOTE="${REMOTE:-}"
TARGET_HOST="${TARGET_HOST:-omega-xiii}"
TARGET_USER="${TARGET_USER:-egonzalezcortes}"
TARGET_PORT="${TARGET_PORT:-22}"
TARGET_DIR="/var/www/egonzalezcortes.com"
SSH_OPTS="-p ${TARGET_PORT}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

if [[ $# -gt 1 ]]; then
  echo "Usage: $0 [user@server]"
  exit 1
fi

if [[ $# -ge 1 ]]; then
  REMOTE="$1"
fi

if [[ -z "${REMOTE}" ]]; then
  if [[ -z "${TARGET_HOST}" ]]; then
    echo "Set REMOTE (example: REMOTE=egonzalezcortes@203.0.113.10)."
    echo "Or use TARGET_USER + TARGET_HOST for backward compatibility."
    echo "Or pass positional args: ./scripts/deploy-prod.sh egonzalezcortes@203.0.113.10"
    exit 1
  fi
  REMOTE="${TARGET_USER}@${TARGET_HOST}"
fi

echo "[1/5] Installing dependencies"
npm ci --prefix "${REPO_DIR}"

echo "[2/5] Building ${APP_NAME}"
npm run --prefix "${REPO_DIR}" build

echo "[3/5] Creating target directory on server"
ssh ${SSH_OPTS} "${REMOTE}" "mkdir -p '${TARGET_DIR}'"

echo "[4/5] Syncing build artifacts"
rsync -az --delete -e "ssh ${SSH_OPTS}" "${REPO_DIR}/.output/public/" "${REMOTE}:${TARGET_DIR}/"

echo "[5/5] Deploy complete"
echo "Production URL should now serve content from: ${TARGET_DIR}"
