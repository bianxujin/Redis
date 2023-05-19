#! /bin/bash


DIR=$(cd "$(dirname "$0")";pwd)
. $DIR/base_info.sh


#Configuration parameter to modify
KEY=$1
#The value of the configuration parameter
VALUE=$2
REDIS_CLI="$REDIS_HOME/redis-5.0.5/src/redis-cli"
CONFILE_FILE=$DATA_DIR/$CUR_PORT/redis.conf
echo "$CONFILE_FILE"
for ((i=0; i<NUM_OF_NODES; i++))
do
	CUR_PORT=$((START_PORT + i))
  	echo "IP: $LOCAL_IP  Port: $CUR_PORT   config set $1 $2"
  	${REDIS_CLI} -h ${LOCAL_IP} -p ${CUR_PORT}  -c -a ${AUTH} --no-auth-warning config set $1 $2
  	current_value=$($REDIS_CLI -c -h ${LOCAL_IP} -p ${CUR_PORT}  -a ${AUTH} --no-auth-warning  config get ${KEY} | awk 'NR==2')
  	if [ "$current_value" = "$2" ]; then
    		echo "$KEY parameter has been modified successfully on node $HOST:$CUR_PORT"
  	else
    		echo "Failed to modify ${KEY} parameter on node $HOST:$CUR_PORT"
  	fi

	if grep -q "$KEY" $DATA_DIR/$CUR_PORT/redis.conf;then
		if grep -q "^#$KEY" $DATA_DIR/$CUR_PORT/redis.conf;then
		       #sed -i "s/^#\($KEY .*\)$/\1/" $DATA_DIR/$CUR_PORT/redis.conf	
                       sed -i "s/^# $KEY .*/$KEY $VALUE/g" $DATA_DIR/$CUR_PORT/redis.conf
		       echo "11111"
	        else
			sed -i "s/^$KEY .*/$KEY $VALUE/g" $DATA_DIR/$CUR_PORT/redis.conf
			echo "2222"
		fi	
	else
		echo "$KEY not found,appending to end of file."
	 	echo "$KEY" "$VALUE" >> $DATA_DIR/$CUR_PORT/redis.conf && echo "Append successful!"
	fi

done

