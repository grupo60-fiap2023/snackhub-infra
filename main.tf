terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.23.1"
    }
  }
  required_version = ">= 1.1.0"
}

provider "aws" {
  access_key = "acskey"
  secret_key = "srckey"
  region     = var.region
}