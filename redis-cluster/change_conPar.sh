#! /bin/bash


DIR=$(cd "$(dirname "$0")";pwd)
. $DIR/base_info.sh
. $DIR/change_local.sh
.  $DIR/init_local.sh 
#Configuration parameter to modify
KEY=$1
#The value of the configuration parameter
VALUE=$2

REDIS_CLI="$REDIS_HOME/redis-5.0.5/src/redis-cli"


for HOST in `cat $HOST_FILE`
do
              
	echo "ssh $HOST......"
	$SSH -n -T $USERNAME@$HOST  "$DIR/change_local.sh"

done

