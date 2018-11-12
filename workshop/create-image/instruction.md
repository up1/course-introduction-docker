# Create docker image
* From container
* From Dockerfile

## Create new image from container

Create container and modify data in file
```
$docker container run -d --name demo01 -h demo01 -p 8080:80 nginx:1.15.6
$docker container exec -it demo01 bash
root@demo01:/# echo "TRY" > /usr/share/nginx/html/index.html
root@demo01:/# cat /usr/share/nginx/html/index.html
root@demo01:/# exit
```

Create new image from container
```
$docker container commit demo01 new_image:0.1

$docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
new_image           0.1                 4e8ef0275b97        5 seconds ago       109MB
```

Create container from new image
```
$docker container run -d --name demo02 -h demo02 -p 8081:80 new_image:0.1
```

## Push image to Docker Hub

1. Register new account at [Docker Hub](https://hub.docker.com/)

2. Login
```
$docker login

Authenticating with existing credentials...
Login Succeeded
```

3. Try to push image
```
$docker image push new_image:0.1

The push refers to repository [docker.io/library/new_image]
3501cec8e778: Preparing
ad9ac0e6043b: Preparing
6ccbee34dd10: Preparing
237472299760: Preparing
denied: requested access to the resource is denied
```

4. Must tag new image
```
$docker image tag new_image:0.1  <username>/new_image:0.1
docker image push <username>/new_image:0.1
```

5. See your image in Docker Hub
