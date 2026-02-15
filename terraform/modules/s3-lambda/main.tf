# IAM role for Lambda execution
resource "aws_iam_role" "lambda_exec" {
  name = "bedrock-asset-processor-lambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {"Service": "lambda.amazonaws.com"},
      "Effect": "Allow"
    }
  ]
}
EOF
  tags = {
    Project = "barakat-2025-capstone"
  }
}

# Attach basic execution policy to Lambda role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Archive Lambda source code
data "archive_file" "lambda_processor" {
  type        = "zip"
  source_dir  = "${path.module}/../../../lambda/asset-processor"
  output_path = "${path.module}/../../../lambda/bedrock-asset-processor.zip"
}

# Lambda function for asset processing
resource "aws_lambda_function" "processor" {
  filename      = data.archive_file.lambda_processor.output_path
  function_name = "bedrock-asset-processor"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  runtime       = "python3.12"
  source_code_hash = data.archive_file.lambda_processor.output_base64sha256
  
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
  
  tags = {
    Project = "barakat-2025-capstone"
  }
  
  depends_on = [aws_iam_role_policy_attachment.lambda_basic_execution]
}

# Allow S3 to invoke the Lambda function
resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.assets.arn
}

# S3 bucket notification to trigger Lambda
resource "aws_s3_bucket_notification" "asset_notification" {
  bucket = aws_s3_bucket.assets.id
  
  lambda_function {
    lambda_function_arn = aws_lambda_function.processor.arn
    events              = ["s3:ObjectCreated:*"]
  }
  
  depends_on = [aws_lambda_permission.allow_s3_invoke]
}