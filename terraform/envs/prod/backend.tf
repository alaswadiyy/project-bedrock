terraform {
  backend "s3" {
    bucket         = "bedrock-tfstate-alt-soe-025-1329"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bedrock-tf-locks-alt-soe-025-1329"
    #use_lockfile = true
    encrypt        = true
  }
}
