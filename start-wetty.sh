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
ls -l /usr/src/app
env

sudo service ssh start 

# Start Wetty with the retrieved hostname
# npm start -- --port 3000 --ssh-host "$HOSTNAME" --ssh-port 22
npm start