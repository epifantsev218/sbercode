Чтобы проверять внешнее подключение, развернем образ, содержащий в себе клиент Kafka

`kafka-client.yml`{{open}}

`oc apply -f kafka-client.yml`{{execute}}

Дождемся, пока под с клиентом запустится

`oc get pods | grep kafka-client`{{execute}}

Подключаемся к терминалу workload-контейнера пода


