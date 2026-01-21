#!/bin/bash

total_requests=$(wc -l)

status_200=$(awk '$NF == 200 {count++} END {print count+0}')

top_ips=$(awk '{print $1}' | sort | uniq -c | sort -nr | head -3)

echo "Общее количество HTTP-запросов: $total_requests"
echo "Количество ответов с кодом 200: $status_200"
echo "ТОП-3 IP-адреса по количеству запросов:"
echo "$top_ips"
