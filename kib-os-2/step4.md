Применим настройки Simple TLS подключения. Simple TLS - односторонняя проверка клиентом сертификата сервера

Уточните параметры генерируемого сертификата в файле

`simple-params.env`{{open}}

Значение параметра SIMPLE_URL должно присутствовать в alt_names сертификата

`oc process -f simple.yml --param-file simple-params.env -o yaml > conf.yml
oc apply -f conf.yml
export $(cat simple-params.env | xargs)`{{execute}}

Выполним запрос. В результате увидим ошибку SSL Handshake, т.к. клиент не доверяет самоподписанному серверному
сертификату

`curl -v https://${SIMPLE_URL}`{{execute}}

`curl: (60) schannel: SEC_E_UNTRUSTED_ROOT (0x80090325) - Цепочка сертификатов выпущена центром сертификации, не имеющим доверия.
More details here: https://curl.se/docs/sslcerts.html                                                                                                                                                                                                                                                                                                                                                                                 curl failed to verify the legitimacy of the server and therefore could not establish a secure connection to it. To learn more about this situation and how to fix it, please visit the web page mentioned above.`

Добавим сертификат в перечень доверенных и запрос будет обработан успешно. В логах Ingress Proxy видим успешный запрос
через порт 3000

`curl -v --cacert ./certs/crt.pem https://${SIMPLE_URL}`{{execute}}

`oc get logs $(oc get pods -o name | grep ingress | head -n 1)`{{execute}}

`[2022-05-28T10:06:48.715Z] "GET / HTTP/1.1" 200 - "-" "-" 0 17 11 11 "29.64.247.1" "curl/7.79.1" "0621db1b-a387-9140-987f-9023608d0479" "simple-test-server.apps.dev-gen2.delta.sbrf.ru" "29.64.49.192:8080" outbound|8080||server.ci00706316-idevgen2-loans-for-business-dev2.svc.cluster.local 29.64.41.171:40186 29.64.41.171:3000 29.64.247.1:33990 simple-test-server.apps.dev-gen2.delta.sbrf.ru -`
