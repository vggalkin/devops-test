awk '
{
    total++
    ip[$1]++
    if ($NF == 200) status200++
}
END {
    print "Общее количество HTTP-запросов:", total
    print "Количество ответов с кодом 200:", status200
    print "ТОП-3 IP-адреса по количеству запросов:"
    for (i in ip) {
        printf "%d %s\n", ip[i], i
    }
}' |
{
    read line1
    read line2
    read line3
    echo "$line1"
    echo "$line2"
    echo "$line3"
    sort -nr | head -3
}
