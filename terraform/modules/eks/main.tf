resource "aws_eks_cluster" "main" {
  name     = "project-bedrock-cluster"
  role_arn = aws_iam_role.cluster.arn
  version  = "1.34"
  
  vpc_config {
    subnet_ids = concat(var.public_subnets, var.private_subnets)
  }
  
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  
  tags = {
    Name    = "project-bedrock-cluster"
    Project = "barakat-2025-capstone"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "main-node-group"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = var.private_subnets
  
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  
  instance_types = ["t3.medium"]
  
  tags = {
    Project = "barakat-2025-capstone"
  }
}