# Creating and Using Docker Storage

## Volume 

* Use -v  :: -v /host-volume:/path-in-container:[ro/rw]
* Use --mount  :: --mount type=bind,source=/host-volume,target=/path-in-container,(readonly)

Working with Local volume
```
docker volume create my-vol
docker volume ls
docker volume inspect my-vol
docker volume rm my-vol

docker volume prune
```

Create new container with local volume
```
docker volume create my-vol2
docker run -d --name demo01 -v myvol2:/app nginx:alpine
docker run -d --name demo02 --mount source=myvol2,target=/app nginx:alpine

docker container stop demo01
docker container stop demo02
docker container rm demo01
docker container rm demo02
docker volume rm myvol2
```

Share volume across docker container
```
docker volume create my-vol3
docker container run -d --name demo01 -v myvol3:/app nginx:alpine
docker container exec -it demo01 sh
#cd /app
#echo "test" > test.txt

# Create new container and use volume from container=demo01 
docker container run -d --name demo02 --volumes-from demo01 nginx:alpine
docker container exec -it demo02 sh
#ls /app
```

Share data between machines (Volume driver)
* Backup and restore data from container
```
# Install volumee driver
docker plugin install --grant-all-permissions vieux/sshfs

# Creat volume
docker volume create --driver vieux/sshfs \
  -o sshcmd=<ssh user>@<ssh ip/name>:/home/test \
  -o password=<ssh password> \
  sshvolume

# Create container
docker run -d \
  --name sshfs-container \
  --volume-driver vieux/sshfs \
  --mount src=sshvolume,target=/app,volume-opt=sshcmd=<ssh user>@<ssh ip/name>:/home/test,volume-opt=password=<ssh password> \
  nginx:latest

```

## Bind mounts
```
docker run -d -it --name demo01 -v "$(pwd)"/target:/app nginx
docker run -d -it --name demo02 --mount type=bind,source="$(pwd)"/target,target=/app nginx

docker container stop demo01
docker container stop demo02
docker container rm demo01
docker container rm demo02
```


## tmpfs mounts
```
docker run -d -it --name demo01 --mount type=tmpfs,destination=/app,tmpfs-mode=1770 nginx

```

## Workshop :: Manage data in Docker container

```
```