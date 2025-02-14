#!/usr/bin/env bash

# Check whether the shell is bash
if [ -z "$BASH" ]; then
    echo "This script must be run with bash." 1>&2
    exit 1
fi

# Check current shell has exec permission
if [ ! -x "$0" ]; then
    echo "This script must be run with exec permission." 1>&2
    exit 1
fi

# Change the working directory to the directory of the script
cd "$(dirname "$0")" || exit

# Mkdir logs
mkdir -p logs

# Open a subshell to ensure env isolation
(
# Execute the utils.sh script
. ./scripts/utils.sh || exit $?
# Execute the run.sh script
. ./scripts/run.sh || exit $?
) >> logs/"$(date +"%Y-%m-%d")".log 2>&1

# Cleanup logs 30 days ago
find logs/ -type f -name "*.log" -mtime +30 -exec rm -f {} \;