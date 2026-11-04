terraform {
  backend "s3" {
    bucket         = "diya-terraform-bucket1"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt = true
    use_lockfile=true
  }
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

variable "enviroment" {
  //enviroment is local name of variable
  //input variable defining it and giving value
  default = "dev"
  type = string
}

variable "channel_name" {
  default = "diyajain"
}

variable "region" {
  default = "us-east-1"
}
locals{
  bucket_name="${var.channel_name}-bucket-${var.enviroment}-${var.region}"
  vpc_name="${var.enviroment}-VPC"
}
#create S3 Bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = local.bucket_name

  tags = {
    Name        ="${var.enviroment}-Bucket"// "Dev-Bucket "
    Environment =  var.enviroment   /*"Dev"*/
  }
}

resource "aws_vpc" "sample" {
cidr_block = "10.0.0.0/16"
  region = var.region
  tags={
    Enviroment= var.enviroment   /*"Dev"*/
    Name="${var.enviroment}-VPC"
  }
}
resource "aws_instance" "example" {
 ami           =  "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t2.micro"
  region=var.region
  
    tags={
    Enviroment= var.enviroment   /*"Dev"*/
    Name="${var.enviroment}-EC2-Instance"
  }
}

output "vpc_id" {
  value = aws_vpc.sample.id
}
output "ec2_id" {
  value = aws_instance.example.id
}

