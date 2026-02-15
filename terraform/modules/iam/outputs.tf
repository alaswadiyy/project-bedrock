output "dev_view_username" {
  description = "IAM user name for developer access"
  value       = aws_iam_user.dev_view.name
}

output "dev_view_access_key_id" {
  description = "Access key ID for developer (sensitive)"
  value       = aws_iam_access_key.dev_view.id
  sensitive   = true
}

output "dev_view_access_key_secret" {
  description = "Secret access key for developer (sensitive)"
  value       = aws_iam_access_key.dev_view.secret
  sensitive   = true
}

output "dev_view_console_password" {
  description = "Console login password for developer (sensitive)"
  value       = aws_iam_user_login_profile.dev_view.password
  sensitive   = true
}
