## System command tools

## Linux processes

```bash
ss -ltp | grep 3000
netstat -lptn |grep LISTEN
```

## Backend modules

Lists containers (all modules running)

```bash
$ docker ps
$ docker ps | awk '{print $2}'
$ docker images
```

What happens in docker containers

```bash
$ docker ps|grep login
903d45c995a6        folioorg/mod-login:5.1.0                 "./run-java.sh ver..."   2 hours ago         Up 2 hours          8778/tcp, 9779/tcp, 0.0.0.0:9143->8081/tcp   wizardly_leakey
6677a5c55415        folioorg/mod-login-saml:1.2.1            "./run-java.sh"          2 hours ago         Up 2 hours          8778/tcp, 9779/tcp, 0.0.0.0:9142->8081/tcp   eloquent_mclean
vagrant@vagrant:~$ docker logs --tail 100 903d45c995a6
```

Go inside a container

```bash
$ docker exec -it 903d45c995a6 bash
```

Usefull general info: 

```bash
docker system info
```



