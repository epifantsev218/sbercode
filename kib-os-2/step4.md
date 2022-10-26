Применим настройки Simple TLS подключения. Simple TLS - односторонняя проверка клиентом сертификата сервера

Изучите шаблон для настройки Simple TLS на Ingress Gateway в файле, обратите внимание на комментарии

`simple.yml`{{open}}

Документация по объектам Openshift и Istio, использущимся для настройки маршрутизации:

* [Route](https://docs.openshift.com/container-platform/4.7/networking/routes/route-configuration.html)
* [Gateway](https://istio.io/latest/docs/reference/config/networking/gateway/)
* [Virtual Service](https://istio.io/latest/docs/reference/config/networking/virtual-service/)

Уточните параметры Simple TLS соединения

`simple-params.env`{{open}}

Значение параметра SIMPLE_URL должно присутствовать в alt_names сертификата

`oc process -f simple.yml --param-file simple-params.env -o yaml > conf.yml
oc apply -f conf.yml
export $(cat simple-params.env | xargs)`{{execute}}

Выполним запрос. В результате увидим ошибку SSL Handshake, т.к. клиент не доверяет самоподписанному серверному
сертификату

`curl -v https://${SIMPLE_URL}`{{execute}}

`curl: (60) SSL certificate problem: self signed certificate`

Добавим сертификат в перечень доверенных и запрос будет обработан успешно

`curl -v --cacert ./certs/crt.pem https://${SIMPLE_URL}`{{execute}}

В логах Ingress Gateway видим успешный запрос через порт 3000

`oc logs $(oc get pods -o name | grep ingress | head -n 1)`{{execute}}

`[2022-10-05T20:56:15.535Z] "GET / HTTP/2" 200 - via_upstream - "-" 0 44 1 1 "10.129.0.1" "curl/7.68.0" "841d47fc-a5bb-939f-b41c-2be4fca427c2" "simple.apps.sbc-okd.pcbltools.ru" "10.128.3.112:8080" outbound|8080||server.sbercode-654d59b9-0701-4932-a22d-bb524ae4bb5b-work.svc.cluster.local 10.131.1.130:52342 10.131.1.130:3000 10.129.0.1:38002 simple.apps.sbc-okd.pcbltools.ru -`

В логах контейнера istio-proxy сервера видим успешный запрос от Ingress Gateway

`oc logs $(oc get pods -o name -l app=server | head -n 1) -c istio-proxy`{{execute}}

