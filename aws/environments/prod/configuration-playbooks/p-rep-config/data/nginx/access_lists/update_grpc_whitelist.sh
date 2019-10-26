#!/bin/sh

USER="<USER>"
PREP_NODE_LIST_API="localhost:9000/api/v3"
GRPC_WHITELIST="/home/${USER}/nginx/access_lists/grpc_whitelist.conf"
GRPC_WHITELIST_UPDATED="/home/${USER}/nginx/access_lists/grpc_whitelist_updated.conf"
DOCKER_ID=`docker ps | grep nginx | awk '{ print $1 }'`
UPDATE_LOG="/home/${USER}/nginx/access_lists/grpc_whitelist_update.log"
DATE_TIME=`date`

# Check if nginx is running, otherwise we can't access the prep json rpc api
if [ -z "$DOCKER_ID" ]; then
	echo "${DATE_TIME}: ERROR: NGINX docker was not running!" >> ${UPDATE_LOG}
	exit 1
fi

repshash=`curl -s ${PREP_NODE_LIST_API} -d '{ "jsonrpc" : "2.0", "method": "icx_getBlock", "id": 1234 }' | jq '.result.repsHash'`

for IP in `curl -s ${PREP_NODE_LIST_API} -d '{ "jsonrpc" : "2.0", "method": "rep_getListByHash", "id": 1234, "params": {"repsHash": '${repshash}'} }' | jq '.result[].p2pEndpoint' | sed s/\"//g | awk -F: '{ print $1 }'`
do
	echo "allow $IP;" >> "${GRPC_WHITELIST_UPDATED}"
done

oldChecksum=`cksum ${GRPC_WHITELIST} | awk '{ print $1 }'`
newChecksum=`cksum ${GRPC_WHITELIST_UPDATED} | awk '{ print $1 }'`

if [ "$newChecksum" != "$oldChecksum" ]; then
	# Update whitelist
	cat ${GRPC_WHITELIST_UPDATED} > ${GRPC_WHITELIST}
	rm ${GRPC_WHITELIST_UPDATED}
	# Reload NGINX
	docker exec -it ${$DOCKER_ID} sh -c "nginx -s reload"
	echo "${DATE_TIME}: Whitelist has been updated!" >> ${UPDATE_LOG}
else
	rm ${GRPC_WHITELIST_UPDATED}
	echo "${DATE_TIME}: Skip whitelist update due to no changes!" >> ${UPDATE_LOG}
fi
