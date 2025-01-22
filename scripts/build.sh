#!/bin/bash

# Update package list and install npm
apt-get update
apt-get install -y npm

# Ensure npm is in the PATH
export PATH=$PATH:/usr/local/bin

# Install npm dependencies
npm install