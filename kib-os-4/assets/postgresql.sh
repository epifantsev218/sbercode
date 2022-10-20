#!/bin/bash -x
PS1=1
source /root/.bashrc

OUT_FILE=~/connection.env
DONE_FILE=/usr/local/etc/k8s.sh.done

_user=student
infra_project=infra
work_project=work

infra_context=${infra_project}-${_user}
work_context=${work_project}-${_user}

oc config use-context ${infra_context}
curr_project=$(oc project -q)

####deploy postgres
pgpass=$(cat /proc/sys/kernel/random/uuid)
oc create secret generic pg-postgresql --from-literal=postgres-password="$pgpass" --dry-run=client -oyaml \
| oc apply -f-
oc apply -f /usr/local/pg/postgresql.yml -n "${curr_project}"
pg_ip=$(oc get service pg -o template --template {{.spec.clusterIP}})
sed "s/PG_IP/${pg_ip}/g" /usr/local/pg/connection.env >> $OUT_FILE
####end

oc config use-context ${work_context}
touch $DONE_FILE
