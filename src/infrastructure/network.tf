# VPC
resource "aws_vpc" "sample_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = merge(local.common_tags, {
    # This will be the name of the VPC
    Name = "${var.project}-${terraform.workspace}-vpc"
  })
  enable_dns_hostnames = true
}

# Internet Gateway
# An internet gateway, is basically just a connection to the internet
resource "aws_internet_gateway" "sample_igw" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = merge(local.common_tags, {
    Name = "${var.project}-${terraform.workspace}-igw"
  })
}

# Subnet
resource "aws_subnet" "vpc_sample_subnet_a" {
  vpc_id            = aws_vpc.sample_vpc.id
  
  cidr_block        = "10.0.0.0/24"
  availability_zone = data.aws_availability_zones.az.names[0]
  # When we launch any instance or resources into the subnet, they'll be automatically assigned public IP address.
  # which they will be able to connect to the outside internet
  # If we don't set this value to true, we will need to at a NAT gateway to the VPC, to enable the instances to connect to theinternet
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${var.project}-${terraform.workspace}-subnet-a"
  })
}

resource "aws_subnet" "vpc_sample_subnet_b" {
  vpc_id            = aws_vpc.sample_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.az.names[1]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${var.project}-${terraform.workspace}-subnet-b"
  })
}

# We need to add an entry to the route table to allow all traffic to go through an internet gateway into the public internet
resource "aws_route" "route_public_internet" {
  # Grabs the main route of the created VPC
  route_table_id = aws_vpc.sample_vpc.main_route_table_id
  # This  IP means anywhere
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sample_igw.id
}
