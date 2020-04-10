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
### Running Examples
To run the examples here, you need to:
- Build a Python virtual environment with pysubmarine installed
- Install Submarine 0.3.0+
### Running DeepFM on a local machine
1. Create a JSON configuration file containing train,valid and test data, model parameters, 
metrics, save model path, resources. e.g. [deepfm.json](./deepfm.json)

2. Install submarine python bindings by setup.py:
```
python ./submarine/submarine-sdk/setup.py install
```
2. Train
```
python run_deepfm.py -conf=deepfm.json -task_type train
```
3. Evaluate
```
python run_deepfm.py -conf=deepfm.json -task_type evaluate
```
### Running DeepFM on Submarine
1. Upload data to a shared file system like hdfs, s3.

2. Create a JSON configuration file for distributed training. e.g. [deepfm_distributed.json](./deepfm_distributed.json)

3. Submit Job
```
SUBMARINE_VERSION=0.4.0
SUBMARINE_HADOOP_VERSION=2.9

java -cp $(${HADOOP_COMMON_HOME}/bin/hadoop classpath --glob):submarine-all-${SUBMARINE_VERSION}-hadoop-${SUBMARINE_HADOOP_VERSION}.jar:${HADOOP_CONF_PATH} \
 org.apache.submarine.client.cli.Cli job run --name deepfm-job-001 \
 --framework tensorflow \
 --verbose \
 --input_path "" \
 --num_workers 2 \
 --worker_resources memory=4G,vcores=4 \
 --num_ps 1 \
 --ps_resources memory=4G,vcores=4 \
 --worker_launch_cmd "myvenv.zip/venv/bin/python run_deepfm.py -conf=deepfm_distributed.json" \
 --ps_launch_cmd "myvenv.zip/venv/bin/python run_deepfm.py -conf=deepfm_distributed.json" \
 --insecure \
 --conf tony.containers.resources=myvenv.zip#archive,submarine-all-${SUBMARINE_VERSION}-hadoop-${SUBMARINE_HADOOP_VERSION}.jar,deepfm_distributed.json,run_deepfm.py \
 --conf tony.chief.instances=1 \
 --conf tony.chief.memory=4G \
 --conf tony.chief.vcores=4 \
 --conf tony.chief.command="myvenv.zip/venv/bin/python run_deepfm.py -conf=deepfm_distributed.json"
```
