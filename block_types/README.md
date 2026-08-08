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
resource "local_file" "example" {
  filename = "${path.module}/output.txt"
  content  = "Hello from Terraform!"
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
variable "file_name" {
  type        = string
  default     = "sample.txt"
  description = "The name of the file to create"
}
```

## 6. `locals` block
Defines temporary internal values and expressions. Unlike variables, local values cannot be overridden externally.
```hcl
locals {
  environment = "dev"
  file_prefix = "app-${local.environment}"
  common_tags = {
    ManagedBy = "Terraform"
    Env       = local.environment
  }
}
```

## 7. `output` block
Exposes values generated after applying infrastructure configurations (e.g., resource IDs, file paths, IP addresses).
```hcl
output "created_file_path" {
  value       = local_file.example.filename
  description = "Absolute path of the generated local file"
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
