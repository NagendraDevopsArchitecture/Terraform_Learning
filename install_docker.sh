#!/bin/bash
# Update the installed packages
sudo yum update -y
# Install Docker
sudo yum install docker -y
# Start the Docker service
sudo systemctl restart docker
# Enable Docker to start on boot
sudo systemctl enable docker
# Add the ec2-user to the docker group
sudo usermod -a -G docker ec2-user

sudo docker info
sudo docker --version