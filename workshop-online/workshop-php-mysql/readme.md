# Workshop of PHP with MySQL


## Solution 1 :: Using Docker command

Build Image
```
cd mysql
docker image build -t db:1.0 .

cd ..
cd php
docker image build -t web:1.0 .
```

Create and Run containers
```
cd ..
docker network create demo-php
docker container run -d --name db --network demo-php --env-file config.db.env db:1.0
docker container run -d --name web --network demo-php --env-file config.web.env -p 8080:80 web:1.0

curl localhost:8080
```

Delete all containers
```
docker container stop web
docker container stop db
docker container prune
docker network rm demo-php
```


## Soluttion 2 :: Using Docker compose
```
docker-compose build
docker-compose up -d
docker-compose ps
docker-compose logs --follow

curl localhost:8080

docker-compose down
```
