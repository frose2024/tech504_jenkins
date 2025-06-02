# Create an EC2 instance
provider "aws" {
  region = "eu-west-1"
}

# Where to create this EC2 instance (i.e. what cloud provider)


# Which region we want things to be created in.
resource "aws_instance" "app_instance" {
    ami = var.app_ami_id
    instance_type = var.instance_type

    associate_public_ip_address = var.associate_public_ip_address

    key_name = var.key_name

    vpc_security_group_ids = [aws_security_group.custom_sg.id]

    tags = {
      Name = "tech504-florence-jenkins-server"
    }
}

# Be explicit about referring the security group to the vm, hardcode that in. Somehow it worked, but the somehow is concerning. 

# Retrieve the default vpc from AWS
data "aws_vpc" "default" {
  default = true
}

# Creating the secruity group resource
resource "aws_security_group" "custom_sg" {
  name = "tech504-florence-tf-allow-port-22-3000-80"
  description = "Allow port 22 from localhost, 3000 and 80 from all"
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "tech504-florence-tf-allow-port-22-3000-80"
  }
}

# Allow SSH from my ip
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_home" {
  security_group_id = aws_security_group.custom_sg.id
  cidr_ipv4         = var.my_ip
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Allow SSH from my ip"
}

# Allow HTTP from anywhere
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.custom_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  description = "Allow http from anywhere"
}

# Allow port 3000 from anywhere
resource "aws_vpc_security_group_ingress_rule" "allow_port_3000" {
  security_group_id = aws_security_group.custom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  to_port           = 3000
  ip_protocol       = "tcp"
  description       = "Allow port 3000 from anywhere"
}

# Allow all egress traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_egress_ipv4" {
  security_group_id = aws_security_group.custom_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Allow all outbound ipv4 traffic"
}

# Allow jenkins traffic
resource "aws_vpc_security_group_ingress_rule" "allow_jenkins_traffic"{
  security_group_id = aws_security_group.custom_sg.id
  cidr_ipv4 = var.my_ip
  from_port = 8080
  to_port = 8080
  ip_protocol = "tcp"
  description = "Allow jenkins web traffic"
}