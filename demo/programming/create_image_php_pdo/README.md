# Step to create new image

1. Build image from Dockerfile
```
$docker image build -t customphp:0.1 .
```

2. Create new container
```
$docker container run -d --name myphp \
-v $(pwd)/web:/web \
--link mydb:mydb \
customphp:0.1
```
