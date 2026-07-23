#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR="/home/pglab/automation-lab"

cd "$PROJECT_DIR"

echo "running system report"

./scripts/sysreport.sh

echo "addding log files to git"

git add logs/

if git diff --cached --quiet; then
echo "no new log changes to commit"
else
git commit -m "automatic system report $(date '+%F %T')"
echo "log commited"
fi

echo "automation done"


# GIT hook test
# second hook test
