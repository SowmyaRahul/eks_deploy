provider "aws" {
  alias  = "deploy"
  region = "us-west-2"
}


resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "Project1VPC"
  }
}

resource "aws_subnet" "subnet_az1_public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_az1_cidr_block
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "SubnetAZ1Public"
  }
}
resource "aws_subnet" "subnet_az2_public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_az2_cidr_block
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "SubnetAZ2Public"
  }
}



resource "aws_subnet" "subnet_az1_private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_az1_cidr_block_private
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "SubnetAZ1Private"
  }
}
resource "aws_subnet" "subnet_az2_private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_az2_cidr_block_private
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "SubnetAZ2Private"
  }
}
resource "aws_subnet" "subnet_az1_secure" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_az1_cidr_block_secure
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "SubnetAZ1Secure"
  }
}
resource "aws_subnet" "subnet_az2_secure" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_az2_cidr_block_secure
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "SubnetAZ2Secure"
  }
}
