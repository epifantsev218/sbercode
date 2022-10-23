Для настройки подключения к внешнему узлу используется объект Istio Service Entry (https://istio.io/
latest/docs/reference/config/networking/service-entry/)
Шаблон ServiceEntry для настройки HTTP-соединения с внешним узлом находятся в файле

`easy.yml`{{open}}

Применим настройки ServiceEntry с параметрами из файла

`easy-params.env`{{open}}

`oc process -f easy.yml --param-file easy-params.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

Повторим проверку подключения. Подключение успешно

`oc rsh $(oc get pods -o name | grep client | head -n 1)`{{execute}}
`curl -v http://$EASY_ADDRESS`{{execute}}
`exit`{{execute}}

В логах контейнера istio-proxy видим прямое обращение к внешнему узлу

`oc logs $(oc get pods -o name | grep client | head -n 1) -c istio-proxy`{{execute}}
