# [12 factor](https://12factor.net/) with Python app
* Python 3 + Flask
* MySQL

## 1. Codebase
one application <=> one codebase

If there are several codebase, it's not an application, it's a distributed system containing multiple applications.

One codebase used for several deployments of the application
* development
* staging
* production

## 2. Dependencies
Application's dependencies must be declared and isolated

Declaration are done in `requirements.txt` file.
```
$pip install -r requirements.txt
```

## 3. Config
Configuration (credentials, database connection string, ...) should be stored in the environment.


## 4. Backing services

## 5. Build, release, run

## 6. Processes

## 7. Port binding

## 8. Concurrency

## 9. Disposability

## 10. Dev/prod parity

## 11. Logs

## 12. Admin processes
