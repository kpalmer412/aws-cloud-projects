echo 'terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

import {
  to = aws_instance.example
  id = "i-0074101a2aa5a4c4e"
}

resource "aws_instance" "example" {
  ami                    = "ami-0a02a779008fa3b99"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/www/html/index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "HCLS-Phase1-Ubuntu"
  }
}

resource "aws_security_group" "instance" {
  name        = "HCLS-Phase1-Ubuntu"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "vpc-0ee987ece99c06ebc"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}' > main.tf && ls -la main.tf && terraform init && terraform plan

