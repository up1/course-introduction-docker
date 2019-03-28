# Docker Volumes
* Create and mount data volumes
* Sharing data between containers
* Use host volumes
* Define volumes in images

## Create and mount data volumes

Create volume
```
$docker volume create my-data
$docker volume inspect my-data
```

Mounting volume with container
```
$docker container run --name test -it -v my-data:/data alpine sh
test# cd /data
test# echo "Some data" > data.txt
test# echo "Some more data" > data2.txt
test# exit
```

Delete and create new container with existing volume
```
$docker container rm test
$docker container run --name test2 -it -v my-data:/app/data alpine sh
test2# cd /app/data
test2# ls -l
test2# exit
```

Remove volume !!
```
$docker volume rm my-data
$docker container rm test2
```

## Sharing data between containers

Writer container
```
$docker container run -it --name writer -v shared-data:/data alpine sh
writer# echo "Create new file" > /data/sample.txt
```

Reader container with Read-only volume
```
$docker container run -it --name reader -v shared-data:/app/data:ro alpine sh
reader# ls -l /app/data
```

Remove volume !!
```
$docker volume rm $(docker volume ls -q) 
$docker container rm writer
$docker container rm reader
```

## Use host volumes
```
$docker container run --rm --name test -it -v $(pwd)/src:/app/src alpine:latest sh
test# cd /app/src
test# echo "Create new file" > /app/data/sample.txt
test# exit

$ls -la ./src
$docker container rm test
```

## Define volumes in images
Pull image of MongoDB
```
$docker image pull mongo:3.7 
$docker image inspect --format='{{json .ContainerConfig.Volumes}}' mongo:3.7
```

Create container
```
$docker container run -d --name my-mongo -d mongo:3.7
$docker container inspect --format '{{json .Mounts}}' my-mongo
$docker volume ls
```

Remove volume !!
```
$docker volume rm $(docker volume ls -q) 
$docker container rm my-mongo
```