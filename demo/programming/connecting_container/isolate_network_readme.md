Isolation network

1. Create network
Front network
```
$docker network create front_network
```

Back network
```
$docker network create back_network
```

2. Create mysql container in back_network
```
$docker container run -d --name mydb \
--network back_network \
-e MYSQL_ROOT_PASSWORD=123456 \
-e MYSQL_DATABASE=demo \
mysql:latest
```

3. Create php container in front_network and back_network
```
$docker container run -d --name myphp \
--network back_network \
-v $(pwd)/web:/web \
--link mydb:mydb \
somkiat/customphp

$docker network connect front_network myphp
```

4. Create nginx container in front_network
```
$docker container run --rm -d --name myweb \
--network front_network \
-p 80:80 \
-v $(pwd)/site.conf:/etc/nginx/conf.d/default.conf \
--volumes-from myphp \
--link myphp nginx:latest
```
