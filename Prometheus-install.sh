#!/bin/bash

# Define Prometheus version to install
VERSION="2.33.0"

# Define user and group for Prometheus
PROMETHEUS_USER="prometheus"
PROMETHEUS_GROUP="prometheus"

# Create user and group if they do not exist
getent group $PROMETHEUS_GROUP || sudo groupadd $PROMETHEUS_GROUP
getent passwd $PROMETHEUS_USER || sudo useradd -r -s /bin/false -g $PROMETHEUS_GROUP $PROMETHEUS_USER

# Download and extract Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-amd64.tar.gz
tar xvfz prometheus-${VERSION}.linux-amd64.tar.gz

# Move Prometheus files to /opt
sudo mv prometheus-${VERSION}.linux-amd64 /opt/prometheus

# Create directories for Prometheus data and configuration files
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# Set ownership and permissions for Prometheus directories
sudo chown $PROMETHEUS_USER:$PROMETHEUS_GROUP /etc/prometheus /var/lib/prometheus
sudo chmod 775 /etc/prometheus /var/lib/prometheus

# Create directories for Prometheus configuration files
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done

# Set ownership and permissions for Prometheus configuration directories
sudo chown -R $PROMETHEUS_USER:$PROMETHEUS_GROUP /etc/prometheus
sudo chmod -R 775 /etc/prometheus

# Copy default Prometheus configuration file to /etc/prometheus
sudo cp /opt/prometheus/prometheus.yml /etc/prometheus/

# Set ownership and permissions for Prometheus configuration file
sudo chown $PROMETHEUS_USER:$PROMETHEUS_GROUP /etc/prometheus/prometheus.yml
sudo chmod 775 /etc/prometheus/prometheus.yml

# Clean up downloaded files
rm prometheus-${VERSION}.linux-amd64.tar.gz

# Start Prometheus as a background process
nohup /opt/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/data > /dev/null 2>&1 &

# sudo apt update && apt upgrade
# mkdir -p /etc/prometheus
# mkdir -p /var/lib/prometheus
# wget https://github.com/prometheus/prometheus/releases/download/v2.37.6/prometheus-2.37.6.linux-amd64.tar.gz
# tar -xvf prometheus-2.37.6.linux-amd64.tar.gz
# sudo cd prometheus-2.37.6.linux-amd64
# sudo mv prometheus promtool /usr/local/bin/
# sudo mv console_libraries/ consoles/ /etc/prometheus/
# sudo mv prometheus.yml /etc/prometheus/prometheus.yml
# sudo groupadd --system prometheus
# sudo useradd -s /sbin/nologin --system -g prometheus prometheus
# sudo chmod -R 775 /etc/prometheus/ /var/lib/prometheus/
# sudo chown -R prometheus:prometheus /etc/prometheus/ /var/lib/prometheus/