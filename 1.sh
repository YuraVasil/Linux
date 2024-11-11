#!/bin/bash

directory="$1"
extension="$2"

if [ ! -d "$directory" ]; then
    echo "Помилка: Директорія '$directory' не існує."
    exit 1
fi

find "$directory" -type f -name "*.$extension"