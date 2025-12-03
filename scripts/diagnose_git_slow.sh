#!/usr/bin/env bash
set -euo pipefail
# Diagnostic script to find why git commit/push is slow
# Usage: ./scripts/diagnose_git_slow.sh

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

echo "== Current git status =="
git status --porcelain=2 --branch || true

echo "\n== List git hooks (if any) =="
ls -la .git/hooks || true

echo "\n== Check for pre-commit or husky configs in repo =="
grep -R "pre-commit\|husky\|pre-commit-config" -n --exclude-dir=.git . || true

echo "\n== Check for large files in working tree (>50MB) =="
find . -type f -size +50M -exec ls -lh {} \; || true

echo "\n== Check git LFS status =="
git lfs status || echo "git lfs not installed or no LFS objects"

echo "\n== Size of .git and object count =="
du -sh .git || true
git count-objects -vH || true

echo "\n== Network debug for push (dry-run) =="
GIT_TRACE=1 GIT_CURL_VERBOSE=1 git push --dry-run origin main 2>&1 | sed -n '1,200p' || true

echo "\n== End of diagnostics =="
