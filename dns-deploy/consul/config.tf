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
      Project = "dns-deploy"
    }
  }
}

provider "consul" {
  address    = "172.19.80.1:8500"
  datacenter = "dc1"
  token      = var.consul_token
}


