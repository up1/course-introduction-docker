# Workshop Build Image 

## Build image of Node.JS

```
cd nodejs
docker image build -t demo-node:1.0 .
docker image ls


docker container run --rm -p 3000:3000 demo-node:1.0
```

## Build image of NGINX

```
cd nginx
docker image build -t demo-nginx:1.0 .
docker image ls
```

## Run containers
```
# Create network
docker network create web_workshop
docker network ls

# Create nodejs container
docker container run -d --name mynodejs --net web_workshop demo-node:1.0

# Create NGINX container
docker container run -d --name nginx --net web_workshop -p 8080:8080 demo-nginx:1.0


docker container stop mynodejs
docker container stop nginx
docker container prune

docker network rm web_workshop
```

## Working with Docker compose
```
TODO
```