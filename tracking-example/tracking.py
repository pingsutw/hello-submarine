# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from comet_ml import Experiment
import submarine
from submarine.utils import env

experiment = Experiment(api_key="ej6XeyCVjqHM8uLDNj5VGrzjP",
                        project_name="testing", workspace="pingsutw")

if __name__ == "__main__":
    submarine.set_tracking_uri(
        "mysql+pymysql://submarine:password@140.116.245.134:3306/submarine")

    print("TF_CONFIG", env.get_env("TF_CONFIG"))
    print("JOB_NAME: ", env.get_env("JOB_NAME"))
    print("TYPE: ", env.get_env("TPYE"))
    print("TASK_INDEX: ", env.get_env("TASK_INDEX"))
    print("CLUSTER_SPEC: ", env.get_env("CLUSTER_SPEC"))
    print("RANK: ", env.get_env("RANK"))

    submarine.log_param("max_iter", 100)
    submarine.log_param("learning_rate", 0.0001)
    submarine.log_param("alpha", 20)
    submarine.log_param("batch_size", 256)

    submarine.log_metric("score", 2)
    submarine.log_metric("score", 5)
    submarine.log_metric("score", 8)
    submarine.log_metric("score", 5)
    submarine.log_metric("score", 10)

    submarine.log_metric("AUC", 0.62)
    submarine.log_metric("AUC", 0.68)
    submarine.log_metric("AUC", 0.75)
    submarine.log_metric("AUC", 0.64)
    submarine.log_metric("AUC", 0.79)
    submarine.log_metric("AUC", 0.86)

    submarine.log_metric("loss", 0.50)
    submarine.log_metric("loss", 0.36)
    submarine.log_metric("loss", 0.68)
    submarine.log_metric("loss", 0.36)
    submarine.log_metric("loss", 0.43)
    submarine.log_metric("loss", 0.22)

