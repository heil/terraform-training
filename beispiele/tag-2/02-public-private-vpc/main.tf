resource "aws_vpc" "example-02" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name        = "example-02"
    Description = "Example public private VPC"
    Environment = "day-01"
  }
}

resource "aws_eip" "example-02" {
  vpc = true
}

resource "aws_internet_gateway" "example-02" {
  vpc_id = aws_vpc.example-02.id
}

resource "aws_subnet" "example-02-subnet-01" {
  vpc_id = aws_vpc.example-02.id

  cidr_block        = "10.10.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name        = "example-02-subnet-01"
    Description = "Public subnet-01 for example-02 VPC"
    Environment = "day-01"
  }
}

resource "aws_route_table" "example-02" {
  vpc_id = aws_vpc.example-02.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example-02.id
  }

  tags = {
    Name        = "example-02"
    Description = "Route Table for public subnet example-02-subnet-01"
    Environment = "day-01"
  }
}

resource "aws_route_table_association" "example-02" {
  subnet_id      = aws_subnet.example-02-subnet-01.id
  route_table_id = aws_route_table.example-02.id
}

resource "aws_nat_gateway" "example-02" {
  allocation_id = aws_eip.example-02.id
  depends_on    = ["aws_internet_gateway.example-02"]
  subnet_id     = aws_subnet.example-02-subnet-01.id
}

resource "aws_subnet" "example-02-subnet-02" {
  vpc_id = aws_vpc.example-02.id

  cidr_block        = "10.10.2.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name        = "example-02-subnet-02"
    Description = "Private Subnet example-02-subnet-02 for VPC example-02"
    Environment = "day-01"
  }
}

resource "aws_route_table" "example-02-subnet-02" {
  vpc_id = aws_vpc.example-02.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example-02.id
  }

  tags = {
    Name        = "Private Subnet"
    Description = "Route Table for private subnet example-02-subnet-02"
    Environment = "day-01"
  }
}

resource "aws_route_table_association" "example-02-subnet-02" {
  subnet_id      = aws_subnet.example-02-subnet-02.id
  route_table_id = aws_route_table.example-02-subnet-02.id
}

#add second private subnet with different availzone for further use
resource "aws_subnet" "example-02-subnet-03" {
  vpc_id = aws_vpc.example-02.id

  cidr_block        = "10.10.3.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name        = "example-02-subnet-03"
    Description = "Private Subnet example-02-subnet-03 for VPC example-02"
    Environment = "day-01"
  }
}

resource "aws_route_table" "example-02-subnet-03" {
  vpc_id = aws_vpc.example-02.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example-02.id
  }

  tags = {
    Name        = "Private Subnet"
    Description = "Route Table for private subnet example-02-subnet-03"
    Environment = "day-01"
  }
}

resource "aws_route_table_association" "example-02-subnet-03" {
  subnet_id      = aws_subnet.example-02-subnet-03.id
  route_table_id = aws_route_table.example-02-subnet-03.id
}
