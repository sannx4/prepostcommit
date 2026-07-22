#!/usr/bin/env bash

set -euo pipefail

LOGDIR="$HOME/automation-lab/logs"

mkdir -p "$LOGDIR"

LOGFILE="$LOGDIR/sysreport_$(date +%F).log"

{
echo "=== $(date '+%F %T') ==="
echo "User: $(whoami)"
echo "System: $(uname -s)"
echo "Curr Directory : $(pwd)"
echo "Disk Usage:"
df -h

} >> "$LOGFILE"

echo "System report created sucessfully"

# testing pre-commit hook
