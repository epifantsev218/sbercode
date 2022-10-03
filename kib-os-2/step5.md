Mutual TLS - взаимная проверка клиентом и сервером сертификатов друг друга

`oc process -f mutual.yml --param-file mutual-params.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

При попытке вызова без клиентского сертификата получим ошибку SSL Handshake

`curl -v --cacert ./certs/crt.pem https://mutual-test-server.apps.dev-gen2.delta.sbrf.ru`{{execute}}

`curl: (35) schannel: next InitializeSecurityContext failed: SEC_E_ILLEGAL_MESSAGE (0x80090326) - This error usually occurs when a fatal SSL/TLS alert is received (e.g. handshake failed). More detail may be available in the Windows System event log.`

Отправим запрос с сертификатом клиента. Встроенный в Windows curl не умеет работать с сертификатами, выпущенными
OpenSSL

`curl -v --cacert ./certs/crt.pem --cert ./certs/crt.pem --key ./certs/key.pem https://mutual-test-server.apps.dev-gen2.delta.sbrf.ru`
{{execute}}

В логах Ingress Proxy видим успешный запрос через порт 3001

`[2022-05-28T10:11:04.255Z] "GET / HTTP/2" 200 - "-" "-" 0 17 2 1 "29.64.242.1" "curl/7.78.0" "b421ee57-cb8c-9a48-a426-91eebb138155" "mutual-test-server.apps.dev-gen2.delta.sbrf.ru" "29.64.49.192:8080" outbound|8080||server.ci00706316-idevgen2-loans-for-business-dev2.svc.cluster.local 29.64.41.171:56146 29.64.41.171:3001 29.64.242.1:59398 mutual-test-server.apps.dev-gen2.delta.sbrf.ru -`