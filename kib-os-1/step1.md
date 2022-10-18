Для объявления возможности подключения к внешнему узлу используется объект Istio ServiceEntry 
https://istio.io/latest/docs/reference/config/networking/service-entry/

Шаблон ServiceEntry для настройки TCP-соединения с внешним узлом находятся в файле

`easy.yml`{{open}}

Применим настройки ServiceEntry с параметрами из файла connection.env

`oc process -f easy.yml --param-file connection.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

Создадим топик на брокере Kafka. Подключение успешно

`oc rsh $(oc get pods -o name | grep kafka-client | head -n 1)`{{execute}}
`kafka-topics.sh --bootstrap-server $KAFKA_ADDRESS --create --topic test --partitions 1 --replication-factor 1`{{execute}}
`exit`{{execute}}

В логах контейнера istio-proxy видим прямое обращение к узлу Kafka

`oc logs $(oc get pods -o name | grep kafka-client | head -n 1) -c istio-proxy`{{execute}}

`[2022-10-18T20:24:03.639Z] "- - -" 0 - - - "-" 85 585 1100 - "-" "-" "-" "-" "172.30.247.31:9092" outbound|9092||kafka.apps.sbc-okd.pcbltools.ru 10.128.2.33:54464 172.30.247.31:9092 10.128.2.33:54460 - -`

Удаляем созданные конфиги

`oc delete serviceentry -l marker=practice`{{execute}}