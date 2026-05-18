variable "region" {
  type = string
  description = "aws region for deployment"
  default = "us-east-2"
}

variable "instance_type" {
  type = string
  description = "EC2 instance size"
  default = "t3.micro"
}

variable "key_name" {
  type = string
  description = "SSH key pair name"
  default = "my-terraform-key"
}

variable "cidr_blocks" {
  type = list(string)
  description = "List of IPv4 CIDR blocks allowed for inbound traffic"
  default = ["0.0.0.0/0"]
}