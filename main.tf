provider "aws" {
  region = "us-east-2"
}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

resource "aws_instance" "patientdata_instance" {
  ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t3.micro"
  key_name      = "my-terraform-key" 

  tags = {
    Name = "HelloWorld"
  }
  vpc_security_group_ids = [aws_security_group.security_instance.id]
}

resource "aws_security_group" "security_instance" {
  name = "HelloWorld_instance"
  description = "Allow port 8080 and 22"

  ingress {
    from_port = 8080
    to_port = 8080
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 22
    to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  output "instance_public_ip" {
    value = aws_instance.patientdata_instance.public_ip
  }