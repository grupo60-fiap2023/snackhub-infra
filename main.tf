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
  access_key = "AKIAZQ4WYSBP2Z3IE3P5"
  secret_key = "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"
  region     = "us-east-1"
}