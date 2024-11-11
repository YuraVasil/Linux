#!/bin/bash


if [ "$#" -ne 2 ]; then
  echo "Використання: $0 <шлях_до_директорії> <розширення_файлів>"
  exit 1
fi


DIR=$1
EXTENSION=$2

if [ ! -d "$DIR" ]; then
  echo "Помилка: Директорія $DIR не існує."
  exit 1
fi


FILE_COUNT=$(find "$DIR" -type f -name "*.$EXTENSION" | wc -l)

# Виведення кількості файлів
echo "Кількість файлів з розширенням .$EXTENSION у директорії $DIR: $FILE_COUNT"