FROM ubuntu
RUN apt-get update
RUN apt-get install -y wget 
ENTRYPOINT ["wget", "-O-", "-q"]
CMD http://ifconfig.me/ip
