#!/usr/bin/env bash
set -euo pipefail
# Rollback a failed rebase or restore stashed changes
# Usage: ./scripts/rollback_rebase.sh

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

echo "Спроба abort для поточного rebase (якщо є)..."
git rebase --abort || true

echo "Спроба відновити stash (якщо був autostash)..."
git stash pop || true

echo "Рекомендація: після rollback перевірте статус і повторіть pull/rebase за потреби."
echo "Готово."
