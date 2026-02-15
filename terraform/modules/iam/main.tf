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
  pgp_key = var.iam_user_password
  password_length = 10
  
  # Optional: Require password reset on first login
  password_reset_required = false
}

# Create access keys
resource "aws_iam_access_key" "dev_view" {
  user = aws_iam_user.dev_view.name
}
