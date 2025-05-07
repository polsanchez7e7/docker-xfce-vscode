# Base image
FROM ubuntu:24.04

# Variables básicas
ENV USER=dev \
    PASSWORD=dev123 \
    DEBIAN_FRONTEND=noninteractive

# Instalar dependencias mínimas
RUN apt-get update && apt-get install -y \
    xfce4 \
    tigervnc-standalone-server \
    openssh-server \
    python3 \
    code

# Crear usuario
RUN useradd -m $USER && \
    echo "$USER:$PASSWORD" | chpasswd && \
    mkdir -p /home/$USER/.vnc

# Configurar VNC (solución simplificada)
RUN echo "$PASSWORD" > /home/$USER/.vnc/passwd && \
    chmod 600 /home/$USER/.vnc/passwd

# Configuración básica de XFCE
RUN echo '#!/bin/sh\nstartxfce4 &' > /home/$USER/.vnc/xstartup && \
    chmod +x /home/$USER/.vnc/xstartup

# Puertos
EXPOSE 5901 22

# Comando de inicio (versión simple)
CMD vncserver :1 -geometry 1280x800 -depth 24 && \
    /usr/sbin/sshd -D
