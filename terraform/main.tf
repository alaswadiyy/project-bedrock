terraform {
  required_version = ">= 1.0"
  
  backend "s3" {
    bucket         = "project-bedrock-tfstate-[YOUR-ID]"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "project-bedrock-tfstate-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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

# Module calls
module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source = "./modules/eks"
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
}

module "iam" {
  source = "./modules/iam"
  cluster_name = module.eks.cluster_name
}