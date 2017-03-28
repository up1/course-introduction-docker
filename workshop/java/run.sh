docker run --rm \
-v "$(pwd)":/app \
-w /app \
openjdk:8u121-jdk-alpine sh -c 'javac HelloWorld.java'

docker run --rm \
-v "$(pwd)":/app \
-w /app \
openjdk:8u121-jdk-alpine sh -c 'java HelloWorld'
