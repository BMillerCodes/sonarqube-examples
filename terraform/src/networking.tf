# Networking Configuration
# Code smell: hardcoded VPC/subnet IDs

# Code smell: hardcoded VPC
resource "aws_vpc" "app_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "app-vpc"
  }
}

# Code smell: hardcoded subnet IDs
resource "aws_subnet" "app_subnet_1" {
  vpc_id                  = "vpc-01234567890abcdef"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "app-subnet-1"
  }
}

resource "aws_subnet" "app_subnet_2" {
  vpc_id                  = "vpc-01234567890abcdef"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "app-subnet-2"
  }
}

# Code smell: hardcoded internet gateway
resource "aws_internet_gateway" "app_igw" {
  vpc_id = "vpc-01234567890abcdef"

  tags = {
    Name = "app-igw"
  }
}

# Code smell: hardcoded route table
resource "aws_route_table" "app_route_table" {
  vpc_id = "vpc-01234567890abcdef"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-01234567890abcdef"
  }

  tags = {
    Name = "app-route-table"
  }
}