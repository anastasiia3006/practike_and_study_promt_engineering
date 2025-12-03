#!/usr/bin/env bash
set -euo pipefail
# Pull with rebase+autostash then push
# Usage: ./scripts/safe_pull_rebase_then_push.sh

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

echo "Pull --rebase --autostash..."
git pull --rebase --autostash origin main

echo "Push..."
git push origin main

echo "Готово."
