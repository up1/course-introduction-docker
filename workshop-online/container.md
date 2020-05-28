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
docker container run --publish 80:80 nginx
docker container run --publish 80:80 --detach nginx
docker container ls
docker container stop 690
docker container ls
docker container ls -a

docker container run --publish 80:80 --detach --name webhost nginx
docker container ls -a
docker container logs webhost
docker container top
docker container top webhost

docker container --help
docker container ls -a
docker container rm 63f 690 ode
docker container ls
docker container rm -f 63f
docker container ls -a
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
docker container run -d -p 3306:3306 --name db -e MYSQL_RANDOM_ROOT_PASSWORD=yes MYSQL_RANDOM_ROOT_PASSWORD
docker container logs db
docker container run -d --name webserver -p 8080:80 httpd
docker ps

docker container run -d --name proxy -p 80:80 nginx
docker container ps

docker container ls
docker container stop TAB COMPLETION

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

## Docker Networks: Private and Public communication in Containers

```
docker container run -p 80:80 --name webhost -d nginx
docker container port webhost
docker container inspect --format '{{ .NetworkSettings.IPAddress }}' webhost
```

## Docker Networks: CLI Management of Virtual Networks

```
docker network ls
docker network inspect bridge
docker network ls
docker network create my_app_net
docker network ls

docker network create --help
docker container run -d --name new_nginx --network my_app_net nginx

docker network inspect my_app_net
docker network --help
docker network connect
docker container inspect TAB COMPLETION
docker container disconnect TAB COMPLETION
docker container inspect
```