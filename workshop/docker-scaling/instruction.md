# Scaling with Docker

Example web application with go programming

1. Create image from Dockerfile
```
$docker image build -t mygo:1.0 .
```

2. Create container
```
$docker container run -d -p 8080:8080 mygo:1.0
```

3. Create file docker-compose.yml

4. Build and run
```
$docker-compose build
$docker-compose up -d
$docker-compose down
```

5. Open browser http://localhost/
