terraform {
  
  backend "s3" {
    bucket         = "bedrock-assests-alt-soe-025-1329"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "project-bedrock-tfstate-lock"
    use_lockfile = true
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
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
