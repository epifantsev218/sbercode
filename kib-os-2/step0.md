Запустим экземпляр приложения для обработки HTTP-запросов

`oc apply -f server.yml`{{execute}}

Дождемся, пока под с сервером запустится

`oc get pods | grep server`{{execute}}
