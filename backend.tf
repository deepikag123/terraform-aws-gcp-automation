terraform {
  backend "s3" {
    bucket         = "deepika-tf-state-2025"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
