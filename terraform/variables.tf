variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "barakat-2025-capstone"
}

variable "vpc_cidr" {
  description = "Default VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name_tag" {
  description = "Default VPC name tag"
  type        = string
  default     = "project-bedrock-vpc"
}

variable "assets_bucket_name" {
  description = "Name of the assets S3 bucket (optional override)"
  type        = string
  default     = ""
}

variable "catalog_db_password" {
  description = "Password for catalog DB (sensitive)"
  type        = string
  default     = ""
}

variable "orders_db_password" {
  description = "Password for orders DB (sensitive)"
  type        = string
  default     = ""
}

variable "iam_user_password" {
  description = "Initial IAM user password (sensitive)"
  type        = string
  default     = ""
}

variable "student_id" {
  description = "Student or tenant identifier used in bucket names"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "production"
}
