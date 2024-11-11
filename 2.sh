#!/bin/bash


us() {
    echo "Використання: $0 -p <шлях до директорії> -s <текст для пошуку>"
    exit 1
}

directory=""
search_text=""

while getopts ":p:s:" opt; do
    case $opt in
        p) directory="$OPTARG"
            ;;
        s) search_text="$OPTARG"
            ;;
    esac
done


if [ -z "$directory" ] || [ -z "$search_text" ]; then
    echo "Помилка: Обидва параметри -p <шлях> і -s <текст> є обов'язковими."
    us
fi


if [ ! -d "$directory" ]; then
    echo "Помилка: Директорія '$directory' не існує."
    exit 1
fi

grep -rl "$search_text" "$directory"