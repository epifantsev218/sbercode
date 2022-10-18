Для объявления возможности подключения к внешнему узлу используется объект Istio ServiceEntry 
https://istio.io/latest/docs/reference/config/networking/service-entry/

Шаблон ServiceEntry для настройки TCP-соединения с внешним узлом находятся в файле

`easy.yml`{{open}}

Применим настройки ServiceEntry с параметрами из файла connection.env

`oc process -f easy.yml --param-file connection.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

Повторим проверку подключения к Kafka. Подключение успешно. 
В логах контейнера istio-proxy видим прямое обращение к узлу Kafka

`oc rsh $(oc get pods -o name | grep kafka-client | head -n 1)`{{execute}}
`kafka-topics.sh --bootstrap-server $KAFKA_ADDRESS --list`{{execute}}
`exit`{{execute}}


`oc rsh $(oc get pods -o name | grep kafka-client | head -n 1)
kafka-topics.sh --bootstrap-server $KAFKA_ADDRESS --list
exit`{{execute}}

Удаляем созданные конфиги

`oc delete serviceentry -l marker=practice`{{execute}}