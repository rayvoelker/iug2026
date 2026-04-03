#!/usr/bin/env bash
# Usage: ./tmux-session.sh
cd "$(dirname "$0")"
tmux kill-session -t iug2026 2>/dev/null
tmuxp load .tmuxp.yaml
