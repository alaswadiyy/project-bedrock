resource "aws_s3_bucket" "assets" {
  bucket = "bedrock-assets-${var.student_id}"
  
  tags = {
    Project = "barakat-2025-capstone"
  }
}

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

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_s3_bucket_notification" "asset_notification" {
  bucket = aws_s3_bucket.assets.id
  
  lambda_function {
    lambda_function_arn = aws_lambda_function.processor.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.assets.arn
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