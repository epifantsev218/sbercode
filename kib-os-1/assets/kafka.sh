#!/bin/bash -x
#source ~/.bashrc

OUT_FILE=~/connection.env
DONE_FILE=/usr/local/etc/k8s.sh.done

_user=student
infra_project=infra
work_project=work

infra_context=${infra_project}-${_user}
work_context=${work_project}-${_user}

oc config use-context ${infra_context}
curr_project=$(oc project -q)

####deploy kafka
sed "s/PROJECT_PLACEHOLDER/${curr_project}/g" /usr/local/kafka/kafka.yml |oc apply -f-
kafka_ip=$(oc get service kafka -o template --template {{.spec.clusterIP}})
sed "s/KAFKA_IP/${kafka_ip}/g" /usr/local/kafka/connection.env >> $OUT_FILE
####end

oc config use-context ${work_context}
touch $DONE_FILE
