#!/bin/bash

# This script is a placeholder that will ultimately be replaced by a CI/CD pipeline


# Provision EC2 Instance
cd terraform
terraform apply -auto-approve -var-file=secrets.tfvars
INSTANCE_IP=$(terraform output instance_public_ip)


cd ../ansible
ansible-playbook -i "${INSTANCE_IP}," setup_docker.yml
sleep 5

cd ../terraform
terraform destroy -auto-approve -var-file=secrets.tfvars