resource "aws_instance" "example" {
  ami           = "ami-0ff8a91507f77f867"
  count=var.instance_count
  #instance_type = "t3.micro"
 instance_type=var.environment=="dev"?"t2.micro":"t3.micro"

  tags = var.tags
}

resource "aws_security_group" "ingress_rule" {
  name   = "sg"

  dynamic "ingress"  {
    for_each=var.ingress_rules
    content{
      from_port=ingress.value.from_port
      to_port=ingress.value.to_port
      cidr_blocks=ingress.value.cidr_blocks
      protocol =ingress.value.protocol
    }
  }
  egress  = []
}

locals {
  all_instance_ids=aws_instance.example[*].id
}
output "instances"{
  value =local.all_instance_ids
}