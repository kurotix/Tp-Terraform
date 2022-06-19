# Simple AWS Lambda Terraform Example
# requires 'index.js' in the same directory
# to test: run `terraform plan`
# to deploy: run `terraform apply`

variable "aws_region" {
  default = "us-east-1"
}

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "hello.js"
    output_path   = "hello-world.zip"
}

resource "aws_lambda_function" "hello-world" {
  function_name = "hello"
  s3_bucket     = "terr-bucket-svkpl"
  s3_key        = "hello.zip"
  role          = aws_iam_role.lambda_role.arn
  handler       = "hello.handler"  
  runtime       = "nodejs12.x"
}

