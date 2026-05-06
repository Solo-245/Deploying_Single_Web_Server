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

  tags = {
    Name = "HelloWorld"
  }
}