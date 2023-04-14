#!/bin/bash

# Add the Grafana repository to the APT sources list
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# Import the Grafana GPG key to verify package signatures
curl https://packages.grafana.com/gpg.key | sudo apt-key add -

# Update the package list
sudo apt-get update

# Install Grafana
sudo apt-get install -y grafana

# Start the Grafana service
sudo systemctl start grafana-server

# Enable the Grafana service to start on boot
sudo systemctl enable grafana-server
