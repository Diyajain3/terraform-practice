 terraform{ 
  backend "s3" {
    bucket         = "diya-terraform-bucket1"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt = true
    use_lockfile=true
  }
 }