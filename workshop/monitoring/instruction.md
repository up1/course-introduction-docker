# Monitoring

## 1. Monitoring docker with CLI

### Docker CLI
```
$docker container ps
$docker container stats
$docker container stats <id/name>
$docker container stats --format "{{.Container}}: {{.CPUPerc}}"
$docker container stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
$docker container stats --no-stream
```

### Docker remote API
```
$curl --unix-socket /var/run/docker.sock http://localhost/containers/<name>/stats
```

### Events
```
$docker system events
```

## 2. Monitoring docker with Prometheus
https://docs.docker.com/config/thirdparty/prometheus/#configure-docker

<b>Configuration</b>
* Linux: /etc/docker/daemon.json
* Windows Server: C:\ProgramData\docker\config\daemon.json
* Docker for Mac / Docker for Windows: Click the Docker icon in the toolbar, select Preferences, then select Daemon. Click Advanced.

<b>Default metrics</b>

1. Update deamon setting
```
{
  "metrics-addr" : "0.0.0.0:1337",
  "experimental" : true
}
```

2. Restart Docker
3. Show the list of metrics at http://localhost:1337/metrics

<b>Create Prometheus container to keep all data from docker</b>

1. Create folder prometheus
2. Create file prometheus.yml in folder prometheus
```
scrape_configs:
  - job_name: 'docker'
    scrape_interval: 5s
    static_configs:
      - targets: ['<ip>:1337']
```
3. Create prometheus container
```
$docker run \
  -d \
  --name metrics \
  -p 9090:9090 \
  -v $(pwd)/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus
```

4. Show the dashboard at http://localhost:9090
5. Show the list of metrics

## 3. Monitoring docker with cAdvisor
1. Create cAdvisor container
```
$docker run \
  -d \
  --name=cadvisor \
  -p 8080:8080 \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  google/cadvisor:latest
```

2. Show the dashboard at 
* http://localhost:8080
* http://localhost:8080/docker