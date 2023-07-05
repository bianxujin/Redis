#!/bin/bash


DIR=$(cd "$(dirname "$0")";pwd)

. $DIR/base_info.sh



REDIS_INST=""
REDIS_CLI="$REDIS_HOME/redis-5.0.5/src/redis-cli"


for HOST in `cat $HOST_FILE`
do
        echo "host: $HOST"
	if [ "$HOST" = "$1" ] || [ "$HOST" = "$2" ]; then
	    NUM_OF_NODES=1
            for ((i=0; i<NUM_OF_NODES; i++))
            do
                if [ "$i" -eq "0" ]; then
                firt_port=$((START_PORT + i))
                fi
                CUR_PORT=$((START_PORT + i))
                REDIS_INST=$REDIS_INST" $HOST:$CUR_PORT"
         done
    else
    	NUM_OF_NODES=2
        for ((i=0; i<NUM_OF_NODES; i++))
        do
                if [ "$i" -eq "0" ]; then
                firt_port=$((START_PORT + i))
                fi
                CUR_PORT=$((START_PORT + i))
                REDIS_INST=$REDIS_INST" $HOST:$CUR_PORT"
        done
    fi

done
echo "join node...." $REDIS_INST
echo "yes" |  $REDIS_CLI -c -h ${LOCAL_IP} -p ${firt_port}  -a ${AUTH} --cluster create $REDIS_INST --cluster-replicas 1
echo "Cluster started"
