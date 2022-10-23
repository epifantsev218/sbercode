Применим настройки Simple TLS. Для Simple TLS требуется указать только цепочки доверенных УЦ. Т.к.
используем самоподписанный сертификат, то используем его вместо цепочек

`oc process -f simple.yml --param-file simple-params.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

Проверим подключение

`oc rsh $(oc get pods -o name | grep client | head -n 1)`{{execute}}
`curl -v http://$SIMPLE_ADDRESS`{{execute}}
`exit`{{execute}}

В логах Istio Proxy, что запрос к внешнему узлу был перенаправлен на порт 3000 Egress Proxy

`oc logs $(oc get pods -o name | grep client | head -n 1) -c istio-proxy`{{execute}}

В логах Egress Proxy видим обращение к внешнему узлу

`oc logs $(oc get pods -o name | grep egress | head -n 1)`{{execute}}
