#!/bin/bash

# This script is a placeholder that will ultimately be replaced by a CI/CD pipeline

# Clean up resources
cd terraform
terraform destroy -auto-approve -var-file=secrets.tfvars
