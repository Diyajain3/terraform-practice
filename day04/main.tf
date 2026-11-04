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
  default = "Dev"
  type = string
}

variable "channel_name" {
  default = "diyajain"
}
locals{
  bucket_name="${var.channel_name}-bucket-${var.enviroment}"
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
  cidr_block = "10.0.1.0/24"
  region = "us-east-1"
  tags={
    Enviroment= var.enviroment   /*"Dev"*/
    Name="${var.enviroment}-VPC"
  }
}
resource "aws_ec2_instance" "example" {
 ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id=aws_subnet.sample.id
  tags={
    Enviroment= var.enviroment   /*"Dev"*/
    Name="${var.enviroment}-EC2-Instance"
  }
}
