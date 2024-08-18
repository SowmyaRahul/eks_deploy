
# Define Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.main.id
}


# # Create NAT Gateways
resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_eip_1.id
  subnet_id     = aws_subnet.subnet_az1_public.id
  depends_on    = [aws_internet_gateway.my_igw]
}


# Create Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip_1" {
  vpc = true
}


# Create Route Table for Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    "Name" = "publibbbb"
  }
  tags_all = {
    "Name" = "publibbbb"
  }

  #   subnet_ids = [
  #     aws_subnet.subnet_az1_public.id,
  #     aws_subnet.subnet_az2_public.id
  #   ]
}


# Associate Route Tables with Public Subnets
resource "aws_route_table_association" "public_association_1" {
  subnet_id      = aws_subnet.subnet_az1_public.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_association_2" {
  subnet_id      = aws_subnet.subnet_az2_public.id
  route_table_id = aws_route_table.public_route_table.id
}


# Create Route Tables for Private Subnets
resource "aws_route_table" "secure_route_table_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
  }
}

# Associate Route Tables with Secure Subnets
resource "aws_route_table_association" "secure_association_1" {
  subnet_id      = aws_subnet.subnet_az1_secure.id
  route_table_id = aws_route_table.secure_route_table_1.id
}

resource "aws_route_table_association" "secure_association_2" {
  subnet_id      = aws_subnet.subnet_az2_secure.id
  route_table_id = aws_route_table.secure_route_table_1.id
}

# No Association Route Tables with Private Subnets
