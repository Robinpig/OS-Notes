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
