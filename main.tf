resource "aws_instance" "patientdata_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.security_instance.id]

   tags = {
    Name = "PatientDataServer"
  }
}

resource "aws_security_group" "security_instance" {
  name = "patient_data_instance_sg"
  description = "Allow port 8080 and 22"

  ingress {
    description = "Allow application traffic"
    from_port = 8080
    to_port = 8080
     protocol = "tcp"
     cidr_blocks = var.cidr_blocks
  }
  
  ingress {
    description = "Allow administrative SSH"
    from_port = 22
    to_port = 22
     protocol = "tcp"
     cidr_blocks = var.cidr_blocks
  }

  egress {
   description = "Allow all outbound traffic"
   from_port = 0
   to_port = 0
   protocol = "-1"
    cidr_blocks = var.cidr_blocks
  }
}

 