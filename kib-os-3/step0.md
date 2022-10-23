Запустим экземпляр приложения для отправки HTTP-запросов

`oc apply -f client.yml`{{open}}

`oc apply -f client.yml`{{execute}}

Дождемся, пока под запустится

`oc get pods | grep client`{{execute}}

Подключаемся к терминалу workload-контейнера пода

`oc rsh $(oc get pods -o name | grep client | head -n 1)`{{execute}}

Проверяем подключение к внешнему узлу

`curl -v $EASY_ADDRESS`{{execute}}

Видим ошибку в логе istio-proxy, т.к. соединение не настроено

`oc logs $(oc get pods -o name | grep client-client | head -n 1) -c istio-proxy`{{execute}}
