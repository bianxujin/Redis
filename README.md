# 1.安装步骤
  1. 将规划主机IP写入hosts.txt文件
  2. 执行本地节点的初始化init_local.sh
  3. 启动本地节点start_local.sh
  4. 集群初始化 init_cluster.sh
 


# 2.redis cluster slot 迁移脚本(redis-shard.sh)，
#脚本运行示例：
#redis-shard.sh <src-ip> <src-port> <dest-ip> <dest-port> <hslot-start> <hslot-end>
redis-shard.sh  10.11.110.56 8000  10.11.110.55 8020  410 818

  
