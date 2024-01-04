#!/bin/bash

#The absolute path of the directory where the shell script is located
DIR=$(cd "$(dirname "$0")";pwd)

#ssh port
SSH_PORT=22
# Get IP Address of the  local server
#IFCONFIG_PATH=`which ifconfig`
#LOCAL_IP=`$IFCONFIG_PATH -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
LOCAL_IP=`LC_ALL=C /usr/sbin/ifconfig  -a| grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`


#REDIS version
REDIS_VERSION=6.2.14

#The redis binary home directory
REDIS_HOME="/data/redis/app/redis-$REDIS_VERSION"



#The redis software dir
REDIS_SRC_DIR=/home/tool/redis-$REDIS_VERSION

#config file ,pid file, logs,dump file
DATA_DIR="/data/redis/redis-cluster/data"

#start port and Number of nodes to create. 
START_PORT=6000
NUM_OF_NODES=2
#NUM_OF_NODES=10

#host file
HOST_FILE=$DIR/hosts.txt

#The redis password
AUTH="YzLgn2NhXC"

#ssh 
SSH="ssh -p $SSH_PORT"
SCP="scp -P $SSH_PORT"
