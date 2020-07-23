# Grafana Note
![](https://miro.medium.com/max/4348/1*M8IoU9lYL9oalPVN6PCLUA.png)
![](https://lh3.googleusercontent.com/zeJ7lGSnF3l89OjseQ9ZHjSroiNecGsgmJMuAtYIQUS-P1xaJX5VI3mXnoZ5kOsjP-rNrxEGU-8i17BtMgcxoXgPXq2h_-KysU04zK9Jq6MolpTIdP9HGr7sGDGoPJTzOiw5W_Yf)

## Setup Grafana
- [How to Setup Prometheus Monitoring On Kubernetes Cluster](https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/?unapproved=9640&moderation-hash=61408a85c4ecded160ab5199a9eca3b3#comment-9640)
- [Setting Up Alert Manager on Kubernetes](https://devopscube.com/alert-manager-kubernetes-guide/)
- [How To Setup Kube State Metrics on Kubernetes](https://devopscube.com/setup-kube-state-metrics/)
- [How To Setup Grafana On Kubernetes](https://devopscube.com/setup-grafana-kubernetes/)

## Qucik Install 
```bash= 
k create -f grafana-plugin
k create -f kubernetes-prometheus
k create -f kube-state-metrics-configs
```

#### Open Grafana
- [localhost:32000](localhost:32000)
- Account: `admin`, Password: `admin`
#### Open Prometheus
- [localhost:30000](localhost:30000)

## Container reports
- [PyTorchjob report](https://github.com/kubeflow/pytorch-operator/blob/master/docs/monitoring/README.md)


**CPU usage**
```
sum (rate (container_cpu_usage_seconds_total{pod_name=~"pytorchjob-name-.*"}[1m])) by (pod_name)
```
**GPU Usage**
```
sum (rate (container_accelerator_memory_used_bytes{pod_name=~"pytorchjob-name-.*"}[1m])) by (pod_name)
```
**Memory Usage**
```
sum (rate (container_memory_usage_bytes{pod_name=~"pytorchjob-name-.*"}[1m])) by (pod_name)
```
**Network Usage**
```
sum (rate (container_network_transmit_bytes_total{pod_name=~"pytorchjob-name-.*"}[1m])) by (pod_name)
```
**I/O Usage**
```
sum (rate (container_fs_write_seconds_total{pod_name=~"pytorchjob-name-.*"}[1m])) by (pod_name)
```
**Keep-Alive check**  
```
up
```
This is maintained by Prometheus on its own with its `up` metric detailed in the documentation [here](https://prometheus.io/docs/concepts/jobs_instances/#automatically-generated-labels-and-time-series).
**Is Leader check**
```
pytorch_operator_is_leader
```
*Note*: Replace `pytorchjob-name` with your own PyTorch Job name you want to monitor for the example queries above.


## Ref
- [How to calculate containers' cpu usage in kubernetes with prometheus as monitoring?](https://stackoverflow.com/questions/40327062/how-to-calculate-containers-cpu-usage-in-kubernetes-with-prometheus-as-monitori)

###### tags: `Note` `Grafana`
