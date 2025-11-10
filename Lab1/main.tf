provider "aws" {
  region = "us-east-1"
}

# ----------------------------
# VPC
# ----------------------------
resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "lab-vpc"
  }
}

# ----------------------------
# Subnet
# ----------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "lab-public-subnet"
  }
}

# ----------------------------
# Internet Gateway
# ----------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "lab-igw"
  }
}

# ----------------------------
# Route Table
# ----------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "lab-public-rt"
  }
}

# Associate route table with subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# ----------------------------
# Security Group
# ----------------------------
resource "aws_security_group" "web_sg" {
  name        = "lab-web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab-web-sg"
  }
}

# ----------------------------
# EC2 Instance with Apache
# ----------------------------
resource "aws_instance" "apache_server" {
  ami           = "ami-0b09ffb6d8b58ca91"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true


  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform Apache EC2</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "lab-apache-ec2"
  }
}


output "ec2_ami"{
    value = aws_instance.apache_server.ami
}

output "ec2_public_ip"{
    value = aws_instance.apache_server.public_ip
}

