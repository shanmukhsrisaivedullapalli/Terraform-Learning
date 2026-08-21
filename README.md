# Terraform
Terraform is written in HashiCorp Configuration Language (HCL), which is declarative and domain specific language used to define and provision Infrastructure as Code (IaC).

---

# Comments
There are two types of comments in Terraform:
1. `Single line comments`: These start with `#`
    example:
    ```hcl
    # Single Line Comment
    // Alternative single-line comment
    ```
2. `Multi-Line comments`: These start with `/*` and end with `*/`
    example:
    ```hcl
    /* This is a multi-line comment
    which ends here. */
    ```

# Core Workflow Commands
1. `terraform init` - Initializes the working directory and downloads required provider plugins.
2. `terraform plan` - Previews the execution plan without applying changes.
3. `terraform apply` - Executes the changes described in the configuration.
4. `terraform destroy` - Destroy all managed infrastructure.

# Basic Configuration Elements
1. `Providers:` Tell Terraform which platform (AWS, Azure, GCP, Local) to interact with.
2. `Resources:` Define infrastructure objects (VPCs, EC2 instances, local files).
3. `Variables:` Input values to make configurations reusable.
4. `Outputs:` Values returned after infrastructure deployment.
5. `Data Sources:` Query and fetch information about existing infrastructure outside of Terraform or defined elsewhere.
6. `Locals:` Define temporary local named values/expressions to reduce repetition and simplify configurations.
7. `Modules:` Package and reuse multiple related resources together as a single reusable component.
8. `Terraform Settings / Backend:` Configure Terraform's core behavior, required version/providers, and where the state file is stored.