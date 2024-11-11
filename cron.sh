#!/bin/bash


LOG_FILE="/var/log/my-app.log"


if [ ! -f "$LOG_FILE" ]; then
    echo "File $LOG_FILE does not exist."
    exit 1
fi


LAST_MOD_FILE="/tmp/last_mod_time.log"


CURRENT_MOD_TIME=$(stat -c %Y "$LOG_FILE")

# Перевірка, чи є записаний попередній час модифікації
if [ -f "$LAST_MOD_FILE" ]; then
    LAST_MOD_TIME=$(cat "$LAST_MOD_FILE")
else
    LAST_MOD_TIME=0
fi

# Якщо час модифікації змінився
if [ "$CURRENT_MOD_TIME" -ne "$LAST_MOD_TIME" ]; then
    # Отримання розміру файлу
    FILE_SIZE=$(stat -c %s "$LOG_FILE")
    MOD_DATE=$(date -r "$LOG_FILE" +"%Y-%m-%d %H:%M:%S")

    # Запис розміру та дати зміни в Redis
    redis-cli HSET log_info size "$FILE_SIZE" modified_date "$MOD_DATE"

    echo "$CURRENT_MOD_TIME" > "$LAST_MOD_FILE"
fi