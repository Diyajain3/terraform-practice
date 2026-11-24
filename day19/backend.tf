terraform {
  backend "s3" {
    bucket = "diya-terraform-bucket1"
    key    = "terraform-day19.tfstate"
    region = "us-east-1"
  }
}