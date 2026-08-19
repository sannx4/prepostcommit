#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

LOGDIR="$PROJECT_DIR/logs"

mkdir -p "$LOGDIR"

LOGFILE="$LOGDIR/sysreport_$(date +%F).log"

{
    echo "======================================"
    echo "SYSTEM REPORT"
    echo "======================================"

    echo "Date: $(date '+%F %T')"
    echo "User: $(whoami)"
    echo "System: $(uname -s)"
    echo "Hostname: $(hostname)"
    echo "Current Directory: $(pwd)"

    echo
    echo "Disk Usage:"
    df -h

    echo
    echo "Memory Usage:"
    free -h

    echo
    echo "Uptime:"
    uptime

    echo
} >> "$LOGFILE"

echo "System report created successfully"
echo "Report saved at: $LOGFILE"
