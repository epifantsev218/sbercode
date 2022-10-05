#!/bin/bash

httpbin_retcode="$(curl -o /dev/null -s -w "%{http_code}\n" http://${EASY_URL})"

jq --null-input \
--arg httpbin_retcode "$httpbin_retcode" \
'{"httpbin_retcode": $httpbin_retcode,
}'| jq -n '.results |= [inputs]'