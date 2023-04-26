#!/bin/bash


DIR=$(cd "$(dirname "$0")";pwd)
. $DIR/base_info.sh
. $DIR/init_local.sh


REDIS_CLI="$REDIS_HOME/redis-5.0.5/src/redis-cli"
NODES=$($REDIS_CLI -h ${LOCAL_IP} -p ${START_PORT}  -c -a ${AUTH} --no-auth-warning  cluster nodes | awk '{print $2}')

IFS=$'\n'
printf "%-30s %-30s %-30s %-30s\n" "Redis Instance" "used_memory_human" "used_memory_rss_human" "connected_clients"
for node in $NODES
do     
        IP=$(echo $node | cut -d ":" -f 1)
        PORT=$(echo $node | cut -d ":" -f 2)
        NODE_PORT=`echo $PORT | awk -F '@' '{print $1}'`
	Ping_Res=$($REDIS_CLI -h ${node%:*} -p ${node#*:} -c -a ${AUTH} --no-auth-warning  ping  2>&1) 
	if [[ "$Ping_Res"x = "PONG"x ]]; then
        	Used_Memory=$($REDIS_CLI -h ${node%:*} -p ${node#*:} -c -a ${AUTH} --no-auth-warning  info memory | grep used_memory_human: | tr -d '\r')
        	Used_Rss_Memory=$($REDIS_CLI -h ${node%:*} -p ${node#*:} -c -a ${AUTH} --no-auth-warning  info memory | grep used_memory_rss_human: |  tr -d '\r')
        	Clients=$($REDIS_CLI  -h ${node%:*} -p ${node#*:} -c -a ${AUTH} --no-auth-warning info  clients | grep connected_clients: |  tr -d '\r')
        	printf "%-30s %-30s %-30s %-30s\n" "$IP:$NODE_PORT" $Used_Memory $Used_Rss_Memory $Clients
	fi

done
