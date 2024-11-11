#!/bin/bash

LOG_FILE="/home/vboxuser/Downloads/var/log/my-app.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "File $LOG_FILE does not exist."
    exit 1
fi

LAST_MOD_FILE="/home/vboxuser/Downloads/tmp/last_mod_time.log"

CURRENT_MOD_TIME=$(stat -c %Y "$LOG_FILE")

# Read the last modification time, or set it to 0 if the file is empty or does not exist
if [ -f "$LAST_MOD_FILE" ] && [ -s "$LAST_MOD_FILE" ]; then
    LAST_MOD_TIME=$(cat "$LAST_MOD_FILE")
else
    LAST_MOD_TIME=0
fi

# Ensure LAST_MOD_TIME is set to an integer, even if empty
LAST_MOD_TIME=${LAST_MOD_TIME:-0}

# Debug output to check the values of CURRENT_MOD_TIME and LAST_MOD_TIME
echo "Current modification time: $CURRENT_MOD_TIME"
echo "Last modification time: $LAST_MOD_TIME"

# If modification time has changed
if [ "$CURRENT_MOD_TIME" -ne "$LAST_MOD_TIME" ]; then
    # Get file size
    FILE_SIZE=$(stat -c %s "$LOG_FILE")
    MOD_DATE=$(date -r "$LOG_FILE" +"%Y-%m-%d %H:%M:%S")

    # Write size and modification date to Redis
    redis-cli HSET log_info size "$FILE_SIZE" modified_date "$MOD_DATE"

    echo "$CURRENT_MOD_TIME" > "$LAST_MOD_FILE"
fi
