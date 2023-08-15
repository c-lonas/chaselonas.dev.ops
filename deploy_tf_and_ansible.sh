#!/bin/bash

# This script is a placeholder that will ultimately be replaced by a CI/CD pipeline

PRIVATE_KEY_PATH=${1}

# Provision EC2 Instance
cd terraform
terraform apply -auto-approve -var-file=secrets.tfvars
INSTANCE_IP=$(terraform output instance_public_ip | tr -d '"')

#temporary wait
sleep 10

# Install Docker on EC2 instance
cd ../ansible
ansible-playbook -i "${INSTANCE_IP}," --private-key=${PRIVATE_KEY_PATH} --user=ec2-user setup_docker.yml
cd ..