# Deployment Guide

## Prerequisites
- AWS Account with admin permissions
- Terraform 1.0+
- kubectl, helm, AWS CLI

## Steps
1. Clone repository: `git clone [repo-url]`
2. Configure AWS credentials
3. Run: `cd terraform && terraform init`
4. Deploy: `terraform apply`
5. Configure kubeconfig: `aws eks update-kubeconfig`
6. Deploy app: `helm install retail-store`

## Access
- Application URL: [ALB DNS name]
- CloudWatch Logs: [Link to log groups]
- Developer Access:
  Access Key: [AKIA...]
  Secret Key: [Provided separately]

## Pipeline
- PR: Triggers `terraform plan`
- Merge to main: Triggers `terraform apply`
