# Introduction to [Docker compose](https://docs.docker.com/compose/)

* เป็นเครื่องมือสร้าง service ที่ประกอบไปด้วยหลาย ๆ Application เป็น Application stack ที่ประกอบด้วยหลาย Component เช่น
    * Application
    * Database
    * Web reverse proxy / Load balance
* สามารถควบคุม service start/stop ได้จากจุดเดียว
* สามารถทำ development environment, automatic deploy to production ได้ง่ายขึ้น
* สามารถทำการ deploy บน Docker swarm ได้

## การใช้งานมีขั้นตอนดังนี้
* สร้าง Dockerfile สำหรับ build image ของแต่ละ component
* กำหนดค่าต่าง ๆ ในไฟล์ docker-compose.yml
* docker-compose build/up/down

## Workshop
* Multiple services
  * API server with Node.JS
  * Database server with MySQL
    * Initial data in database

Build Docker image of Database with MySQL
```
cd 
docker-compose build
docker-compose up -d
docker-compose ps
docker-compose logs --follow

//start with custom compose file
docker-compose -f docker-compose-with-env.yml build
docker-compose -f docker-compose-with-env.yml up -d
docker-compose -f docker-compose-with-env.yml ps

//Access to db service
docker-compose exec db bash
#mysql -uexample-user -pexample-password
>show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| your_database      |
+--------------------+
2 rows in set (0.00 sec)

>use your_database;
Database changed

>show tables;
+-------------------------+
| Tables_in_your_database |
+-------------------------+
| users                   |
+-------------------------+
1 row in set (0.01 sec)

>select * from users;
+----+----------+
| id | username |
+----+----------+
|  1 | user1    |
|  2 | user2    |
|  3 | user3    |
|  4 | user4    |
|  5 | user5    |
|  6 | user6    |
|  7 | user7    |
+----+----------+
7 rows in set (0.00 sec)
```

Build Docker image of API with Node.jS
```

```