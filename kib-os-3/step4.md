Применим настройки Mutual TLS. Для Mutual TLS кроме цепочек УЦ необходимо указать открытую и закрытую части сертификата

`oc process -f mutual.yml --param-file mutual-params.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

Проверим подключение

`oc rsh $(oc get pods -o name | grep client | head -n 1)`{{execute}}
`curl -v http://$MUTUAL_ADDRESS`{{execute}}
`exit`{{execute}}

В логах Istio Proxy, что запрос к внешнему узлу был перенаправлен на порт 3001 Egress Proxy

`oc logs $(oc get pods -o name | grep client | head -n 1) -c istio-proxy`{{execute}}

В логах Egress Proxy видим обращение к внешнему узлу

`oc logs $(oc get pods -o name | grep egress | head -n 1)`{{execute}}
