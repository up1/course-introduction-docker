# Introduction to [Docker compose](https://docs.docker.com/compose/)

* เป็นเครื่องมือสร้าง service ที่ประกอบไปด้วยหลาย ๆ Application เป็น Application stack ที่ประกอบด้วยหลาย Component เช่น
    * Application
    * Database
    * Web reverse proxy / Load balance
* สามารถควบคุม service start/stop ได้จากจุดเดียว
* สามารถทำ development environment, automatic deploy to production ได้ง่ายขึ้น

## การใช้งานมีขั้นตอนดังนี้
* สร้าง Dockerfile สำหรับ build image ของแต่ละ component
* กำหนดค่าต่าง ๆ ในไฟล์ docker-compose.yml
* docker-compose build/up/down

