terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # Backend configuration example is placed in backend.tf (commented out by default)
}

# EC2 instance used for provisioner demos.
# Each provisioner block is included below but wrapped in block comments (/* ... */).
# For the demo, uncomment one provisioner block at a time, then `terraform apply`.

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu official)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "tf-prov-demo-ssh"
  description = "Allow SSH inbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "terraform-provisioner-demo"
  }

  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  
   provisioner "remote-exec" {
     inline = [
       "sudo apt-get update",
       "echo 'Hello from remote-exec' | sudo tee /tmp/remote_exec.txt",
     ]
   }

  # provisioner "local-exec" {
  # command = "echo 'Local-exec: created instance ${self.id} with IP ${self.public_ip}'"
  #}

  provisioner "file"{
    source = "${path.module}/scripts/welcome.sh"
    destination = "/tmp/welcome.sh"
  }
}
