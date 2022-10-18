Чтобы проверять внешнее подключение, развернем образ, содержащий в себе клиент Kafka

`kafka-client.yml`{{open}}

`oc apply -f kafka-client.yml`{{execute}}

Дождемся, пока под с клиентом запустится

`oc get pods | grep kafka-client`{{execute}}

Подключаемся к терминалу workload-контейнера пода

`oc rsh $(oc get pods -o name | grep kafka-client | head -n 1)`{{execute}}

Проверяем подключение к кластеру Kafka

`kafka-topics --bootstrap-server $KAFKA_ADDRESS --list`{{execute}}

В терминале видим ошибку соединения, в логах прокси - ошибку UH. Формат логов и описание кодов ошибок можно найти на
странице https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage
UH: No healthy upstream hosts in upstream cluster in addition to 503 response code.

`[2022-05-20T13:18:50.858Z] "- - -" 0 UH "-" "-" 0 0 0 - "-" "-" "-" "-" "-" - - 10.116.207.70:2181 29.65.126.220:38318 - -`

Выходим из консоли терминала контейнера приложения

`exit`{{execute}}


