FROM ubuntu:latest

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y tzdata
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt install -y firefox dnsutils openvpn

ADD start.sh /start.sh

ENTRYPOINT ["/start.sh"]