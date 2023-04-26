#!/bin/bash

#scp install package 


DIR=$(cd "$(dirname "$0")";pwd)
. $DIR/base_info.sh
. $DIR/init_local.sh
for HOST in `cat $HOST_FILE`
do
	echo "ssh $HOST......"
	$SCP -r $REDIS_SRC_DIR  $USERNAME@$HOST:$REDIS_HOME
done
