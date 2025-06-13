terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket-gitactionsproject"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
