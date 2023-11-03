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
  access_key = "AKIAZQ4WYSBP4DPW6XHK"
  secret_key = "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"
  region     = var.region
}