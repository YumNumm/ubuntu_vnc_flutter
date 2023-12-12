FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends lxde  wget git curl xz-utils zip clang curl \
            pkg-config ninja-build cmake libgtk-3-dev libblkid-dev liblzma-dev unzip  tightvncserver && \
    mkdir /root/.vnc

ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod 600 /root/.vnc/passwd

CMD /usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && tail -f /root/.vnc/*:1.log


RUN git clone https://github.com/flutter/flutter 
RUN	mv flutter /opt/ 
ENV PATH $PATH:/opt/flutter/bin
RUN flutter precache

ENV DISPLAY localhost:1.0
RUN lxsession &

EXPOSE 5901
