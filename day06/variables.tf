
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