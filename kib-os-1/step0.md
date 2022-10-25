Чтобы проверять внешнее подключение, развернем образ, содержащий в себе клиент Kafka

`kafka-client.yml`{{open}}

`oc apply -f kafka-client.yml`{{execute}}

Дождемся, пока под с клиентом запустится

`oc get pods | grep kafka-client`{{execute}}

Подключаемся к терминалу workload-контейнера пода

`oc rsh $(oc get pods -o name | grep kafka-client | head -n 1)`{{execute}}

Проверяем подключение к брокеру Kafka

`kafka-topics.sh --bootstrap-server $KAFKA_ADDRESS --list`{{execute}}

В терминале видим ошибку соединения, выходим из терминала контейнера приложения

`exit`{{execute}}

`oc exec $(oc get pods -o name -l name=kafka-client | head -n 1) -- bash -c 'kafka-topics.sh --bootstrap-server $KAFKA_ADDRESS --list'`
{{execute}}

В логах прокси видим ошибку с кодом UH

`oc logs $(oc get pods -o name -l name=kafka-client | head -n 1) -c istio-proxy`{{execute}}

Изучите формат логов Envoy Proxy и описание кодов ошибок
на [странице](https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage)

`UH: No healthy upstream hosts in upstream cluster in addition to 503 response code.`

`2022-10-25T20:37:07.830Z] "- - -" 0 UH - - "-" 0 0 0 - "-" "-" "-" "-" "-" - - 178.170.196.65:9092 10.128.3.43:56440 - -`
