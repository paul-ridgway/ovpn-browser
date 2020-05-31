FROM ubuntu:latest

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y tzdata
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt install -y curl dnsutils openvpn

RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o chrome.deb
RUN apt install -y ./chrome.deb
RUN rm chrome.deb

ADD start.sh /start.sh

ENTRYPOINT ["/start.sh"]