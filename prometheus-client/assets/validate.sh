#!/bin/bash

[ -f /root/results.txt ] || { echo "Создайте файл results.txt"; exit 1; }

RPS=`awk 'NR==1' /root/results.txt  | awk -F: '{print $2}' | sed -e 's/ //g'`
LATENCY=`awk 'NR==2' /root/results.txt  | awk -F: '{print $2}' | sed -e 's/ //g'`

[ -z "$RPS" ] && echo "Введите не пустое значение количество запросов в секунду"
[ -z "$LATENCY" ] && echo "Введите не пустое значение квантиля 0.9 для длительности запросов"

if [ -z "$RPS" ] || [ -z "LATENCY" ]; then  exit 1 ; fi