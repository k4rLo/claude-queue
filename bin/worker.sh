#!/bin/bash

PROJECT_STORAGE="$1"
if [ -z "$PROJECT_STORAGE" ]; then
    exit 1
fi

# Determine base dir for template fallback
BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(cd "$BIN_DIR/.." && pwd)"

# Load configuration (favor storage config, then template)
if [ -f "$PROJECT_STORAGE/.cl.conf" ]; then
    source "$PROJECT_STORAGE/.cl.conf"
elif [ -f "$BASE_DIR/example.cl.conf" ]; then
    source "$BASE_DIR/example.cl.conf"
else
    export PATH="$HOME/.local/bin:$PATH"
    CL_FLAGS="--chrome --permission-mode dontAsk --dangerously-skip-permissions"
fi

# Define paths
LOG_FILE="$PROJECT_STORAGE/claude.log"
QUEUE_FILE="$PROJECT_STORAGE/.claude_queue"
LOCK_FILE="$PROJECT_STORAGE/.cl.lock"

# Ensure log and queue exist
touch "$LOG_FILE" "$QUEUE_FILE"

# Flock with storage-specific lock file
exec 9>"$LOCK_FILE"
if ! flock -n 9; then
    exit 0
fi

echo "[$(date)] Worker started for project: $(cat "$PROJECT_STORAGE/origin_path")" >> "$LOG_FILE"

while true; do
    if [ -s "$QUEUE_FILE" ]; then
        PROMPT=$(head -n 1 "$QUEUE_FILE")
        tail -n +2 "$QUEUE_FILE" > "$QUEUE_FILE.tmp" && mv "$QUEUE_FILE.tmp" "$QUEUE_FILE"
        
        if [ -n "$PROMPT" ]; then
            echo "-------------------------------------------" >> "$LOG_FILE"
            echo "[$(date)] STARTING: $PROMPT" >> "$LOG_FILE"
            
            # Change to the project directory before executing
            cd "$(cat "$PROJECT_STORAGE/origin_path")" || exit 1
            
            # Execute Claude
            eval "claude $CL_FLAGS \"$PROMPT\"" >> "$LOG_FILE" 2>&1
            
            echo "[$(date)] FINISHED: $PROMPT" >> "$LOG_FILE"
            echo "-------------------------------------------" >> "$LOG_FILE"
        fi
    else
        sleep 2
        if [ ! -s "$QUEUE_FILE" ]; then
            echo "[$(date)] Queue empty, worker exiting." >> "$LOG_FILE"
            exit 0
        fi
    fi
done
