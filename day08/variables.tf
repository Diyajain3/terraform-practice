
variable "enviroment" {
  //enviroment is local name of variable
  //input variable defining it and giving value
  default = "dev"
  type    = string
}


variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}
variable "monitoring_enabled" {
  type    = bool
  default = true
}
variable "associate_public_ip" {
  type    = bool
  default = true
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = list(string)
  default     = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
}
variable "allowed_vm_type" {
  type    = list(string)
  default = ["t2.micro", "t2.small", "t2.medium"]
}
variable "allowed_region" {
  # type=set(string)
  type    = list(string)
  default = ["us-east-1", "us-west-1", "us-west-2", "eu-west-1"]
}
variable "tags" {
  type = map(string)
  default = {
    Enviroment = "dev" /*"Dev"*/
    Name       = "dev-EC2-Instance"
    created_by = "terraform"
  }
}
variable "ingress_values" {
  type    = tuple([number, string, number])
  default = [443, "tcp", 443]
}

variable "config" {
  type = object({
    region         = string,
    monitoring     = bool,
    instance_count = number
  })
  default = {
    region         = "us-east-1",
    monitoring     = true,
    instance_count = 1
  }
}

variable "bucket_names" {
  default = [
    "diya-terraform-count-2026-11001",
    "diya-terraform-count-2026-11002"
  ]
}

variable "bucket_names2" {
  default = [
    "diya-terraform-each-2026-11003",
    "diya-terraform-each-2026-11004"
  ]
}