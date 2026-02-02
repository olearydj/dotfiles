#!/bin/bash

# Read input JSON
input=$(cat)

# Extract information from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
context_data=$(echo "$input" | jq '.context_window')

# Get current working directory (shortened for home)
display_cwd="${cwd/#$HOME/~}"

# Get git branch if in a git repo
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        git_branch=" ($branch)"
    fi
fi

# Calculate context window percentage
context_info=""
current_usage=$(echo "$context_data" | jq '.current_usage')
if [ "$current_usage" != "null" ]; then
    current_tokens=$(echo "$current_usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    context_size=$(echo "$context_data" | jq '.context_window_size')
    if [ "$context_size" != "null" ] && [ "$context_size" -gt 0 ]; then
        pct=$((current_tokens * 100 / context_size))
        context_info=" [${pct}%]"
    fi
fi

# Build and output the status line
printf "%s%s | %s%s" "$display_cwd" "$git_branch" "$model" "$context_info"
