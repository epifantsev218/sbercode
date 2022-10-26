Запустим экземпляр приложения для отправки HTTP-запросов

`client.yml`{{open}}

`oc apply -f client.yml`{{execute}}

Дождемся, пока под запустится

`oc get pods -l app=client`{{execute}}

Проверим подключение к внешнему узлу из workload-контейнера пода клиента

`oc exec $(oc get pods -o name -l app=client | head -n 1) -- sh -c 'curl -v http://$EASY_ADDRESS'`{{execute}}

В терминале и логе контейнера istio-proxy видим ошибку, т.к. соединение не настроено

`oc logs $(oc get pods -o name -l app=client | head -n 1) -c istio-proxy`{{execute}}
