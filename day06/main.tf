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



