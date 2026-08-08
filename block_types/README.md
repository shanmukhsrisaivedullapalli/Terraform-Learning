# Terraform Block Types
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