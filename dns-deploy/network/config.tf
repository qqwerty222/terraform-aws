terraform {
  backend "local" {
    path = "/srv/terraform_state/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    consul = {}
  }
}

provider "aws" {
  shared_config_files       = ["/home/bohdan/.aws/config"]
  shared_credentials_files  = ["/home/bohdan/.aws/credentials"]
  region = "eu-central-1"

  default_tags {
    tags = {
      Created = "Terraform"
      Project = var.PROJECT_NAME
    }
  }
}

provider "consul" {
  address    = var.CONSUL_IP
  datacenter = var.CONSUL_DC
  token      = var.CONSUL_TOKEN
}


