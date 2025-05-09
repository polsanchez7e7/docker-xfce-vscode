#pol.sanchez.7e7@itb.cat

FROM ubuntu:24.04

ENV USER=developer \
    PASSWORD=vncpassword \
    DEBIAN_FRONTEND=noninteractive

# Repositoris bàsics i afegir clau de VS Code
RUN apt-get update && apt-get install -y \
    wget curl gnupg software-properties-common

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm microsoft.gpg

# Instal·lació de tot el necessari
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    tightvncserver \
    dbus-x11 x11-xserver-utils \
    openssh-server \
    python3 python3-pip \
    code && \
    apt-get clean

# Crear usuari i configurar VNC
RUN useradd -m $USER && \
    echo "$USER:$PASSWORD" | chpasswd && \
    mkdir -p /home/$USER/.vnc && \
    echo "$PASSWORD" | vncpasswd -f > /home/$USER/.vnc/passwd && \
    chmod 600 /home/$USER/.vnc/passwd && \
    chown -R $USER:$USER /home/$USER/.vnc

# Script de l'escriptori
RUN echo '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &' > /home/$USER/.vnc/xstartup && \
    chmod +x /home/$USER/.vnc/xstartup

# Configurar SSH (important crear carpetes i claus per evitar errors)
RUN mkdir /var/run/sshd

# Exposa ports
EXPOSE 5901 22

# Arrenca VNC i SSH alhora
CMD /usr/sbin/sshd && su - $USER -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -F /home/$USER/.vnc/*.log"
