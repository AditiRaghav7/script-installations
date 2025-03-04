#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install Unzip
echo "Installing Unzip..."
sudo apt install unzip -y

# Install AWS CLI
echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/

# Install Terraform
echo "Installing Terraform..."
sudo apt update && sudo apt install -y wget
wget -O- https://apt.releases.hashicorp.com/gpg | sudo tee /etc/apt/trusted.gpg.d/hashicorp.asc
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt install -y terraform



# Verify Installations
echo "Verifying installations..."
terraform -version
aws --version
unzip -v

echo "Installation complete! 🚀"
