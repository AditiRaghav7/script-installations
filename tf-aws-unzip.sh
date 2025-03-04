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
sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:hashicorp/terraform
sudo apt install terraform -y

# Verify Installations
echo "Verifying installations..."
terraform -version
aws --version
unzip -v

echo "Installation complete! 🚀"
