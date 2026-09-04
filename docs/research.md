@'
# Terraform IaC Research

## 1. Terraform vs AWS CloudFormation vs AWS CDK

### Terraform

Terraform is a declarative Infrastructure as Code tool that allows infrastructure to be described using configuration files.

Advantages:

- Multi-cloud support
- Reusable modules
- Clear plan and apply workflow
- Large provider ecosystem
- Remote state management
- Strong support for infrastructure automation

### AWS CloudFormation

AWS CloudFormation is AWS's native Infrastructure as Code service.

Advantages:

- Deep AWS integration
- Native AWS resource support
- AWS-managed state
- Stack-based deployment model
- Change sets for reviewing infrastructure changes

### AWS CDK

AWS CDK allows infrastructure to be defined using programming languages such as TypeScript, Python, Java, C#, and Go.

Advantages:

- Infrastructure can be defined using familiar programming languages
- Reusable constructs
- Strong AWS integration
- Higher-level abstractions

### Comparison

| Feature | Terraform | CloudFormation | AWS CDK |
|---|---|---|---|
| Cloud support | Multi-cloud | AWS | AWS |
| Configuration | HCL | YAML/JSON | Programming languages |
| Reusable components | Modules | Nested stacks | Constructs |
| State | Terraform state | AWS-managed | CloudFormation stacks |
| Plan workflow | terraform plan | Change sets | cdk diff |
| AWS integration | Strong | Native | Native |

Terraform was selected for this project because reusable modules, remote state, state locking, plan/apply workflows and environment isolation were required.

---

## 2. Remote State

Terraform state records the relationship between Terraform configuration and real infrastructure.

For collaborative environments, remote state provides:

- Shared state
- Centralized infrastructure management
- Reduced risk of local state loss
- Better collaboration
- Support for state locking

This project stores Terraform state in Amazon S3.

Separate state keys are used:

```text
terraform-iac/dev/terraform.tfstate
terraform-iac/staging/terraform.tfstate