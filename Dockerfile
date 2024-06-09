FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl gnupg && \
    curl -sL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs 


RUN  apt-get install -y build-essential git vim && npm install -g wetty && chmod +rwx /usr/bin/wetty


RUN  cd /usr/src && git clone https://github.com/butlerx/wetty.git && cd wetty && npm install && npm run build 

WORKDIR /usr/src/wetty

RUN apt-get install -y iputils-ping sudo openssh-server

# Create a new user with UID 10002
RUN  useradd -u 10002 ajays && usermod -a -G sudo ajays && usermod -a -G root ajays && echo 'ajays:ajays' | chpasswd


# Add the new user to the sudoers file with no password prompt for sudo
RUN echo 'ajays ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set root password (you can change 'yourpassword' to something more secure)
RUN echo 'root:ajays' | chpasswd

# Copy the shell script into the container
COPY start-wetty.sh /usr/src/wetty/start-wetty.sh

COPY config.json5 /usr/src/wetty/config.json5

RUN chown ajays:root /usr/src/wetty/config.json5 /usr/src/wetty

USER 10002

ENTRYPOINT ["/bin/sh", "/usr/src/wetty/start-wetty.sh"]

# CMD ["npm start"]








