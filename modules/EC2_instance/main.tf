terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
locals {
  ingress_rules = [
    {
        port = 22
        description = "ssh port"
    },
    {
        port = 443
        description = "https port"
    },
    {
        port = 8080
        description = "jenkins default port"
    }
  ]
}
resource "aws_instance" "instance_creation" {
  ami = "ami-08982f1c5bf93d976"
  instance_type= "t2.micro"
  key_name = "Dockerkeypair"
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data = file("jenkins.sh")
  tags = {
    Name = "jenkins_instance"
  }
}

resource "aws_security_group" "main" {
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allows all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
       from_port   = ingress.value.port
       to_port     = ingress.value.port
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
       description = ingress.value.description
    }
  }
}
