#!/usr/bin/bash
HADOOP_DIR=/mnt/local/tell
echo "sudo ${HADOOP_DIR}/hadoop/bin/hadoop fs -mkdir /tpch_data"
sudo ${HADOOP_DIR}/hadoop/bin/hadoop fs -mkdir /tpch_data

echo "sudo ${HADOOP_DIR}/hadoop/bin/hadoop fs -chmod -R 777 /tpch_data"
sudo ${HADOOP_DIR}/hadoop/bin/hadoop fs -chmod -R 777 /tpch_data

echo "${HADOOP_DIR}/hadoop/bin/hadoop fs -copyFromLocal /mnt/SG/marenato-tpch-data/parquet/1/* /tpch_data/."
${HADOOP_DIR}/hadoop/bin/hadoop fs -copyFromLocal /mnt/SG/marenato-tpch-data/parquet/1/* /tpch_data/.

echo "${HADOOP_DIR}/hadoop/bin/hadoop fs -ls /tpch_data"
${HADOOP_DIR}/hadoop/bin/hadoop fs -ls /tpch_data

# create schema into hive
echo "sudo rm -r ${HADOOP_DIR}/hive/metastore_db"
sudo rm -r ${HADOOP_DIR}/hive/metastore_db

 echo "sudo ${HADOOP_DIR}/hive/bin/beeline -u jdbc:hive2:// -f /mnt/SG/marenato/tellproject/PrestoTpch/hive.tpch.parquet.tables"
 sudo ${HADOOP_DIR}/hive/bin/beeline -u jdbc:hive2:// -f /mnt/SG/marenato/tellproject/PrestoTpch/hive.tpch.parquet.tables
