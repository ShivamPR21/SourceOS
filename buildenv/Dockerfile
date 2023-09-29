FROM ubuntu:lunar

RUN apt update
RUN apt upgrade -y
RUN apt install nasm xorriso grub-pc-bin grub-common clang lld make gcc -y

VOLUME /root/env
WORKDIR /root/env
