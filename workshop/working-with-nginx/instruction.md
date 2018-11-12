# Working with nginx

## Create and access to container
```
$docker container run -d --name demo01 -h demo01 nginx:1.15.6
$docker container exec -it demo01 bash
$docker container stop demo01
$docker container rm demo01
```

Create container with publish port (with -p)
```
$docker container run -d --name demo01 -h demo01 -p 8080:80 nginx:1.15.6
$docker container run -d --name demo01 -h demo01 -p 8081:80 nginx:1.15.6
$docker container run -d --name demo01 -h demo01 -p 8082:80 nginx:1.15.6
```

Access container from browser
```
$curl http://localhost:8080
$curl http://localhost:8081
$curl http://localhost:8082
```

Create container with publish port (with -P)
```
$docker container run -d --name demo01 -h demo01 -P nginx:1.15.6

$docker container ps

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                   NAMES
a4e862504c75        nginx:1.15.6        "nginx -g 'daemon of…"   3 seconds ago       Up 2 seconds        0.0.0.0:32768->80/tcp   demo01
```

## Change code in container

Access to container and change data in file /usr/share/nginx/html/index.html
```
$docker container run -d --name demo01 -h demo01 -p 8080:80 nginx:1.15.6
$docker container exec -it demo01 bash
root@demo01:/# echo "TRY" > /usr/share/nginx/html/index.html
root@demo01:/# cat /usr/share/nginx/html/index.html

```

Access container from browser
```
$curl http://localhost:8080
```

Delete container
```
$docker container stop demo01
$docker container rm demo01
```

## Mapping volume from host and container
Create file on host machine
```
$mkdir web
$cd web
$echo "From HOST" > index.html
$cd ..
```

Create container with mapping volume
```
$docker container run -d --name demo01 -h demo01 \
  -v $(pwd)/web:/usr/share/nginx/html/ \
  -p 8080:80 nginx:1.15.6
```

Access container from browser
```
$curl http://localhost:8080
```

Access to container and change data in file
```
$docker container exec -it demo01 bash
root@demo01:/# cat /usr/share/nginx/html/index.html

root@demo01:/# echo "From Container" > /usr/share/nginx/html/index.html
root@demo01:/# cat /usr/share/nginx/html/index.html
```

