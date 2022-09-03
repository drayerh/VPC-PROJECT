#vpc
resource "aws_vpc" "mydemo_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my demo vpc"
  }
}

#public subnet 1
resource "aws_subnet" "pub_sub_1" {
  vpc_id            = aws_vpc.mydemo_vpc.id
  cidr_block        = var.cidr-for-pubsub1
  availability_zone = var.AZ-1

  tags = {
    Name = "my public subnet 1"
  }
}

#public subnet 2
resource "aws_subnet" "pub_sub_2" {
  vpc_id            = aws_vpc.mydemo_vpc.id
  cidr_block        = var.cidr-for-pubsub2
  availability_zone = var.AZ-2

  tags = {
    Name = "my public subnet 2"
  }
}

#private subnet 1
resource "aws_subnet" "priv_sub_1" {
  vpc_id            = aws_vpc.mydemo_vpc.id
  cidr_block        = var.cidr-for-privsub1
  availability_zone = var.AZ-3

  tags = {
    Name = "my private subnet 1"
  }
}

#private subnet 2
resource "aws_subnet" "priv_sub_2" {
  vpc_id            = aws_vpc.mydemo_vpc.id
  cidr_block        = var.cidr-for-privsub2
  availability_zone = var.AZ-3

  tags = {
    Name = "my private subnet 2"
  }
}

#internet gateway
resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.mydemo_vpc.id

  tags = {
    Name = "my internet gateway"
  }
}

#public route table
resource "aws_route_table" "demo_pub_rt" {
  vpc_id = aws_vpc.mydemo_vpc.id

  tags = {
    Name = "my public route table"
  }
}

#private route table
resource "aws_route_table" "demo_priv_rt" {
  vpc_id = aws_vpc.mydemo_vpc.id

  tags = {
    Name = "my private route table"
  }
}

# Route table association pub1
resource "aws_route_table_association" "public-route-table-association1" {
  subnet_id      = aws_subnet.pub_sub_1.id
  route_table_id = aws_route_table.demo_pub_rt.id
}

# Route table association pub2
resource "aws_route_table_association" "public-route-table-association2" {
  subnet_id      = aws_subnet.pub_sub_2.id
  route_table_id = aws_route_table.demo_pub_rt.id
}

# Route table association priv1
resource "aws_route_table_association" "private-route-table-association1" {
  subnet_id      = aws_subnet.priv_sub_1.id
  route_table_id = aws_route_table.demo_priv_rt.id
}

# Route table association priv2
resource "aws_route_table_association" "private-route-table-association2" {
  subnet_id      = aws_subnet.priv_sub_2.id
  route_table_id = aws_route_table.demo_priv_rt.id
}


#  IGW-Public route table Association
resource "aws_route" "igw_public_route" {
  route_table_id         = aws_route_table.demo_pub_rt.id
  gateway_id             = aws_internet_gateway.myIGW.id
  destination_cidr_block = "0.0.0.0/0"
}

# Elastic IP
resource "aws_eip" "demo_eip" {
  vpc = true
}

# Create NAT gateway
resource "aws_nat_gateway" "mydemo_Nat_gateway" {
  allocation_id = aws_eip.demo_eip.id
  subnet_id     = aws_subnet.pub_sub_1.id

  tags = {
    Name = "my nat gateway"
  }
}

# Associating NATgateway with private route table
resource "aws_route" "Nat_gateway-demo_priv_rt_association" {
  route_table_id         = aws_route_table.demo_priv_rt.id
  nat_gateway_id         = aws_nat_gateway.mydemo_Nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}