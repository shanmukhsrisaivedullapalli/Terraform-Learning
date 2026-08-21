# This is a single line comment in Terraform configuration file
/* This is a multi-line comment in Terraform configuration file
   It can span multiple lines */

terraform {
    required_version = ">= 1.15.8"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 6.58.0"
        }
    }
}

provider "aws" {
    region = "ap-south-2"
}

locals {
    name_prefix = "web-server"
    common_tags = {
        Environment = "dev"
        ManagedBy   = "Terraform"
    }
}

variable "key_name" {
    description = "my personal favorite key pair"
    type = string
    default = "MyPersonalFavoriteKeyPair"
}

variable "instance_type" {
    description = "Type of EC2 instance"
    type = string
    default = "t3.micro"
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance at ap-south-2 region"
    type = string
    default = "ami-0304448c82662e9ac"
}

variable "iam_instance_profile" {
    description = "IAM instance profile for the EC2 instance"
    type = string
    default = "SSMInstanceRole"
}

data "aws_vpc" "default" {
    default = true
}

resource "aws_security_group" "tempserver_sg" {
    name = "${local.name_prefix}-sg"
    description = "Security group for web server"
    vpc_id = data.aws_vpc.default.id
    tags = {
        Name = "${local.name_prefix}-sg"
        Environment = local.common_tags.Environment
        ManagedBy = local.common_tags.ManagedBy
    }
    ingress {
        description = "Allow HTTP traffic"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow SSH traffic"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow Ping"
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

module "tempserver" {
    source = "./modules/web_server"
    server_name = "${local.name_prefix}-instance"
    associate_public_ip_address = true
    security_groups = [aws_security_group.tempserver_sg.name]
    iam_instance_profile = var.iam_instance_profile
    tags = {
        Name = "${local.name_prefix}-instance"
        Environment = local.common_tags.Environment
        ManagedBy = local.common_tags.ManagedBy
    }
    user_data = <<-EOF
                   #!/bin/bash
                   sudo yum update -y
                   sudo yum install -y httpd
                   sudo systemctl start httpd
                   sudo systemctl enable httpd
                   echo "<h1>Welcome to '${local.name_prefix}-instance'</h1>" | sudo tee /var/www/html/index.html
                   EOF
    user_data_replace_on_change = true
}

output "instance_name" {
    value = module.tempserver.instance_name
}

output "instance_public_ip" {
    value = module.tempserver.public_ip
}

output "instance_public_dns" {
    value = module.tempserver.public_dns
}