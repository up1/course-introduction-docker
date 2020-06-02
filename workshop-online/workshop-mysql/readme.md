# Workshop of MySQL database

## Create container with Environment variables
```
docker image pull mysql:8.0.20
docker image ls
docker container run -d --name db \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=crm \
  -e MYSQL_USER="crm_user" \
  -e MYSQL_PASSWORD="crm_pass" \
mysql:8.0.20

docker container ps

docker container exec -it db bash
#mysql -ucrm_user -pcrm_pass
>show databases;
>use mysql;
>show tables;
>describe user;
>select * from user;
```

## Solution 1 :: Using [Docker command](https://docs.docker.com/engine/reference/commandline/run/)
* Using env-file
* Using mount files/folder
```
docker container run -d --name db \
  -v $(pwd)/mysql/initial/:/docker-entrypoint-initdb.d/ \
  --env-file config.db.env \
  mysql:8.0.20


docker container ps
docker container exec -it db bash
#mysql -ucrm_user -pcrm_pass
>show databases;
>use crm;
>show tables;
>describe users;
>select * from users;
```

Delete all containers
```
docker container stop db
docker container prune
```

## Solution 2 :: Using Dockerfile

Build Image from Dockerfile
```
cd mysql
docker image build -t db:1.0 .

```

Create and Run containers and read environments from file
```
cd ..
docker container run -d --name db --env-file config.db.env db:1.0
docker container ps
docker container exec -it db bash
#mysql -ucrm_user -pcrm_pass
>show databases;
>use crm;
>show tables;
>describe users;
>select * from users;
```

Delete all containers
```
docker container stop db
docker container prune
```

