Для проверки соединения развернем образ с клиентом PostgreSQL

`postgresql-client.yml`{{open}}

`oc apply -f postgresql-client.yml`{{execute}}

Дождемся, пока под с клиентом запустится

`oc get pods | grep postgresql-client`{{execute}}

Проверяем подключение к экземпляру PostgreSQL из терминала workload-контейнера пода

`oc exec $(oc get pods -o name -l app=postgresql-client | head -n 1) -- bash -c 'pg_isready -h pg.apps.sbc-okd.pcbltools.ru -p 5432'`{{execute}}

В логах прокси видим ошибку UF,URX. Формат логов и описание кодов ошибок можно найти на странице

https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage

`UF: Upstream connection failure in addition to 503 response code.`
`URX: The request was rejected because the upstream retry limit (HTTP) or maximum connect attempts (TCP) was reached.`

`oc logs $(oc get pods -o name | grep postgresql-client | head -n 1) -c istio-proxy`{{execute}}

`[2022-10-18T20:16:39.453Z] "- - -" 0 UF,URX - - "-" 0 0 10000 - "-" "-" "-" "-" "178.170.196.65:9092" PassthroughCluster - 178.170.196.65:9092 10.128.2.32:59026 - - - -`
