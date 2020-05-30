# Creating Docker image

## Create Docker image from running docker container

```
docker image commit <container-name> <image-name>:<tag>
```

Working with NGINX
```
docker container run -d --name demo01 nginx:latest
docker container exec -it demo01 bash
#curl localhost
#apt update
#apt install curl -y
#curl localhost

docker container commit demo01 demo01-image:0.1
docker image ls

# Create new container from new image
docker container run -d --name demo02 demo01-image:0.1
docker container exec -it demo02 bash
#curl localhost

docker container stop demo01
docker container stop demo02
docker container prune
```

## Working with Dockerfile 
* **FROM** <image>:<tag> เป็นการระบุ image ตั้งต้นที่จะใช้งาน
* **RUN** <shell command> คือคำสั่งที่รันขณะ build
* **CMD** ["executable","param1","param2"] เป็นสำสั่งเริ่มต้นเมื่อ image ที่ถูกสร้างขึ้ถูกสั่งให้ run เป็น container หรือเป็น parameter ที่ส่งต่อให้ ENTRYPOINT
* **EXPOSE** <port> [<port>/<protocol>...] เป็นการระบุมาเมื่อ image ที่ถูกสร้างนี้ run เป็น container แล้วจะเปิด port ไหนสำหรับใช้งาน
* **ARG** <name>[=<default value>] เป็นการกำหนดค่าตัวแปรในขณะ build image
* **ENV** <key>=<value> เป็นการกำหนดค่าตัวแปร environment เพื่อใช้งานขณธ build
* **COPY/ADD** <source> <destination> เป็นการสั่ง copy file หรือ directory จาก docker machine host เข้าไปไว้ใน image หรือ download file มาถ้าใช้คำสั่ง ADD แต่ไม่แนะนำให้ใช้ ใช้ COPY ดีกว่า
* **ENTRYPOINT** ["executable", "param1", "param2"] เป็นคำสั่งที่จะทำงานเมื่อ image ถูก run เป็น container
* **WORKDIR** /path/to/workdir เป็นการระบุ directory เริ่มต้นในการทำงาน RUN, CMD, ENTRYPOINT, COPY ถ้า path ของ WORKDIR ไม่มีอยู่ก่อนจะถูกสร้างขึ้นเอง

## [Best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* ทำให้เรียบง่าย ไม่ซับซ้อน
* 1 service 1 container
* เลือก image เริ่มต้นจากเจ้าของ image ที่เป็นทางการ
* build image ให้มีขนาดเล็กที่สุด
* directory ที่ใช้ build ให้แยกกันใช้เฉพาะงาน
* ใช้เฉพาะ file ที่จำเป็น
* ติดตั้ง component/library เท่าที่จำเป็นต้องใช้
* RUN ควรรวบทุกคำสั่งที่ติดตั้ง software มาทำครั้งเดียว
* ลบ temp file ที่เกิดจากการติดตั้ง software
* จัดเรียงคำสั่งให้อ่านง่าย ใช้ \ ในการขึ้นบรรทัดใหม่เพื่อให้ยังเป็นชุดคำสั่งเดิม
* ระบุ EXPOSE port ทุกครั้ง
* ระบุ WORKDIR ทุกครั้งก่อน RUN, ENTRYPOINT, CMD, COPY
* https://www.fromlatest.io/ เครื่องมือตรวจสอบ Dockerfile

## Workshop
```

```
