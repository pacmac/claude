#!/bin/bash
#
# cr - Claude session naming and resuming
#
# Usage:
#   cr                      list all named sessions
#   cr <name>               resume session by name
#   cr <name> -f            fork from named session
#   cr -s <name> [project]  save current session as <name>
#   cr -w                   show current session UUID and name
#

NAMES_FILE="$HOME/.claude/session-names.json"

# Find current session UUID (most recently modified .jsonl in project dir)
_cr_current_uuid() {
  local project="${1:-$PWD}"
  local project_dir="$HOME/.claude/projects/$(echo "$project" | tr '/' '-')"
  python3 -c "
import os, glob
jsonls = glob.glob(os.path.join('$project_dir', '*.jsonl'))
if jsonls:
    latest = max(jsonls, key=os.path.getmtime)
    print(os.path.basename(latest).replace('.jsonl', ''))
" 2>/dev/null
}

# Ensure names file exists
[ ! -f "$NAMES_FILE" ] && echo '{}' > "$NAMES_FILE"

# -w: show current session info
if [ "$1" = "-w" ]; then
  UUID=$(_cr_current_uuid)
  if [ -z "$UUID" ]; then
    echo "No active session found."
    exit 1
  fi
  NAME=$(python3 -c "
import json
with open('$NAMES_FILE') as f:
    data = json.load(f)
matches = [k for k, v in data.items() if v.get('uuid') == '$UUID']
print(matches[0] if matches else '(unnamed)')
" 2>/dev/null)
  echo "$NAME  $UUID"
  exit 0
fi

# -s: save/name current session
if [ "$1" = "-s" ]; then
  shift
  NAME="$1"
  PROJECT="${2:-$PWD}"
  if [ -z "$NAME" ]; then
    echo "Usage: cr -s <name> [project-path]"
    exit 1
  fi
  if ! echo "$NAME" | grep -qE '^[a-zA-Z0-9][a-zA-Z0-9-]*$'; then
    echo "Name must be a slug (letters, numbers, hyphens)."
    exit 1
  fi
  UUID=$(_cr_current_uuid "$PROJECT")
  if [ -z "$UUID" ]; then
    echo "No active session found."
    exit 1
  fi
  python3 -c "
import json
with open('$NAMES_FILE') as f:
    data = json.load(f)
existing = data.get('$NAME')
if existing and existing['uuid'] != '$UUID':
    print('CONFLICT: $NAME already maps to ' + existing['uuid'])
    exit(2)
data['$NAME'] = {'uuid': '$UUID', 'project': '$PROJECT'}
with open('$NAMES_FILE', 'w') as f:
    json.dump(data, f, indent=2)
print('Session named: $NAME')
print('UUID: $UUID')
"
  exit $?
fi

# No args — list all named sessions
if [ -z "$1" ]; then
  python3 -c "
import json
with open('$NAMES_FILE') as f:
    data = json.load(f)
if not data:
    print('No named sessions.')
else:
    print(f'{\"NAME\":<20s}  PROJECT')
    print(f'{\"----\":<20s}  -------')
    for name, info in sorted(data.items()):
        print(f'{name:<20s}  {info[\"project\"]}')
"
  exit 0
fi

NAME="$1"
shift

# Look up UUID
UUID=$(python3 -c "
import json, sys
with open('$NAMES_FILE') as f:
    data = json.load(f)
info = data.get('$NAME')
if info:
    print(info['uuid'])
else:
    sys.exit(1)
" 2>/dev/null)

if [ -z "$UUID" ]; then
  echo "Unknown session: $NAME"
  exit 1
fi

# Fork flag
if [ "$1" = "-f" ] || [ "$1" = "--fork" ]; then
  claude --resume "$UUID" --fork-session
else
  claude --resume "$UUID"
fi
