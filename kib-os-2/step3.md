Для настройки нужно знать, к какому Control Plane подключен проект. Найдем название в описании проекта

`oc describe project ci00706316-idevgen2-loans-for-business-dev2  | grep member-of`{{execute}}

Создадим Deployment Ingress Gateway. Для настройки требуется:
* имя проекта
* имя Control Plane
* название сервиса Ingress. Название должно содержать КЭ АС. Это требование сопровождения Istio
* перечень портов, используемых для организации трафика через Ingress Proxy. Все порты должны быть объявлены в Service Ingress Gateway
* secret, содержащий сертификаты, которые будут использоваться для настройки соединений. Они должны пыть монтированы в Deployment Ingress Gateway (см. блоки Volumes и VolumeMounts)

Заполните имена проекта и Control Plane в файле

`ingress-params.env`{{open}}

`oc process -f ingress-template.yml --param-file ingress-params.env -o yaml > conf.yml
oc apply -f conf.yml`{{execute}}

В логах пода Ingress Gateway необходимо дождаться сообщения

`Envoy Proxy is ready`

`oc get logs $(oc get pods -o name | grep ingress | head -n 1)`{{execute}}
