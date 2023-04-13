#!/bin/bash

# Update the package lists
sudo apt update

# Install dependencies
sudo apt install -y software-properties-common

# Add the Ansible PPA
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt install -y ansible
