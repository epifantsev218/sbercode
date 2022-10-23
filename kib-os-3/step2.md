Создадим Deployment Egress Gateway. Обратите внимание, что в блоки Volumes и VolumeMounts добавлен Secret с
сертификатами

`egress-template.yml`{{open}}

Получим имя проекта

`oc project -q`{{execute}}

Получим имя Control Plane

`oc describe project $(oc project -q) | grep member-of | head -n 1 | cut -d '=' -f2`{{execute}}

Заполните имена проекта и Control Plane в файле

`egress-params.env`{{open}}

Создадим Deployment Egress Gateway

`oc process -f egress-template.yml --param-file egress-params.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

В логах пода Egress Gateway необходимо дождаться сообщения

`Envoy Proxy is ready`

`oc logs $(oc get pods -o name | grep egress | head -n 1)`{{execute}}
