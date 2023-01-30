#  Configure VPC
resource "aws_vpc" "LSCFT_VPC" {
  cidr_block       = var.cidr_for_vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "LSCFT_VPC"
  }
}

#  Configure Public Subnet
resource "aws_subnet" "public_sub_1" {
  vpc_id     = aws_vpc.LSCFT_VPC.id
  cidr_block = var.cidr_for_public_sub_1
  availability_zone = var.AZ_1

  tags = {
    Name = "public_sub_1"
  }
}

resource "aws_subnet" "public_sub_2" {
  vpc_id     = aws_vpc.LSCFT_VPC.id
  cidr_block = var.cidr_for_public_sub_2
  availability_zone = var.AZ_2

  tags = {
    Name = "public_sub_2"
  }
}

#  Configure Private Subnet
resource "aws_subnet" "private_sub_1" {
  vpc_id     = aws_vpc.LSCFT_VPC.id
  cidr_block = var.cidr_for_private_sub_1
  availability_zone = var.AZ_2

  tags = {
    Name = "private_sub_1"
  }
}

resource "aws_subnet" "private_sub_2" {
  vpc_id     = aws_vpc.LSCFT_VPC.id
  cidr_block = var.cidr_for_private_sub_2
  availability_zone = var.AZ_3

  tags = {
    Name = "private_sub_2"
  }
}

# Configure Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.LSCFT_VPC.id

  tags = {
    Name = "public_route_table"
  }
}

# Configure Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.LSCFT_VPC.id

  tags = {
    Name = "private_route_table"
  }
}

# Configure Public Route Table Association
resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.public_sub_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_sub_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Configure Private Route Table Association
resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id      = aws_subnet.private_sub_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id      = aws_subnet.private_sub_2.id
  route_table_id = aws_route_table.private_route_table.id
}

# Configure Internet Gateway
resource "aws_internet_gateway" "lscft_internet_gateway" {
  vpc_id = aws_vpc.LSCFT_VPC.id

  tags = {
    Name = "lscft_internet_gateway"
  }
}

# Configure AWS Route
resource "aws_route" "public_internet_gateway_route" {
  route_table_id = aws_route_table.public_route_table.id
  gateway_id                = aws_internet_gateway.lscft_internet_gateway.id
  destination_cidr_block    = "0.0.0.0/0"
}

# Configure NAT Gateway
resource "aws_nat_gateway" "LSCFT_NatGateway" {
  allocation_id = aws_eip.LSCFT_Elastic_IP.id
  subnet_id     = aws_subnet.public_sub_1.id

  tags = {
    Name = "LSCFT_NatGateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.lscft_internet_gateway]
}

# Configure Elastic IP
resource "aws_eip" "LSCFT_Elastic_IP" {
# instance = aws_instance.web.id
  vpc      = true
}