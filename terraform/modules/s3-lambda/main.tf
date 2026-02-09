resource "aws_s3_bucket" "assets" {
  bucket = "bedrock-assets-${var.student_id}"
  
  tags = {
    Project = "barakat-2025-capstone"
  }
}

resource "aws_s3_bucket_notification" "asset_notification" {
  bucket = aws_s3_bucket.assets.id
  
  lambda_function {
    lambda_function_arn = aws_lambda_function.processor.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_function" "processor" {
  filename      = "lambda/asset-processor.zip"
  function_name = "bedrock-asset-processor"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  runtime       = "python3.12"
  
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
  
  tags = {
    Project = "barakat-2025-capstone"
  }
}