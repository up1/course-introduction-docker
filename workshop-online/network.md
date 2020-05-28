# Creating and Using Network

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

# Create new Virtual network
docker network create my_app_net
docker network ls

# Assign Virtual network to container
docker network create --help
docker container run -d --name new_nginx --network my_app_net nginx

# Network information
docker network inspect my_app_net
docker network --help
docker network connect

docker container inspect TAB COMPLETION
docker container disconnect TAB COMPLETION
docker container inspect
```

## Docker Networks: DNS and How Containers Find Each Other

```
docker container ls
docker network ls
docker network inspect <id/name>

docker container run -d --name my_nginx --network my_app_net nginx
docker container inspect my_nginx

docker container exec -it my_nginx ping new_nginx
docker container exec -it new_nginx ping my_nginx
docker network ls

```

## Assignment : Using Containers for CLI Testing

```
docker container run --rm -it centos:7 bash
docker ps -a
docker container run --rm -it ubuntu:14.04 bash
docker ps -a
```

## Assignment : DNS Round Robin Testing

```
docker network create dude
docker container run -d --net dude --net-alias search elasticsearch:2
docker container ls

docker container run --rm -- net dude alpine nslookup search
docker container run --rm --net dude centos curl -s search:9200
docker container ls

docker container rm -f TAB COMPLETION
```