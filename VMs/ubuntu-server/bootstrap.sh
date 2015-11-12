#!/usr/bin/env bash

# Update and upgrade the server's packages
sudo aptitude update
sudo aptitude -y upgrade

# Install Node.js using the Debian/Ubuntu packages that are maintained by the Node.js team
# Source: http://www.hostingadvice.com/how-to/install-nodejs-ubuntu-14-04/#maintained-ubuntu-packages)
curl -sL https://deb.nodesource.com/setup | sudo bash -

sudo apt-get -y install nodejs

# Install MongoDB
# Source: https://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
#
# Import the public key used by the package management system
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

# Create a list file for MongoDB
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Reload local package database
sudo apt-get update

# Install MongoDB
sudo apt-get install -y mongodb-org
