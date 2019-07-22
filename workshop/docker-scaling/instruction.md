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


## More :: scaling by service
Update file nginx.conf
```
events { worker_connections 1024; }
http {

 upstream localhost {
    server backend:8080;
 }
 server {
    listen 80;
    server_name localhost;
    location / {
       proxy_pass http://localhost;
       proxy_set_header Host $host;
    }
  }
}
```

Start with docker-compose

```
$docker-compose -f docker-compose-scale.yml up --scale backend=5 -d
```
