#!/usr/bin/env bash
# Lint all project files: YAML, Python, HTML
# Usage: ./lint.sh

set -e
cd "$(dirname "$0")"

echo "=== YAML (yamllint) ==="
uv run yamllint slides/ .tmuxp.yaml .yamllint.yaml
echo "  OK"

echo ""
echo "=== Python (ruff) ==="
uv run ruff check build.py
uv run ruff format --check build.py
echo "  OK"

echo ""
echo "=== HTML (htmlhint) ==="
npx htmlhint talk1-datasette-at-the-library.html talk2-newsdex-from-cards-to-sqlite.html
echo "  OK"

echo ""
echo "All checks passed."
