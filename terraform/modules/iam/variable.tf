variable "iam_user_password" {
    description = "iam user console password"
    type = string
    default = ""
}

variable "cluster_name" {
    description = "EKS cluster name (optional)"
    type        = string
    default     = ""
}