terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }

  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.region
  # Force set sts_region to preventing hanging on invalid regions
  sts_region = "us-east-1"
}
