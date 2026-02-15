# Project Bedrock — InnovateMart EKS Deployment

Terraform IaC + GitHub Actions CI/CD to provision AWS EKS and deploy the retail-store-sample-app.

Region: us-east-1
# Project Bedrock — InnovateMart EKS deployment

Project Bedrock is a Terraform-based infrastructure repository that provisions a production-style AWS platform featuring an Amazon EKS cluster, supporting VPC network, RDS databases, event-driven S3 → Lambda processing, and CI/CD via GitHub Actions.

**Quick facts**
- **Region:** `us-east-1`
- **EKS cluster:** `project-bedrock-cluster`
- **VPC tag name:** `project-bedrock-vpc`
- **Kubernetes namespace:** `retail-app`

**Architecture (high level)**
- **Network:** Custom VPC with public and private subnets across multiple AZs.
- **Compute:** Managed Amazon EKS cluster with node groups.
- **Networking:** Application Load Balancer exposed via Kubernetes Ingress.
- **Data:** Managed RDS instances for persistence.
- **Observability:** CloudWatch for logs and cluster control-plane logging enabled.
- **Serverless:** S3-triggered Lambda for asset processing.

**Repository layout**
- `terraform/` — root Terraform configuration and module wiring.
- `terraform/modules/` — reusable modules (vpc, eks, iam, s3-lambda, etc.).
- `terraform/envs/prod/` — environment-specific variables and provider configuration.
- `lambda/` — Lambda source code used by the S3 → Lambda flow.

**Prerequisites**
- Install `terraform` v1.x and AWS CLI.
- AWS credentials with permissions to create the resources in the target account (or use GitHub Actions secrets).

**Important notes before you run**
- Update the backend S3 bucket in `terraform/main.tf` (replace `[YOUR-ID]`) or configure a working remote backend in `terraform/envs/prod/backend.tf`.
- Provide sensitive values via `terraform.tfvars` or environment variables for DB passwords and any non-default variables (see `terraform/variables.tf`).

**Local quickstart (recommended workflow)**
1. Change to the environment folder:

```bash
cd terraform/envs/prod
```

2. Format and initialize Terraform:

```bash
terraform fmt
terraform init
```

3. Validate and preview changes:

```bash
terraform validate
terraform plan -out plan.tfplan
```

4. Apply (review the plan before applying):

```bash
terraform apply "plan.tfplan"
```

**CI/CD**
- This repository is designed to be used with GitHub Actions: PRs run `terraform plan` and merges to `main` run `terraform apply`. Store AWS credentials as repository secrets and configure backend/state appropriately for your organization.

**Recommended next steps / improvements**
- Add `terraform.tfvars` to your secure environment with `student_id`, database passwords, and any overrides.
- Consider adding stricter IAM policies scoped to least privilege for production use.
- Add automated linting/formatting checks in CI (e.g., `tflint`, `checkov`).

If you want, I can run `terraform fmt` and `terraform validate` here and fix any remaining issues.
cd terraform/envs/prod



terraform init

