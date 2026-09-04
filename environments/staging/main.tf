terraform {
  backend "s3" {
    bucket         = "terraform-iac-state-sakib-2026"
    key            = "terraform-iac/staging/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-iac-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux" {
  most_recent = false
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "image-id"
    values = ["ami-06033d1583f2e66ec"]
  }
}

module "network" {
  source = "../../modules/network"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = data.aws_availability_zones.available.names[0]
  ssh_cidr_blocks    = var.ssh_cidr_blocks
}

module "compute" {
  source = "../../modules/compute"

  project_name      = var.project_name
  environment       = var.environment
  ami_id            = data.aws_ami.amazon_linux.id
  instance_type     = var.instance_type
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.security_group_id
}