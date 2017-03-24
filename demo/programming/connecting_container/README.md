# Step to create all containers with docker command

# 1. Create mysql container
```

```

# 2. Create php container
```
$docker container run -d --name myphp \
-v $(pwd)/web:/web \
php:fpm
```

# 3. Create Webserver with Nginx container (link to php)
```
$docker container run --rm -d --name myweb \
-p 80:80 \
-v $(pwd)/site.conf:/etc/nginx/conf.d/default.conf \
--volumes-from myphp \
--link myphp nginx:latest
```

# Step to create container with docker-compose

Build and Start
```
$docker-compose build
$docker-compose up -d
```

Step all containers
```
$docker-compose kill
```
