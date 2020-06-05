#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

export HADOOP_PREFIX=/usr/local/hadoop
export HADOOP_COMMON_HOME=/usr/local/hadoop 
export HADOOP_HDFS_HOME=/usr/local/hadoop
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_MAPRED_HOME=/usr/local/hadoop
export HADOOP_YARN_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
export YARN_CONF_DIR=/usr/local/hadoop/etc/hadoop
export PATH=${PATH}:/usr/local/hadoop/bin

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JAVA_HOME/jre/lib/amd64/server
export CLASSPATH=$(${HADOOP_HOME}/bin/hadoop classpath --glob)

exec "$@"
