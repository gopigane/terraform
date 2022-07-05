provider "aws" {
  shared_config_files      = ["/home/ubuntu/.aws/config"]
  shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
}




resource "aws_vpc" "terraform-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "terraform"

  }

}


#subnet creation
resource "aws_subnet" "tera-sub-1" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
tags = {
    Name = "ter-sub-1"
  }
}


resource "aws_subnet" "tera-sub-2" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
 map_public_ip_on_launch = true  
tags = {
    Name = "ter-sub-2"
  }
}




#INTERNET GATEWAY CREATION
resource "aws_internet_gateway" "ter-igw" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "ter-igw"
  }
}





#ROUTING TABLES
resource "aws_route_table" "ter-rt-1" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ter-igw.id
  }
  tags = {
    Name = "ter-rt-1"
  }
}




#HERE WE ATTACHING SUBNETS TO ROUTING TABLE
resource "aws_route_table_association" "sub1" {
  subnet_id      = aws_subnet.tera-sub-1.id
  route_table_id = aws_route_table.ter-rt-1.id
}


resource "aws_route_table_association" "sub2" {
  subnet_id      = aws_subnet.tera-sub-2.id
  route_table_id = aws_route_table.ter-rt-1.id
}


