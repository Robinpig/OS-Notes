## Tutorial


```dockerfile
FROM ubuntu:18.04

RUN \
sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
&& sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
&& apt clean \
&& apt-get update -y


RUN mkdir /workspace
WORKDIR /workspace

COPY ./gcc-3.4.tar.gz .
COPY ./hit-oslab-linux-20110823.tar.gz .

RUN tar -zxf gcc-3.4.tar.gz
RUN tar -zxf hit-oslab-linux-20110823.tar.gz

RUN apt-get install -y binutils \
&& cd ./gcc-3.4/amd64/ \
&& dpkg -i *.deb
RUN apt-cache search as86 ld86 \
&& apt install bin86 \
&& apt install -y libc6-dev-i386 \
&& apt-get install make \
&& cd /workspace/oslab/linux-0.11 \
&& make all \
&& dpkg --add-architecture i386 \
&& apt-get update \
&& apt-get install -y libsm6:i386 \
&& apt-get install -y libx11-6:i386 \
&& apt-get install libxpm4:i386
```


先在目录下 build image

```shell

docker build --platform linux/amd64 --progress=plain -t hit-oslab:v2 .
```
也可以直接pull现有镜像

```shell
docker pull vitoclone/hit-oslab:v2
```


```shell
docker run -itd --privileged -v /tmp/.X11-unix:/tmp/.X11-unix --name oslab2 hit-oslab:v2
```

安装socat 和 xquartz

```shell
brew install socat xquartz
```
先设置 xquartz 的 security 支持客户端通过网络连接


新tab开启 socat
```shell
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```


查看ip

```shell
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*'
```

attach

 ```shell

 docker exec -it -e DISPLAY=192.168.0.109:0 oslab2 /bin/bash

 ```

 进入容器后 启动命令
 
 ```shell

oslab/run
 ```


 若连接不上 确认是否开启支持客户端通过网络连接 或者ip错误