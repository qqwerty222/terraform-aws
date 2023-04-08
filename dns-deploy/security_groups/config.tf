terraform {
  backend "local" {
    path = "/srv/terraform_state/security_groups/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    consul = {}
  }
}

provider "consul" {
  address    = var.CONSUL_IP
  datacenter = var.CONSUL_DC
  token      = var.CONSUL_TOKEN
}

provider "aws" {
  region     = data.consul_keys.aws_config.var.region
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY


  default_tags {
    tags = {
      Created = "Terraform"
      Project = var.PROJECT_NAME
    }
  }
}




