terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#create S3 Bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "diyajain-bucket-12345"

  tags = {
    Name        = "My bucket "
    Environment = "Dev"
  }
}
