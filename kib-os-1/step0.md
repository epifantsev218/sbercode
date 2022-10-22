Чтобы проверять внешнее подключение, развернем образ, содержащий в себе клиент Kafka

`kafka-client.yml`{{open}}

`oc apply -f kafka-client.yml`{{execute}}

Дождемся, пока под с клиентом запустится

`oc get pods | grep kafka-client`{{execute}}

Подключаемся к терминалу workload-контейнера пода

`oc rsh $(oc get pods -o name | grep kafka-client | head -n 1)`{{execute}}

Проверяем подключение к брокеру Kafka

`kafka-topics.sh --bootstrap-server $KAFKA_ADDRESS --list`{{execute}}

В терминале видим ошибку соединения, выходим из консоли терминала контейнера приложения

`exit`{{execute}}

В логах прокси видим - ошибку UF,URX. Формат логов и описание кодов ошибок можно найти на странице

https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage

`UF: Upstream connection failure in addition to 503 response code.`
`URX: The request was rejected because the upstream retry limit (HTTP) or maximum connect attempts (TCP) was reached.`

`oc logs $(oc get pods -o name | grep kafka-client | head -n 1) -c istio-proxy`{{execute}}

`[2022-10-18T20:16:39.453Z] "- - -" 0 UF,URX - - "-" 0 0 10000 - "-" "-" "-" "-" "178.170.196.65:9092" PassthroughCluster - 178.170.196.65:9092 10.128.2.32:59026 - - - -`
