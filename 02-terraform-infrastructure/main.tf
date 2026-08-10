terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Upgraded to v5 to properly support modern import blocks
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# This instructs Terraform to find your existing server and map it to your code
import {
  to = aws_instance.example
  id = "i-0074101a2aa5a4c4e"
}

resource "aws_instance" "example" {
  ami           = "ami-0a02a779008fa3b99"
  instance_type = "t2.micro"

  tags = {
    Name = "HCLS-Phase1-Ubuntu"
  }
}
