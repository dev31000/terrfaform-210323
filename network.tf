resource "aws_vpc" "webapp-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      "Name" = "webapp-vpc"
      "project" = "assignment"
    }
}

resource "aws_subnet" "bastion-subnet" {
    vpc_id = aws_vpc.webapp-vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
      "Name" = "bastion-subnet"
      "project" = "assignment"
    }
}

resource "aws_subnet" "web-subnet" {
    vpc_id = aws_vpc.webapp-vpc.id
    cidr_block = "10.0.2.0/24"

    tags = {
      "Name" = "web-subnet"
      "project" = "assignment"
    }
}

resource "aws_subnet" "app-subnet" {
    vpc_id = aws_vpc.webapp-vpc.id
    cidr_block = "10.0.3.0/24"

    tags = {
      "Name" = "app-subnet"
      "project" = "assignment"
    }
}

resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Allow traffic to Bastion host"
  vpc_id      = aws_vpc.webapp-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    //cidr_blocks = [aws_vpc.main.cidr_block]
    cidr_blocks = ["10.0.0.1/32","10.0.0.2/32"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allow traffic to Web host"
  vpc_id      = aws_vpc.webapp-vpc.id

  ingress {
    description = "From bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
    description = "From Web"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_security_group" "app-sg" {
  name        = "app-sg"
  description = "Allow traffic to App host"
  vpc_id      = aws_vpc.webapp-vpc.id

  ingress {
    description = "From bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
    description = "From Web"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
  }

  tags = {
    Name = "app-sg"
  }
}

