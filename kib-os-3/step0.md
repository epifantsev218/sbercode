Запустим экземпляр приложения для отправки HTTP-запросов

`client.yml`{{open}}

`oc apply -f client.yml`{{execute}}

Дождемся, пока под запустится

`oc get pods | grep client`{{execute}}

Подключаемся к терминалу workload-контейнера пода

`oc rsh $(oc get pods -o name | grep client | head -n 1)`{{execute}}

Проверяем подключение к внешнему узлу

`curl -v http://$EASY_ADDRESS`{{execute}}

В терминале видим ошибку соединения, выходим из терминала контейнера приложения

`exit`{{execute}}

Видим ошибку в логе istio-proxy, т.к. соединение не настроено

`oc logs $(oc get pods -o name | grep client | head -n 1) -c istio-proxy`{{execute}}


TODO REGISTRY_ONLY
