variable "aws_profile" {}

provider "aws" {
    region = "us-west-1"
    profile = var.aws_profile
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Create a Subnet
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Associate subnet with our route table
resource "aws_route" "route" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Security group to allow SSH, HTTP and HTTPS
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH, HTTP, HTTPS"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "webserver" {

    ami                    = "ami-0c38b9e37c107d921"

    instance_type          = "t2.micro"

    # Note: keys are region specific- you need to create the key in the same region specified as provider
    key_name               = "devops-portfolio-ec2-access-us-west-1"

    vpc_security_group_ids = [aws_security_group.web_sg.id]
    subnet_id              = aws_subnet.subnet.id

    tags = {
        
        Name = "webserver"
    }
}

# Output the public IP of the created EC2 instance for use by Ansible
output "instance_public_ip" {
    value = aws_instance.webserver.public_ip
    description = "The public IP of the web server"
}