Для настройки нужно знать имя проекта, а также имя Control Plane, к которой подключен проект. Найдем название в описании проекта

Получим имя проекта

`oc project -q`{{execute}}

Получим имя Control Plane

`oc describe project $(oc project -q) | grep member-of | head -n 1 | cut -d '=' -f2`{{execute}}

Создадим Deployment Egress Gateway. Для настройки требуется:
* имя проекта
* имя Control Plane
* название сервиса Egress. Название должно содержать КЭ АС. Это требование сопровождения Istio
* перечень портов, используемых для организаци трафика через Egress Proxy. Все порты должны быть объявлены в Service Egress Gateway

Заполните имена проекта и Control Plane в файле

`egress-params.env`{{open}}

`oc process -f egress-template.yml --param-file egress-params.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}


В логах пода Egress Gateway необходимо дождаться сообщения

`Envoy Proxy is ready`

`oc logs $(oc get pods -o name | grep egress | head -n 1)`{{execute}}
