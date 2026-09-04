# Network Module

Reusable Terraform module for creating:

- VPC
- Public subnet
- Internet Gateway
- Public route table
- Security group

## Inputs

- `project_name`
- `environment`
- `vpc_cidr`
- `public_subnet_cidr`
- `availability_zone`
- `ssh_cidr_blocks`

## Outputs

- `vpc_id`
- `public_subnet_id`
- `security_group_id`