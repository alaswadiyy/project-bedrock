variable "public_subnets" {
  description = "List of public subnet IDs for the cluster"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs for the node group"
  type        = list(string)
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.34"
}
