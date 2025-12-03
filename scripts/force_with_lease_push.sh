#!/usr/bin/env bash
set -euo pipefail
# Commit (if needed) and push with --force-with-lease
# Usage: ./scripts/force_with_lease_push.sh "Commit message"

MSG="${1:-Force push with lease}"
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

git add -A
if git diff --staged --quiet; then
  echo "Немає змін для коміту."
else
  SKIP_HOOKS="${SKIP_HOOKS:-false}"
  if [[ "$SKIP_HOOKS" == "true" ]]; then
    git commit -m "$MSG" --no-verify
  else
    git commit -m "$MSG"
  fi
fi

echo "Підтвердіть, щоб виконати push --force-with-lease (yes/no):"
read -r CONF
if [[ "$CONF" == "yes" ]]; then
  if [[ "${SKIP_HOOKS:-false}" == "true" ]]; then
    git push --force-with-lease origin main --no-verify
  else
    git push --force-with-lease origin main
  fi
  echo "Push зі 'force-with-lease' виконано."
else
  echo "Відмінено."
fi
