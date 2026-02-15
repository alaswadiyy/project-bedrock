# S3 bucket for assets
resource "aws_s3_bucket" "assets" {
  bucket = "bedrock-assets-${var.student_id}"
  
  tags = {
    Project = "barakat-2025-capstone"
  }
}
