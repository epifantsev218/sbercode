Применим конфиги, объявляющие проксирование исходящего трафика через Egress

`connection.yml`{{open}}

`oc process -f connection.yml --param-file connection.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

Повторим проверку подключения к Kafka. Подключение успешно

`oc rsh $(oc get pods -o name | grep postgres-client | head -n 1)`{{execute}}
`pg_isready -h pg.apps.sbc-okd.pcbltools.ru -p 5432`{{execute}}
`exit`{{execute}}

В логах Istio Proxy, что запрос к внешнему узлу был перенаправлен на порт 3000 Egress Proxy

`oc logs $(oc get pods -o name | grep postgres-client | head -n 1) -c istio-proxy`{{execute}}

В логах Egress Proxy видим обращение к внешнему узлу

`oc logs $(oc get pods -o name | grep egress | head -n 1)`{{execute}}
