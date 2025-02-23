## Tutorial

先在目录下 build image

```shell

 docker build --platform linux/amd64 --progress=plain -t hit-oslab:v2 .


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