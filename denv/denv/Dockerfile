FROM debian:stable-slim

# https://github.com/ConSol/docker-headless-vnc-container/blob/master/Dockerfile.debian-xfce-vnc

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:6901/?password=vncpassword
ENV DISPLAY=:1 \
    SSH_PORT=22 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901

ENV HOME=/headless \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/headless/install \
    NO_VNC_HOME=/headless/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x1024 \
    VNC_PW=vncpassword \
    VNC_VIEW_ONLY=false


##
# Install necessary packages and tools.

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    software-properties-common iputils-ping \
    openssh-client \
    openssh-server \
    libnss-wrapper gettext supervisor icewm xterm xfonts-base xauth xinit dbus-x11 libdbus-glib-1-2 \
    tigervnc-tools \
    tigervnc-common \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    sudo \
    git wget curl httpie zsh tmux vim \
    && rm -rf /var/lib/apt/lists/*

##
# Add user

# Create a new user 'denv' and set password 'denv'
RUN useradd --create-home --shell /bin/bash denv \
    && echo "denv:denv" | chpasswd

# Allow the 'denv' user to run commands with sudo without a password
RUN echo 'denv ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set the VNC password for the 'denv' user
RUN mkdir -p /home/denv/.vnc \
    && echo "denvdenv" | vncpasswd -f > /home/denv/.vnc/passwd \
    && chmod 600 /home/denv/.vnc/passwd \
    && chown -R denv:denv /home/denv/.vnc

##
# File system

# Create directories /root and /home inside the container.

# Copy the contents of "machine/root" to "/root" in the container.
COPY ./entrypoint.sh /entrypoint.sh
COPY ./machine/home /home/

##
# Set up SSH server and VNC server configuration here.

# Expose the SSH and VNC ports.
EXPOSE $SSH_PORT $VNC_PORT $NO_VNC_PORT

##
# Start SSH server when the container starts.
CMD ["sh", "/entrypoint.sh"]
