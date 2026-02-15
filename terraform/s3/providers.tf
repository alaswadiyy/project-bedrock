terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = {
      Project     = "barakat-2025-capstone"
      Environment = "production"
      ManagedBy   = "terraform"
    }
  }
}