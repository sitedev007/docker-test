#!/bin/bash

# Get the hostname of the container
HOSTNAME=$(hostname)

echo "******************************************************************************"
echo "Starting Wetty from script start-wetty.sh"
echo "******************************************************************************"
echo "Using SSH Host: $HOSTNAME"

# Debugging information
echo "User: $(whoami)"
echo "Home Directory: $HOME"
ls -l /usr/src/wetty
env

sudo service ssh start 

# sed -i -e 's/my_docker_hostname/'$(hostname)'/g' /usr/src/wetty/config.json5
sed  -e 's/my_docker_hostname/'$(hostname)'/g' /usr/src/wetty/config.json5 > tmp; cat tmp > config.json5; rm tmp;
# Start Wetty with the retrieved hostname
# npm start -- --port 3000 --ssh-host "$HOSTNAME" --ssh-port 22
# sudo npm start --port 3000 --ssh-host "$HOSTNAME" --ssh-port 22

npm start -- --conf /usr/src/wetty/config.json5

# /bin/bash