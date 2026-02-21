---
name: sessions
description: Review Agent Sessions
---

# Review Agent Sessions

Review recent Claude Code session notes from the centralized agent-sessions folder.

## Location

All session notes are stored in: `/Volumes/Casa/obsidian/vault/agent-sessions/`

Structure:
```
agent-sessions/
  {project-name}/
    {date}-{session-id}/
      transcript.jsonl (symlink to original)
      *-segment-*.md (summary files)
```

## Instructions

### 1. Determine the project name

Use this priority order (stop at first match):

1. **Argument provided**: If user ran `/sessions {project}`, use that project name
2. **`.claude-project` file**: Read `./.claude-project` — if it exists, use its content as the project name
3. **Symlink**: Check if `./docs/sessions` exists — if so, extract project name from the symlink target
4. **Git repo**: Run `git rev-parse --show-toplevel 2>/dev/null | xargs basename` — use repo name if in a git repo
5. **Directory basename**: Use `basename "$PWD"` as fallback

**Important**: Unless the user explicitly passes `all` as an argument, ONLY show sessions for the current project. Do not list or read sessions from other projects.

### 2. List recent sessions for that project

```bash
ls -lt /Volumes/Casa/obsidian/vault/agent-sessions/{project}/ | head -10
```

### 3. Read the most recent segment files

Read the `.md` summary files (not transcript.jsonl):
```bash
find /Volumes/Casa/obsidian/vault/agent-sessions/{project} -name "*.md" -mtime -7 | xargs ls -lt | head -10
```

### 4. Summarize what was accomplished

For each session, note:
- Key tasks completed
- Files modified
- Decisions made
- Open questions or todos

## Usage

- `/sessions` — Review sessions for current project only
- `/sessions all` — Overview of all projects' recent activity
- `/sessions {project}` — Review specific project
- `/sessions search {term}` — Search across all session notes
