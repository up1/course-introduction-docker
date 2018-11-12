# Create docker image with Dockerfile

1. Create Dockerfile to define layers of image

Dockerfile
```
FROM nginx:1.15.6
COPY ./web/index.html /usr/share/nginx/html/index.html
```

2. Create image from Dockerfile
```
$docker image build -t web:0.1 .
$docker image build -t web:0.1 -f Dockerfile .
Sending build context to Docker daemon  4.608kB
Step 1/2 : FROM nginx:1.15.6
 ---> 62f816a209e6
Step 2/2 : COPY ./web/index.html /usr/share/nginx/html/index.html
 ---> 39a9f38fb024
Successfully built 39a9f38fb024
Successfully tagged web:0.1


$docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
web                 0.1                 39a9f38fb024        30 seconds ago      109MB
```

3. Create container from new image
```
$docker container run -d --name demo01 -h demo01 -p 8080:80 web:0.1
```

4. Access container from browser
```
$curl http://localhost:8080
```

5. Delete container
Delete container
```
$docker container stop demo01
$docker container rm demo01
```