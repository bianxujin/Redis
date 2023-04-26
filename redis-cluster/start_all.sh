#!/bin/bash


DIR=$(cd "$(dirname "$0")";pwd)

. $DIR/base_info.sh
. $DIR/init_local.sh


for HOST in `cat $HOST_FILE`
do
        echo "ssh $HOST......"
        $SSH -n -T  $USERNAME@$HOST "$DIR/start_local.sh"
done
