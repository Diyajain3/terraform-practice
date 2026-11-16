variable "project_name" {
  default = "Project ALPHA Resource"
}

variable "default_tags" {
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}

variable "enviroment_tags" {
  default = {
    enviroment  = "production"
    cost_center = "cc-123"
  }
}

variable "bucket_name" {
  default = "projectAlphaStorage qith Caps and Spaces!!!"
}
variable "allowed_ports" {
  default = "80,443,8080,3306"
}

variable "instance_sizes" {
  default = {
    dev     = "t2.micro"
    staging = "t3.small"
    prod    = "t3.large"
  }
}

variable "enviroment" {
  default = "dev"
}
