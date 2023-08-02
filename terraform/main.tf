variable "aws_profile" {}

provider "aws" {
    region = "us-west-1"
    profile = var.aws_profile
}

variable "ec2-1" {
    description = "Name the 1st instance on deploy"
}


resource "aws_instance" "webserver" {

    ami = "ami-0c38b9e37c107d921"

    instance_type = "t2.micro"

    # Note: keys are region specific-you need to create the key in the same region specified as provider
    key_name = "devops-portfolio-ec2-access-us-west-1"

    tags = {
        
        Name = "${var.ec2-1}"
    }
}