#!/bin/bash

LOG_FILE="/home/vladimir/devops-test/logs/access.log"

# Параметры подключения к PostgreSQL
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="devops_test"
DB_USER="postgres"

# Проверка наличия файла
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Файл логов не найден: $LOG_FILE" >&2
    exit 1
fi

# Анализ логов и запись в БД
awk '{ ip[$1]++ }
END {
    for (i in ip) {
        printf "%s %d\n", i, ip[i]
    }
}' "$LOG_FILE" |
while read ip count; do
    psql \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        -c "INSERT INTO log_stats (ip, requests_count) VALUES ('$ip', $count);"
done
