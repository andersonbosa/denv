# Use the latest Ubuntu as the base image
FROM debian:stable AS BASE_SYSTEM

LABEL author "github.com/andersonbosa"
LABEL version "1.0.0"

# Variables
ARG PREFERED_RUBY_VERSION="3.0.0"
ARG PREFERED_NODE_VERSION="stable"

ARG USER_UID=1000
ARG USER_NAME=denv
ARG USER_PASSWORD=denv
ARG USER_GID=$USER_UID
ARG USER_HOME_PATH="/home/${USER_NAME}"

ARG SHELL_CONFIG_FILE=".bashrc"

# Update the system
RUN apt-get update

# Install essential dependencies
RUN apt-get install -y \
  build-essential \
  software-properties-common iputils-ping \
  git \
  openssh-client wget curl httpie \
  zsh tmux \
  vi vim

### Version Managers

# Install Node.js using NVM
# https://github.com/nvm-sh/nvm#installing-and-updating
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
  && export NVM_DIR="$HOME/.nvm" \
  && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
  && nvm install $PREFERED_NODE_VERSION

# Install Python and create a virtual environment using venv
RUN apt-get install -y python3 python3-venv \
  && python3 -m venv $USER_HOME_PATH/venv \
  && echo 'source $USER_HOME_PATH/venv/bin/activate' >> ~/$SHELL_CONFIG_FILE


# Install Ruby using rbenv
RUN apt-get install -y rbenv \
  && rbenv init \
# && echo 'eval "$(rbenv init -)"' >> ~/$SHELL_CONFIG_FILE \
# && rbenv install $PREFERED_RUBY_VERSION \
# && rbenv global $PREFERED_RUBY_VERSION


# # Install other tools and dependencies
RUN apt-get install -y \
  nmap sqlmap dnsrecon tcpdump \
  crunch gobuster ffuf wfuzz dirsearch \
  ncat netrw netcat-traditional hashcat

# TODO: metasploit-framework nuclei semgrep nikto theharvester netcat impacket-scripts beef-xss

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" \
  && chsh -s /usr/bin/zsh


# Install OhMyTmux
# https://github.com/gpakosz/.tmux
RUN cd $HOME \
  && git clone https://github.com/gpakosz/.tmux.git \
  && ln -s -f .tmux/.tmux.conf \
  && cp .tmux/.tmux.conf.local . 


############################################################################3


# Add a regular user
RUN groupadd --gid $USER_GID $USER_NAME \
  && useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash $USER_NAME \
  && usermod -aG sudo $USER_NAME \
  && echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set password for the regular user
RUN echo "$USER_NAME:$USER_PASSWORD" | chpasswd

# Set the working directory
WORKDIR $USER_HOME_PATH

# Copy files to the working directory
COPY ./root /
COPY ./home $USER_HOME_PATH

# Share the Docker socket
VOLUME ["/var/run/docker.sock", "/var/run/docker.sock"]
VOLUME ["./shared", "/shared"]


# Expose any necessary ports (if applicable)
EXPOSE 80 443 8080

# Set entrypoint
COPY ./scripts/entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

# Start the container
CMD [ "zsh" ]