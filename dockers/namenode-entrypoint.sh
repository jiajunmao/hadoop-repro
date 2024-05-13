service sshd restart
hdfs namenode -format -force
hdfs --daemon start namenode
hdfs --daemon start secondarynamenode
yarn --daemon start resourcemanager
hdfs dfs -mkdir -p /wordcount/input
tail -f /dev/null