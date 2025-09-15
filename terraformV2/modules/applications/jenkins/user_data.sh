#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting Jenkins installation for ${environment} environment at $(date)"

# Clean up space first
echo "Cleaning up space..."
dnf clean all
rm -rf /tmp/*
rm -rf /var/cache/dnf/*

# Update system
echo "Updating system..."
dnf update -y

# Install Java 17
echo "Installing Java 17..."
dnf install java-17-amazon-corretto -y

# Install Jenkins
echo "Installing Jenkins..."
# Install wget first
dnf install -y wget

# Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
dnf install -y jenkins

# Install additional tools
echo "Installing additional tools..."
dnf install -y git

# Install SSM Agent
echo "Installing SSM Agent..."
dnf install -y amazon-ssm-agent

# Start services
echo "Starting services..."
systemctl start jenkins
systemctl enable jenkins

# Start SSM Agent
echo "Starting SSM Agent..."
systemctl start amazon-ssm-agent
systemctl enable amazon-ssm-agent

echo "Jenkins installation completed at $(date)"
echo "Jenkins URL: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8080"
echo "Initial admin password: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"