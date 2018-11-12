# Working with image and container

## Working with image

Pull image from Docker Hub
```
$docker image pull hello-world
```

List of all images
```
$docker images
$docker image ls
$docker image ls -q
```

Inspect image
```
$docker image inspect <id>|<name:tag>
```

Delete image
```
$docker image rm <id>|<name:tag>
$docker image rm $(docker image ls -q)
$docker image prune
```

Create new image/tag from orignal image
```
$docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
```

## Working with container

Create container from image (eg. [nginx](https://hub.docker.com/_/nginx/))
```
#Bad practice
$docker image pull nginx  
$docker image pull nginx:latest

#Better practice
$docker image pull nginx:1.15.6

# Create container with foreground mode
$docker container run nginx:1.15.6

# Create container with background mode
$docker container run -d nginx:1.15.6
$docker container run --detach nginx:1.15.6

# Create container with specified container name
$docker container run -d --name demo01 nginx:1.15.6
```

List of all containers
```
$docker container ps
$docker container ps -a
$docker container ps -q
$docker container ps -a -q
```

Inspect a container
```
$docker container inspect <id>/<name>
```

Access to container
```
$docker container run -d --name demo01 nginx:1.15.6
$docker container exec -it demo01 bash


# Better solution
$docker container run -d --name demo01 -h demo01 nginx:1.15.6
$docker container exec -it demo01 bash

```

Delete all containers
```
$docker container rm  <id>/<name>
$docker container rm $(docker container ps -a -q)
$docker container prune

# Better solution
$docker container stop $(docker container ps -a -q)
$docker container rm $(docker container ps -a -q)
$docker container prune
```

## Tips

Delete all images/containers/volumes/network in Docker Engine
```
$docker system prune -af
```