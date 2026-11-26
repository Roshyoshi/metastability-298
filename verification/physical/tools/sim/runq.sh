#!/bin/bash
# Sequential job queue, restart-safe: each line of the job file is "<name>|<command>"; a job whose marker
# done/<name> exists is skipped. usage: runq.sh <jobs file> <state dir>
JOBS=$1; R=$2; mkdir -p "$R/done" "$R/logs"
while true; do
  ran=0
  while IFS='|' read -r name cmd; do
    [ -z "$name" ] && continue
    case "$name" in \#*) continue;; esac
    [ -f "$R/done/$name" ] && continue
    [ -f "$R/done/$name.RUNNING" ] && continue
    touch "$R/done/$name.RUNNING"
    echo "$(date -u +%T) start $name" >> "$R/queue.log"; t0=$(date +%s)
    if bash -c "$cmd" >> "$R/logs/$name.log" 2>&1 < /dev/null; then st=done; else st=FAILED; fi
    rm -f "$R/done/$name.RUNNING"; touch "$R/done/$name"
    echo "$(date -u +%T) $st $name ($(( $(date +%s) - t0 )) s)" >> "$R/queue.log"
    ran=1; break
  done < "$JOBS"
  [ "$ran" = 0 ] && break
done
echo "$(date -u +%T) queue empty ($JOBS)" >> "$R/queue.log"
