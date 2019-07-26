# Scaling with Docker

Example web application with go programming

## Working with normal solution

1. Create image of Web app with Golang from Dockerfile
```
$cd code
$docker image build -t web:1.0 .
```

2. Create image of Load Balancer with Nginx from Dockerfile
```
$cd load-balancer
$docker image build -t load-balancer:1.0 .
```

3. Create container
```
// Web container
$docker container run -d --name web01 web:1.0
$docker container run -d --name web02 web:1.0
$docker container run -d --name web03 web:1.0

// Load Balancer
$docker container run -d -p 8000:80 --link web01 --link web02 --link web03 load-balancer:1.0
```

4. Open browser http://localhost:8000

## Working with Docker compose

```
$docker-compose build
$docker-compose up -d
$docker-compose down
```

Open browser http://localhost/


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
