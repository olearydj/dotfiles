#!/bin/bash
# Pre-compact hook: Centralized session notes in Obsidian vault
#
# Structure:
#   /Volumes/Casa/obsidian/new_vault/agent-sessions/
#     {project-name}/
#       {session-date}-{short-id}/
#         transcript.jsonl -> ~/.config/claude/.../full-id.jsonl
#         {segment-timestamp}-segment-{NN}.md
#
# Project name derived from:
#   1. .claude-project file in cwd (if exists)
#   2. Git repo name (if in a repo)
#   3. Basename of cwd (fallback)
#
# Also creates symlink at $cwd/docs/sessions -> centralized location for local access.

set -euo pipefail

CENTRAL_SESSIONS="/Volumes/Casa/obsidian/new_vault/agent-sessions"

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // empty')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')

[[ -z "$cwd" || -z "$transcript_path" || ! -f "$transcript_path" ]] && exit 0

# Derive project name
if [[ -f "$cwd/.claude-project" ]]; then
    project_name=$(cat "$cwd/.claude-project" | tr -d '\n' | tr ' ' '-')
else
    project_name=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null | xargs basename 2>/dev/null || basename "$cwd")
fi

short_id="${session_id:0:8}"

# Get session start date from first timestamp in JSONL
session_date=$(python3 -c "
import json, sys
from datetime import datetime
with open('$transcript_path') as f:
    for line in f:
        if line.strip():
            try:
                entry = json.loads(line)
                ts = entry.get('timestamp')
                if ts:
                    dt = datetime.fromisoformat(ts.replace('Z', '+00:00'))
                    print(dt.astimezone().strftime('%Y-%m-%d'))
                    break
            except: pass
" 2>/dev/null || echo "unknown-date")

# Create centralized session folder
session_folder="$CENTRAL_SESSIONS/$project_name/${session_date}-${short_id}"
mkdir -p "$session_folder"

# Symlink transcript
symlink_path="$session_folder/transcript.jsonl"
[[ ! -L "$symlink_path" ]] && ln -s "$transcript_path" "$symlink_path"

# Symlink back to project for local discoverability (skip for "general" sessions)
if [[ "$project_name" != "general" ]]; then
    local_link="$cwd/docs/sessions"
    if [[ ! -e "$local_link" ]]; then
        mkdir -p "$(dirname "$local_link")" 2>/dev/null || true
        ln -s "$CENTRAL_SESSIONS/$project_name" "$local_link" 2>/dev/null || true
    fi
fi

# Generate summary for current segment
summarize-session "$transcript_path" --session-id "$session_id" --output-dir "$session_folder" \
    || echo "Summary generation failed for session $session_id" >&2
