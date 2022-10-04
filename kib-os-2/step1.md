Настраиваем HTTP соединение. Это самая простая реализация, но она допустима только для отладки на тестовых стендах

Заполните имя хоста, которое будет использоваться для доступа к сервису, в файле easy.yml

`oc get ingresses.config/cluster -o jsonpath={.spec.domain}`{{execute}}

`oc apply -f easy.yml`{{execute}}

Проверяем соединение. В логах istio-proxy пода server видим успешно обработанный запрос

`curl -v http://test-server.apps.dev-gen2.delta.sbrf.ru`{{execute}}

В выводе команды curl видим код ответа 200, в логах istio-proxy - успешно обработанный запрос

`[2022-05-28T10:51:05.927Z] "- - -" 0 - "-" "-" 357 134 5026 - "-" "-" "-" "-" "127.0.0.1:8080" inbound|8080|tcp-8080|server.ci00706316-idevgen2-loans-for-business-dev2.svc.cluster.local 127.0.0.1:41212 29.64.208.76:8080 29.64.247.1:47428 - -`
