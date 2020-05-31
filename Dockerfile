FROM ubuntu:latest

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt update

RUN apt install -y tzdata
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt install -y dnsutils openvpn sudo curl

RUN curl https://downloads.vivaldi.com/stable/vivaldi-stable_3.0.1874.38-1_amd64.deb -o vivaldi.deb
RUN apt install -y ./vivaldi.deb
RUN rm vivaldi.deb

ENV USERNAME guiuser
RUN useradd -m $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    usermod --shell /bin/bash $USERNAME && \
    usermod -aG sudo $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    # Replace 1000 with your user/group id
    usermod  --uid 1000 $USERNAME && \
    groupmod --gid 1000 $USERNAME

ADD start.sh /start.sh

ENTRYPOINT ["su", "guiuser", "/start.sh"]