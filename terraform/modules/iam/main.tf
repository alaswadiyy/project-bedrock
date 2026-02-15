# IAM User for developer
resource "aws_iam_user" "dev_view" {
  name = "bedrock-dev-view"
  tags = {
    Project = "barakat-2025-capstone"
  }
}

# Attach read-only policy
resource "aws_iam_user_policy_attachment" "readonly" {
  user       = aws_iam_user.dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Create login profile with specific password
resource "aws_iam_user_login_profile" "dev_view" {
  user    = aws_iam_user.dev_view.name
  password = var.iam_user_password
  
  # Optional: Require password reset on first login
  password_reset_required = false
}

# Create access keys
resource "aws_iam_access_key" "dev_view" {
  user = aws_iam_user.dev_view.name
}

# Output access keys (will be used in deliverables)
output "dev_view_access_key" {
  value     = aws_iam_access_key.dev_view.id
  sensitive = true
}

output "dev_view_secret_key" {
  value     = aws_iam_access_key.dev_view.secret
  sensitive = true
}

# Output console login information
#output "dev_view_console_url" {
#  value = "https://${var.aws_region}.console.aws.amazon.com/"
#}

output "dev_view_username" {
  value = aws_iam_user.dev_view.name
}

output "dev_view_password" {
  description = "Initial password for console access"
  value       = aws_iam_user_login_profile.dev_view.password
  sensitive   = true
}