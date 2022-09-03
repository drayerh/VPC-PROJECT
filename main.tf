resource "aws_vpc" "mydemo_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my demo vpc"
  }
}
#creating a subnet
resource "aws_subnet" "pub_sub_1" {
  vpc_id     = aws_vpc.mydemo_vpc.id
  cidr_block = "10.0.10.0/24"

  tags = {
    Name = "my public subnet 1"
  }
}
resource "aws_subnet" "pub_sub_2" {
  vpc_id     = aws_vpc.mydemo_vpc.id
  cidr_block = "10.0.20.0/24"

  tags = {
    Name = "my public subnet 2"
  }
}
resource "aws_subnet" "priv_sub_1" {
  vpc_id     = aws_vpc.mydemo_vpc.id
  cidr_block = "10.0.30.0/24"

  tags = {
    Name = "my private subnet 1"
  }
}
resource "aws_subnet" "priv_sub_2" {
  vpc_id     = aws_vpc.mydemo_vpc.id
  cidr_block = "10.0.40.0/24"

  tags = {
    Name = "my private subnet 2"
  }
}
#creating an internet gateway
resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.mydemo_vpc.id

  tags = {
    Name = "my internet gateway"
  }
}
#creating a public route table
resource "aws_route_table" "demo_pub_rt" {
  vpc_id = aws_vpc.mydemo_vpc.id

  tags = {
    Name = "my public route table"
  }

}
#creating a private route table
resource "aws_route_table" "demo_priv_rt" {
  vpc_id = aws_vpc.mydemo_vpc.id

  tags = {
    Name = "my private route table"
  }
}