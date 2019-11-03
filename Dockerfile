FROM ubuntu:16.04

ARG hadoop_v=2.9.2
ARG spark_v=2.4.4
ARG submarine_v=0.3.0-SNAPSHOT
ARG zookeeper_v=3.4.14

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

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
  apt-get install -y git && \
  apt-get install -y maven

#install Hadoop
RUN \
    cd /usr/local/ && \
    wget https://www.apache.org/dist/hadoop/core/hadoop-${hadoop_v}/hadoop-${hadoop_v}.tar.gz && \
    tar -zxvf hadoop-${hadoop_v}.tar.gz && \
    mv ./hadoop-${hadoop_v} hadoop

#install zookeeper
RUN \
    cd /usr/local/ && \
    wget http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-${zookeeper_v}/zookeeper-${zookeeper_v}.tar.gz && \
    tar -zxvf zookeeper-${zookeeper_v}.tar.gz && \
    mv ./zookeeper-${zookeeper_v} zookeeper

# Create users
RUN \
  groupadd -g 1007 hadoop && \
  useradd -m -G hadoop -u 1008 -s /bin/bash yarn && \
  chown -R root:hadoop /usr/local/hadoop && \
  chown -R yarn:hadoop /usr/local/zookeeper

#install spark
RUN \
    cd /usr/local/ && \
    wget http://ftp.mirror.tw/pub/apache/spark/spark-${spark_v}/spark-${spark_v}-bin-hadoop2.7.tgz && \
    tar -xvf spark-${spark_v}-bin-hadoop2.7.tgz && \
    mv ./spark* /opt

ADD spark-defaults-dynamic-allocation.conf /opt/spark-${spark_v}/conf/spark-defaults.conf

RUN \
  apt-get update && \
  apt-get install -y vim python python-numpy wget zip python3

# Add pyspark sample
ADD spark-script /home/yarn/spark-script
RUN chown -R yarn /home/yarn/spark-script && \
    chmod +x -R /home/yarn/spark-script

# Add distributedShell example
ADD conf/yarn-ds-docker.sh /home/yarn
RUN chown -R yarn /home/yarn/yarn-ds-docker.sh && \
    chmod +x /home/yarn/yarn-ds-docker.sh

#install latest submarine
RUN \
    cd /opt && \
    git clone https://github.com/apache/submarine.git && \
    cd submarine && \
    git submodule update --init --recursive && \
    mvn clean install package -DskipTests && \
    cp -r submarine-dist/target/submarine-dist-${submarine_v}* /opt && \
    cp -r docs/database /home/yarn/database

ADD submarine /home/yarn/submarine

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

# Copy Config
COPY conf /tmp/hadoop-config

# Build virtual python env
RUN cd /home/yarn/submarine && \
    chmod +x /home/yarn/submarine/* && \
    /home/yarn/submarine/build_python_virtual_env.sh

# Grant read permission for submarine job
RUN chown yarn /home/yarn/submarine