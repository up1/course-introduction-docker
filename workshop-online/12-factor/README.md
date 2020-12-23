# [12 factor](https://12factor.net/) with Python app

- Python 3 + Flask
- MySQL

## 1. Codebase

one application <=> one codebase

If there are several codebase, it's not an application, it's a distributed system containing multiple applications.

One codebase used for several deployments of the application

- development
- staging
- production

## 2. Dependencies

Application's dependencies must be declared and isolated

Declaration are done in `requirements.txt` file.

```
$pip install -r requirements.txt
```

#### Working with Docker compose

file `api/Dockerfile`

```
FROM python:3.10.0a3-alpine3.12
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
CMD [ "python", "app.py" ]
```

file `docker-compose.yml`

```
version: "3.9"
services:
  api:
    build: ./api
    image: api:0.1
    ports:
      - 5000:5000
```

Step to run

```
$docker-compose build
$docker-compose up -d
$docker-compose ps
     Name                   Command             State           Ports
------------------------------------------------------------------------------
12-factor_api_1   python app.py                 Up      0.0.0.0:5000->5000/tcp
12-factor_db_1    docker-entrypoint.sh mysqld   Up      3306/tcp, 33060/tc

```

Access api with url=`http://localhost:5000/users`

## 3. Config

Configuration (credentials, database connection string, ...) should be stored in the environment.

Use file `api/app-config.py`

```
import os

DATABASE_CREDENTIALS = {
   'host': os.environ['DATABASE_HOST'],
   'user': os.environ['DATABASE_USER'],
   'password': os.environ['DATABASE_PASSWORD'],
   'database': os.environ['DATABASE_NAME']
}

con = db.connect(**DATABASE_CREDENTIALS)
```

Run application

```
// For Windows OS
$set DATABASE_HOST=

// For Linux OS
$export DATABASE_HOST=

python app.py
```

Run application with Docker command

```
$docker container run \
  -e DATABASE_HOST=XXX
  -e DATABASE_USER=user
```

Run application with Docker compose

```
$docker-compose build
$docker-compose up -d
```

## 4. Backing services

Application must make no distinction between a service running locally or as a third-party library. (without any code changes)

Example : change mysql to postgresql or to Cloud database

```
$export DATABASE_URL=mysql://testdb:t123@localhost/testdb

to

$export DATABASE_URL=postgresql://testdb:t123@localhost/testdb
```

## 5. Build, release, run

Build / Release and Run phases must be kept separated

#### Working with docker command

Building Docker image from Dockerfile

```
$docker image build -t demo:0.1 .
$docker container run -d demo:0.1
```

#### Working with docker compose

```
$docker-compose build
$docker-compose up -d
```

## 6. Processes

Application is executed as one or more stateless processes which share nothing and are horizontally partitionable.

Each process must be stateless and must not have local storage (sessions, ...).

This is required

- for scalability
- fault tolerance (crashes, ...)

The data that need to be persisted, must be saved in a stateful resources (Database, shared filesystem, ...)

Example :: keep session data into in-memory database such as [Redis](https://redis.io/)

## 7. Port binding

Application must be self-contained and bind to a port specified as an environment variable.

It can’t rely on the injection of a web container such as tomcat or unicorn; instead it must embed a server such as jetty or thin.

For example

```
port = int(os.environ.get("PORT", 5000))
app.run(host='0.0.0.0', port=port)
```

## 8. Concurrency

Horizontal scalability with the processes model.

The app can be seen as a set of processes of different types

- web server
- worker
- cron

Each process needs to be able to scale horizontally, it can have its own internal multiplexing.

## 9. Disposability

Each process of an application must be disposable.

- it must have a quick startup
  - ease the horizontal scalability
- it must ensure a clean shutdown
  - stop listening on the port
  - finish to handle the current request
  - usage of a queueing system for long lasting (worker type) process

Application’s processes can be started or stopped (with a SIGTERM) anytime. Thus, minimizing startup time and gracefully shutting down is very important.

Example for delay with timeout

```
import signal
signal.signal(signal.SIGTERM, lambda *args: server.stop(timeout=60))
```

## 10. Dev/prod parity

A 12-factor app is designed to keep the gap between development and production small.

## 11. Logs with [Docker](https://docs.docker.com/config/containers/logging/)

Consider logs as a stream of time-ordered events collected from all running processes and backing services.

it just writes its output to its `stdout` or `stderr` stream.

The execution environment is responsible for collecting, collating, and routing this output to its final destination(s).

A lot of services offer a centralized log management ([Elastic Stack / ELK](https://www.elastic.co/products) , [Splunk](http://splunk.com), [Logentries](https://logentries.com), ...), and most of them are very easily integrated with Docker.

#### Example :: [Docker with Fluentd](https://docs.fluentd.org/container-deployment/docker-logging-driver)

Step 1 :: Config fluentd in file `demo.conf`

```
<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<match *>
  @type stdout
</match>
```

Start Fluentd

```
$docker container run -it -p 24224:24224 \
  -v $(pwd)/fluentd/demo.conf:/fluentd/etc/demo.conf \
  -e FLUENTD_CONF=demo.conf fluent/fluentd:latest
```

Step 2 :: Start Docker Container with Fluentd Driver

```
$docker container run --log-driver=fluentd --log-opt tag="docker.{.ID}}" ubuntu echo 'Hello Fluentd!'
```

#### [Working with Docker compose (Fluentd + ELK stack)](https://docs.fluentd.org/container-deployment/docker-compose)

File `docker-compose-logging.yml`

```
version: '3'
services:
  web:
    image: httpd
    ports:
      - "80:80"
    logging:
      driver: "fluentd"
      options:
        fluentd-address: localhost:24224
        tag: httpd.access

  fluentd:
    build: ./fluentd
    volumes:
      - ./fluentd/fluentd.conf:/fluentd/etc/fluentd.conf
    ports:
      - "24224:24224"
      - "24224:24224/udp"

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    environment:
      - "discovery.type=single-node"
    ports:
      - "9200:9200"

  kibana:
    image: docker.elastic.co/kibana/kibana:7.10.0
    ports:
      - "5601:5601"
```

Step to run

```
$docker-compose -f docker-compose-logging.yml build
$docker-compose -f docker-compose-logging.yml up -d elasticsearch
$docker-compose -f docker-compose-logging.yml up -d kibana
$docker-compose -f docker-compose-logging.yml up -d fluentd
$docker-compose -f docker-compose-logging.yml up -d web
$docker-compose -f docker-compose-logging.yml ps

$docker-compose -f docker-compose-logging.yml logs --follow

```

Access to url=`localhost` and see result in Kibana `localhost:5601`

or

Access to url=`http://localhost:9200/_cat/indices`

```
yellow open fluentd-20201223                fjiJZuuTT6myqAtenc7V2w 1 1 10  0  30.7kb  30.7kb
```

And url=`http://localhost:9200/fluentd*/_search`

## 12. Admin processes

Admin process should be seen as a one-off process (opposed to long running processes that make up an application).

Usually used for maintenance task, though a REPL, admin process must be executed on the same release (codebase + configuration) than the application.

Example

```
$docker container run -i -t --entrypoint python demo:0.1 /src/some-task.py
```
