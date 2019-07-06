resource "aws_vpc" "example-01" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name        = "example-01"
    Description = "Example public VPC"
    Environment = "day-01"
  }
}

resource "aws_eip" "example-01" {
  vpc = true
}

resource "aws_internet_gateway" "example-01" {
  vpc_id = aws_vpc.example-01.id
}

resource "aws_subnet" "example-01-subnet-01" {
  vpc_id = aws_vpc.example-01.id

  cidr_block        = "10.10.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name        = "example-01-subnet-01"
    Description = "Public subnet-01 for example-01 VPC"
    Environment = "day-01"
  }
}

resource "aws_route_table" "example-01" {
  vpc_id = aws_vpc.example-01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example-01.id
  }

  tags = {
    Name        = "example-01"
    Description = "Route Table for public subnet example-01-subnet-01"
    Environment = "day-01"
  }
}

resource "aws_route_table_association" "example-01" {
  subnet_id      = aws_subnet.example-01-subnet-01.id
  route_table_id = aws_route_table.example-01.id
}

resource "aws_nat_gateway" "example-01" {
  allocation_id = aws_eip.example-01.id
  depends_on    = ["aws_internet_gateway.example-01"]
  subnet_id     = aws_subnet.example-01-subnet-01.id
}
