#!/bin/bash

# Define Elasticsearch version
ELK_VERSION="8.17.3"
ELK_TAR="elasticsearch-${ELK_VERSION}-linux-x86_64.tar.gz"
ELK_SHA="${ELK_TAR}.sha512"

# Update system and install required packages
sudo apt update -y
sudo apt install -y wget apt-transport-https

# Download Elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/$ELK_TAR
wget https://artifacts.elastic.co/downloads/elasticsearch/$ELK_SHA

# Verify SHA checksum
shasum -a 512 -c $ELK_SHA
if [ $? -ne 0 ]; then
    echo "Checksum verification failed!"
    exit 1
fi

# Extract Elasticsearch
tar -xzf $ELK_TAR
cd elasticsearch-${ELK_VERSION}/

# Create a systemd service file
sudo tee /etc/systemd/system/elasticsearch.service > /dev/null <<EOF
[Unit]
Description=Elasticsearch
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=$USER
Group=$USER
ExecStart=$(pwd)/bin/elasticsearch
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and enable Elasticsearch service
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service

# Start Elasticsearch
sudo systemctl start elasticsearch.service

# Check Elasticsearch status
sudo systemctl status elasticsearch.service
