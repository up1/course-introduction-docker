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
docker container run -d --name new_nginx --network my_app_net nginx:alpine

# Network information
docker network inspect my_app_net
docker network --help
docker network connect

docker container inspect TAB COMPLETION
docker container disconnect TAB COMPLETION
docker container inspect
```

## Docker Networks: DNS and How Containers Find Each Other

Delete all containers and networks !!
```
docker container ls
docker network ls
docker network inspect <id/name>

docker network create my_app_net

docker container run -d --name web_01 --network my_app_net nginx:alpine
docker container run -d --name web_02 --network my_app_net nginx:alpine
docker container inspect web_01
docker container inspect web_02

docker container exec -it web_01 ping web_02
docker container exec -it web_02 ping web_01
docker network ls
```

## Assignment : Using Containers for CLI Testing

```
docker container run --rm -it centos:7 bash
docker container ps -a
docker container run --rm -it ubuntu:14.04 bash
docker container ps -a
```

## Assignment : DNS Round Robin Testing

```
docker network create dude
docker container run -d --net dude --net-alias search nginx:alpine
docker container run -d --net dude --net-alias search nginx:alpine
docker container run -d --net dude --net-alias search nginx:alpine
docker container ls
docker container inspect <id/name   >

docker container run --rm --net dude alpine nslookup search
docker container run --rm --net dude centos curl -v search:80
docker container ls

docker container rm -f <id/name>
```

## Assignment :: Reeverse proxy

```
# Create network
docker network create internal

# Create web
docker run -d --net internal --net-alias web --name web1 somkiat/hello
docker run -d --net internal --net-alias web --name web2 somkiat/hello
docker run -d --net internal --net-alias web --name web3 somkiat/hello  

docker container run --rm --net internal alpine nslookup web

# Create reverse proxy (expose port 80:80)
docker run -d --net internal --net-alias reverse-proxy -p 80:80 --name reverse-proxy-01  somkiat/reverse-proxy

# curl localhost:80

```