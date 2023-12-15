## Instructions working with [Fluentd driver](https://docs.docker.com/config/containers/logging/fluentd/)

### Step 1 :: Start Fluentd
```
$docker container run --rm --name fluentdserver -it -p 24224:24224 -v $(pwd)/docker.conf:/fluentd/etc/docker.conf -e FLUENTD_CONF=docker.conf fluentd
```

### Step 2 :: Start docker container with Fluentd driver
```
$docker container run --rm --log-driver=fluentd  --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}" alpine echo 'Hello Fluentd!'
```
