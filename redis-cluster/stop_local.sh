#!/bin/bash
 
DIR=$(cd "$(dirname "$0")";pwd)
. $DIR/base_info.sh



for pid in `ps -ef | grep redis-5.0.5| grep -v rep  | awk '{print $2}'`
do	echo "stop redis sever!"
	kill $pid
done
