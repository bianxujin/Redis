#! /bin/bash


DIR=$(cd "$(dirname "$0")";pwd)
. $DIR/base_info.sh
. $DIR/init_local.sh

REDIS_CLI="$REDIS_HOME/src/redis-cli"



masters=$($REDIS_CLI -h ${LOCAL_IP} -p ${CUR_PORT}  -c -a ${AUTH} --no-auth-warning cluster nodes | grep "master" |grep -v 'fail' | sort -k9 -n)
IFS=$'\n'
echo -e "MASTER SLAVE INFO"

printf "%-40s %-20s %-20s %-20s\n" "hashCode" "master" "slave" "hashSlot"
for master in $masters; do
    master_id=$(echo $master | awk -F ' ' '{print $1}')
    master_info=($(echo $master | awk '{print $2}' | awk -F '@' '{print $1}' | tr ':' ' '))
    master_ip=$(echo $master_info | awk -F ' ' '{print $1}')
    master_port=$(echo $master_info | awk -F ' ' '{print $2}')
    hash_solt=$(echo $master | awk '{print $NF}')
    slaves=$($REDIS_CLI -h ${LOCAL_IP} -p ${CUR_PORT}  -c -a ${AUTH} --no-auth-warning cluster nodes | grep "slave" | grep -v 'handshake|fail' | grep $master_id)
    # 遍历所有从节点，输出其IP和端口
    for slave in $slaves
    do   
         slave_info=$(echo $slave | awk -F ' '  '{print $2}' | awk -F '@' '{print $1}')
         slave_ip=$(echo $slave_info | awk -F ':' '{print $1}')
         slave_port=$(echo $slave_info | awk -F ':' '{print $2}')
         result=$(echo $slave | grep 'fail')
	 if [[ "$result" = "" ]];then
	 	printf "%-40s %-20s %-20s %-30s\n" "$master_id" "$master_ip:$master_port" "$slave_ip:$slave_port" "$hash_solt"
	 else
	        slave_ip=""
		slave_port=""
		printf "%-40s %-20s %-20s %-30s\n" "$master_id" "$master_ip:$master_port" "$slave_ip$slave_port"  "$hash_solt"
	 fi 
   done

done
