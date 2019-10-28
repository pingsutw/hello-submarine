FROM ubuntu:16.04

ARG hadoop_v=2.9.2
ARG spark_v=2.4.4
ARG submarine_v=0.3.0-SNAPSHOT
ARG zookeeper_v=3.4.14

#INSTALL JAVA
RUN apt-get -q update \
    && apt-get -q install -y --no-install-recommends openjdk-8-jdk libbcprov-java \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

#INSTALL Docker
RUN \
  apt-get update && \
  apt-get -y install apt-transport-https ca-certificates curl software-properties-common && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
  apt-get update && \
  apt-get -y install docker-ce
# So no need to mount host's /var/run/docker.sock, dockerd will create in local fs
VOLUME /var/lib/docker

#INSTALL user tools
RUN \
  apt-get update && \
  apt-get -y install vim && \
  apt-get install -y wget && \
  apt-get install -y git

#install Hadoop
RUN \
    mkdir -p /usr/local/hadoop && \
    cd /usr/local/hadoop && \
    wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-${hadoop_v}/hadoop-${hadoop_v}.tar.gz && \
    tar -zxvf hadoop-${hadoop_v}.tar.gz

#install spark
RUN \
    wget http://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-${spark_v}/spark-${spark_v}-bin-hadoop2.7.tgz && \
    tar -zxvf spark-${spark_v}-bin-hadoop2.7.tgz

#install zookeeper
RUN \
    wget http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-${zookeeper_v}/zookeeper-${zookeeper_v}.tar.gz && \
    tar -zxvf zookeeper-${zookeeper_v}.tar.gz

ENV HADOOP_PREFIX=/usr/local/hadoop \
    HADOOP_COMMON_HOME=/usr/local/hadoop \
    HADOOP_HDFS_HOME=/usr/local/hadoop \
    HADOOP_MAPRED_HOME=/usr/local/hadoop \
    HADOOP_YARN_HOME=/usr/local/hadoop \
    HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop \
    YARN_CONF_DIR=/usr/local/hadoop/etc/hadoop \
    PATH=${PATH}:/usr/local/hadoop/bin


WORKDIR $HADOOP_PREFIX

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
# ZK ports
EXPOSE 2181 2888 3888
#Other ports
EXPOSE 49707 2122
# Workbench port
EXPOSE 8080
