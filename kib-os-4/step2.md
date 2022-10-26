Настроим маршрутизацию исходящего трафика через Egress Gateway

`connection.yml`{{open}}

`connection.env`{{open}}

`oc process -f connection.yml --param-file connection.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

Повторим проверку подключения к PostgreSQL. Подключение успешно

`oc exec $(oc get pods -o name -l app=postgresql-client | head -n 1) -- bash -c 'pg_isready -h $PG_ADDRESS -p 5432'`{{execute}}

В логах istio-proxy, что запрос к внешнему узлу был перенаправлен на порт 3000 Egress Gateway

`oc logs $(oc get pods -o name -l name=kafka-client | head -n 1) -c istio-proxy`{{execute}}

``

В логах Egress Gateway видим обращение к внешнему узлу

`oc logs $(oc get pods -o name | grep egress | head -n 1)`{{execute}}

``
