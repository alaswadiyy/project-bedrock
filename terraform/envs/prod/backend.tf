terraform {
  backend "s3" {
    bucket         = "bedrock-assests-alt-soe-025-1329"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "project-bedrock-tfstate-lock"
    use_lockfile = true
    encrypt        = true
  }
}
