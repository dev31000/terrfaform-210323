terraform {
  required_providers {
      aws = {
          source  = "hashicorp/aws"
          version = "~>3.0.0"
      }
  }
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "terraform"
}

resource "aws_instance" "bastion-instance" { 
  ami = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.bastion-subnet.id

  security_groups = [
    "${aws_security_group.bastion-sg.id}"
  ]

  tags = {
    Name = "Bastion Host"
    project = "assignment"
  }
}

resource "aws_instance" "web-instance" { 
  ami = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.web-subnet.id

  security_groups = [
    "${aws_security_group.web-sg.id}"
  ]

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -qq",
      "sudo apt install -y curl",
      "sudo apt install -y apache2",
      "sudo systemctl start apache2",
      "sudo ufw allow 443",
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/ubuntu-user.pem")
  }

  tags = {
    Name = "Web Host"
    project = "assignment"
  }
}

resource "aws_instance" "app-instance" { 
  ami = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.app-subnet.id

  security_groups = [
    "${aws_security_group.app-sg.id}"
  ]

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -qq",
      "sudo apt install -y curl",
      "sudo apt install -y apache2",
      "sudo systemctl start apache2",
      "sudo ufw allow 443",
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/ubuntu-user.pem")
  }

  tags = {
    Name = "App Host"
    project = "assignment"
  }
}