SUBMARINE_VERSION=0.3.0
HADOOP_VERSION=2.9
java -cp "$(hadoop classpath --glob):submarine-dist-${SUBMARINE_VERSION}-SNAPSHOT-hadoop-${HADOOP_VERSION}/*:submarine-dist-${SUBMARINE_VERSION}-SNAPSHOT-hadoop-${HADOOP_VERSION}/tony-cli-0.3.21-all.jar:." org.apache.submarine.client.cli.Cli job run --name tf-job-001 \
--input_path "/root/submarine-example/mnist_distributed.py" \
--num_workers 2 \
--worker_resources memory=3G,vcores=2 \
--worker_launch_cmd "myvenv.zip/venv/bin/python mnist_distributed.py" \
--insecure \
--conf tony.containers.resources=/root/submarine-example/myvenv.zip#archive,/root/submarine-example/mnist_distributed.py,submarine-dist-${SUBMARINE_VERSION}-SNAPSHOT-hadoop-${HADOOP_VERSION}/tony-cli-0.3.21-all.jar \
--conf tony.application.framework=pytorch

