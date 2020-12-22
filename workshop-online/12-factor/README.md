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

Edit file `api/app.py`

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

```

## 4. Backing services

Application must make no distinction between a service running locally or as a third-party. (without any code changes)

## 5. Build, release, run

## 6. Processes

## 7. Port binding

## 8. Concurrency

## 9. Disposability

## 10. Dev/prod parity

## 11. Logs

## 12. Admin processes
