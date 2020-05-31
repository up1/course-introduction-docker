# Demo of [Multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/)

## Golang application
```
cd golang
docker image build -t go-web:1.0 .

docker container run -d --name demo -p 8080:8080 go-web:1.0
curl localhost:8080

docker container stop demo
docker container rm demo
```

## Angular 9 applicaction
```
```