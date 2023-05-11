`ssh-keygen -f ~/.ssh/id_rsa`{{execute}}

`ssh localhost`{{execute}}

`cat ~/.ssh/id_rsa.pub >  ~/.ssh/authorized_keys`{{execute}}

`cat ~/.ssh/authorized_keys`{{execute}}

`ssh localhost`{{execute}}

`cat ~/.ssh/known_hosts`{{execute}}

Для проверки

`ssh localhost -f 'pwd'`{{execute}}