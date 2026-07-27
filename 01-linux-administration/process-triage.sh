#!/bin/bash
# process-triage.sh
# Triage script for checking on a background job (e.g., BWA alignment)
# Usage: ./process-triage.sh <process_name>

PROCESS_NAME=$1

if [ -z "$PROCESS_NAME" ]; then
  echo "Usage: $0 <process_name>"
  exit 1
fi

echo "=== Step 1: Is $PROCESS_NAME currently running? ==="
if pgrep -x "$PROCESS_NAME" > /dev/null; then
  echo "$PROCESS_NAME is RUNNING (PID: $(pgrep -x "$PROCESS_NAME"))"
else
  echo "$PROCESS_NAME is NOT running (finished or never started)"
fi

echo ""
echo "=== Step 2: Disk space check (large FASTQ/BAM files can fill disks fast) ==="
df -h /

echo ""
echo "=== Step 3: Recent system log activity ==="
sudo journalctl -n 20 --no-pager
