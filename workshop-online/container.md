# Creating and Using Containers

## Check Our Docker Install and Config
```
docker version
docker info
docker
docker container run
docker run
```

## Starting a Nginx Web Server
```
docker container run --publish 8888:80 nginx
docker container run --publish 8888:80 --detach nginx
docker container ls
docker container stop 690
docker container ls
docker container ls -a

docker container run --publish 8888:80 --detach --name webhost nginx
docker container ls -a
docker container logs webhost
docker container top
docker container top webhost

// Access to container
docker container exec -it webhost bash

docker container --help
docker container ls -a
docker container rm 63f 690 ode
docker container ls
docker container rm -f 63f
docker container ls -a
```

Save container to image
```
docker container commit webhost demo:1.0
```


## Container VS. VM

```
docker container run --name mongo -d mongo
docker container ps
docker container top mongo
docker container stop mongo
docker containerps

docker container top mongo
docker container start mongo
docker container ps
docker container top mongo
```

## Assignment : Manage Multiple Containers

```
# Databasae server
docker container run -d -p 3306:3306 --name db -e MYSQL_RANDOM_ROOT_PASSWORD=yes MYSQL_RANDOM_ROOT_PASSWORD
docker container logs db

# Web server with Apache Web Server
docker container run -d --name webserver -p 8080:80 httpd
docker container ps

# Web server with NGINX
docker container run -d --name proxy -p 80:80 nginx:alpine
docker container ps

docker container ls
docker container stop <id/name>

docker container ps -a
docker container ls -a
docker container rm
docker container ps -a

docker image ls
```

## CLI Process Monitoring

```
docker container run -d --name nginx nginx
docker container run -d --name mysql -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql
docker container ls

docker container top mysql
docker container top nginx

docker container inspect mysql

docker container stats --help
docker container stats

docker container ls
```

## Access to Container

```
docker container run -help
docker container run -it --name proxy nginx bash

docker container ls
docker container ls -a

docker container run -it --name ubuntu ubuntu

docker container ls
docker container ls -a

docker container start --help
docker container start -ai ubuntu

docker container exec --help
docker container exec -it mysql bash

docker container ls

docker image pull alpine
docker image ls
docker container run -it alpine bash
docker container run -it alpine sh
```
