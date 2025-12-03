#!/usr/bin/env bash
set -euo pipefail
# Safe commit and push with pull --rebase --autostash
# Usage: ./scripts/safe_commit_and_push.sh "Commit message"

MSG="${1:-Update files}"
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

SKIP_HOOKS="${SKIP_HOOKS:-false}"

echo "1) Перевірка статусу..."
git status --porcelain=2 --branch

echo "2) Підтягую віддалені зміни (rebase + autostash)..."
git pull --rebase --autostash origin main

echo "3) Додаю всі зміни і намагаюсь закомітити..."
git add -A
if git diff --staged --quiet; then
  echo "Немає змін для коміту."
else
  if [[ "$SKIP_HOOKS" == "true" ]]; then
    git commit -m "$MSG" --no-verify
  else
    git commit -m "$MSG"
  fi
fi

echo "4) Пушу на origin/main..."
if [[ "$SKIP_HOOKS" == "true" ]]; then
  git push origin main --no-verify
else
  git push origin main
fi

echo "Готово."
