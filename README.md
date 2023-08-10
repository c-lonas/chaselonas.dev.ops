# chaselonas.dev Portfolio Site

This project (will) demonstrates the use of a variety of key DevOps technologies and skills 


## Architecture Overview

0. Dockerize placeholder web app
1. Terraform to spin up EC2 instance
2. Ansible to pull down docker image & setup
3. Monitoring and Logging stack - EFK


## Setup

### Dockerize Webapp (If needed)
`docker run -d -p 3000:3000 --name sample_ts_app sample-ts-app`

### AWS Config
`aws configure --profile <profile_name>`

### Terraform
`terraform init` 

`terraform plan -var-file=secrets.tfvars`

### Ansible