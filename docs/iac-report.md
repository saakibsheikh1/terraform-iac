@'
# Infrastructure as Code with Terraform — Final Report

## Project Information

- **Project:** Terraform Infrastructure as Code
- **Author:** Sakib Sheikh
- **Task Date:** 04-09-2026
- **Cloud Provider:** AWS
- **Region:** ap-south-1
- **Terraform Version:** 1.15.9
- **AWS Provider:** 6.63.0
- **Repository:** terraform-iac

---

## Objective

The objective of this assignment was to build a reusable and secure Infrastructure as Code solution using Terraform. The implementation covers AWS infrastructure provisioning, reusable modules, remote state management with locking, safe plan/apply workflows, drift detection, CI/CD integration, sensitive outputs, and infrastructure lifecycle management.

---

# Stage 1 — Terraform Environment and Remote State

## Infrastructure Created

A small AWS environment was created using Terraform consisting of:

- VPC
- Public subnet
- Internet Gateway
- Public route table
- Route table association
- Security group
- EC2 instance

The infrastructure was deployed in the `ap-south-1` region.

## Remote State

Terraform state was migrated from local storage to an Amazon S3 backend.

Backend configuration:

- S3 bucket: `terraform-iac-state-sakib-2026`
- Dev state key: `terraform-iac/dev/terraform.tfstate`
- Staging state key: `terraform-iac/staging/terraform.tfstate`
- Encryption enabled
- S3 versioning enabled

## State Locking

A DynamoDB table named:

`terraform-iac-lock`

was configured for Terraform state locking.

Concurrent Terraform operations were tested. A second Terraform apply operation was blocked while another operation held the state lock, demonstrating that concurrent state modification was prevented.

## Stage 1 Result

Stage 1 was completed successfully.

---

# Stage 2 — Reusable Terraform Modules

Two reusable Terraform modules were created:

```text
modules/
├── network/
└── compute/