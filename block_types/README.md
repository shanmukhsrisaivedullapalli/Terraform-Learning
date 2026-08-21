# Block Types
In terraform, **blocks** are the primary structural elements written in HashiCorp Configuration Language (HCL). They act as containers that define infrastructure, configure providers, manage data flow, and orgainze code.

---

## 1. `Terraform` block
Configures settings for terraform itself, such as required provider versions and remote state storage.

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }

  # Example remote backend setup
  # backend "s3" {
  #   bucket = "my-tf-state-bucket"
  #   key    = "state/terraform.tfstate"
  # }
}
```

## 2. `provider` block
Configures the specific plugin or service API used to manage resources.
```hcl
provider "aws" {
  region = "us-east-1"
}
```

## 3. `resource` block
Defines an infrastructure object to be provisioned and managed by Terraform.
```hcl
resource "aws_instance" "tempserver" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
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
                   echo "<h1>Welcome to '${local.name_prefix}-instance'</h1>" > /var/www/html/index.html
                   EOF
}
```

## 4. `data` block
Fetches information about existing, external resources without managing their lifecycle.
```hcl
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
```

## 5. `variable` block
Declares input variables to make configurations dynamic and reusable across environments.
```hcl
variable "iam_instance_profile" {
    description = "IAM instance profile for the EC2 instance"
    type = string
    default = "SSMInstanceRole"
}
```

## 6. `locals` block
Defines temporary internal values and expressions. Unlike variables, local values cannot be overridden externally.
```hcl
locals {
    name_prefix = "web-server"
    common_tags = {
        Environment = "dev"
        ManagedBy   = "Terraform"
    }
}
```

## 7. `output` block
Exposes values generated after applying infrastructure configurations (e.g., resource IDs, file paths, IP addresses).
```hcl
output "instance_public_ip" {
    description = "Public IP address of the EC2 instance"
    value = aws_instance.tempserver.public_ip
}
```

## 8. `module` block
Calls and reuses a self-contained folder or package of Terraform files from a local path, Git repository, or Registry.
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "my-custom-vpc"
  cidr = "10.0.0.0/16"
}
```
