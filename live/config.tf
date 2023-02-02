terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_config_files       = ["/home/bohdan/.aws/config"]
  shared_credentials_files  = ["/home/bohdan/.aws/credentials"]
  region = "eu-central-1"
}

