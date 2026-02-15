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

module "s3_lambda" {
  source = "./modules/s3-lambda"
  student_id = var.student_id
}