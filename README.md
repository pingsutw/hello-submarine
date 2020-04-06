<!---
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

![](https://raw.githubusercontent.com/apache/hadoop-submarine/master/docs/assets/color_logo_with_text.png)

# What is Hadoop Submarine? 

Submarine is a new subproject of Apache Hadoop.

Submarine is a project which allows infra engineer / data scientist to run
*unmodified* Tensorflow or PyTorch programs on YARN or Kubernetes.

Goals of Submarine:
- It allows jobs easy access data/models in HDFS and other storages.
- Can launch services to serve Tensorflow/PyTorch models.
- Support run distributed Tensorflow jobs with simple configs.
- Support run user-specified Docker images.
- Support specify GPU and other resources.
- Support launch tensorboard for training jobs if user specified.
- Support customized DNS name for roles (like tensorboard.$user.$domain:6006)

# hello-submarine 

There is no complete and easy to understand example for beginner, and 
Submarine support many open source infrastructure, it's hard to deploy each runtime 
enviroment for engineer, not to metion data sciences

This repo is aim to let user easily deploy container orchestrations (like Hadoop Yarn, k8s) by 
docker container, support full distributed deep learning example for each runtimes, and
step by step tutorial for beginner.

## Prerequisites
- docker
- Memory > 8G

## Before you start it, you need to know 
- [Hadoop](https://hadoop.apache.org/)
- [Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)
- [Tensorflow](https://www.tensorflow.org/)
- [Pytorch](https://pytorch.org/)

## Build dockerfile
```bash
docker build --tag hello-submarine .
docker run -it -h submarine-dev --name mini-submarine --net=bridge --privileged -P hello-submarine /bin/bash
```
## Pull from dockerhub
```bash
docker pull pingsutw/hello-submarine
docker run -it -h submarine-dev --name mini-submarine --net=bridge --privileged -P pingsutw/hello-submarine /bin/bash
```
## Run submarine CTR Library
```bash
pwd # /home/yarn/submarine
. ./venv/bin/activate

# change directory
cd ..
cd tests

# run locally
python run_deepfm.py -conf deepfm.json -task train
python run_deepfm.py -conf deepfm.json -task evaluate

# run distributedly
SUBMARINE_VERSION=0.4.0-SNAPSHOT
SUBMARINE_HADOOP_VERSION=2.9
SUBMARINE_JAR=/opt/submarine-dist-${SUBMARINE_VERSION}-hadoop-${SUBMARINE_HADOOP_VERSION}/submarine-dist-${SUBMARINE_VERSION}-hadoop-${SUBMARINE_HADOOP_VERSION}/submarine-all-${SUBMARINE_VERSION}-hadoop-${SUBMARINE_HADOOP_VERSION}.jar

java -cp $(${HADOOP_COMMON_HOME}/bin/hadoop classpath --glob):${SUBMARINE_JAR}:${HADOOP_CONF_PATH} \
 org.apache.submarine.client.cli.Cli job run --name deepfm-job-001 \
 --framework tensorflow \
 --verbose \
 --input_path "" \
 --num_workers 2 \
 --worker_resources memory=2G,vcores=4 \
 --num_ps 1 \
 --ps_resources memory=2G,vcores=4 \
 --worker_launch_cmd "myvenv.zip/venv/bin/python run_deepfm.py -conf=deepfm_distributed.json" \
 --ps_launch_cmd "myvenv.zip/venv/bin/python run_deepfm.py -conf=deepfm_distributed.json" \
 --insecure \
 --conf tony.containers.resources=../submarine/myvenv.zip#archive,${SUBMARINE_JAR},deepfm_distributed.json,run_deepfm.py

```
