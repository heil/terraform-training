resource "aws_security_group" "lamp-rds" {
  name        = "lamp-rds-access"
  vpc_id      = data.aws_vpc.example-02.id
  description = "Allow access to the RDS"

  tags = {
    Name        = "lamp-rds-access"
    Description = "Allow access to the RDS"
    Environment = "day-03"
  }
}

resource "aws_db_subnet_group" "lamp-rds" {
  name       = "lamp-rds"
  subnet_ids = [data.aws_subnet.subnet-02.id, data.aws_subnet.subnet-03.id]

  tags = {
    Name        = "lamp-rds-subnet"
    Description = "Subnet for RDS"
    Environment = "day-03"
  }
}

resource "aws_security_group_rule" "ingress_tcp_3306" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "3306"
  to_port           = "3306"
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.lamp-rds.id
}

resource "aws_db_instance" "lamp-rds" {
  allocated_storage      = 10
  engine                 = "mysql"
  identifier_prefix      = "lamp-rds"
  instance_class         = "db.t2.micro"
  name                   = "lamp"
  password               = "verySec9re"
  username               = "admin"
  db_subnet_group_name   = aws_db_subnet_group.lamp-rds.id
  vpc_security_group_ids = [aws_security_group.lamp-rds.id]
}
