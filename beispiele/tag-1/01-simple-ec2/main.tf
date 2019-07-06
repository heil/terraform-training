data "aws_ami" "bionic" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "example-01" {
  key_name   = "example-01"
  public_key = file("~/.ssh/id_rsa.aws.pub")
}

resource "aws_security_group" "example-01" {
  name        = "example-01-external-access"
  description = "Allow basic access from external"

  tags = {
    Name        = "example-01-external-access"
    Description = "Security Group example-01 for external access"
    Environment = "day-01"
  }
}

resource "aws_security_group_rule" "ingress_tcp_cidr_22" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.example-01.id
}

resource "aws_security_group_rule" "ingress_icmp_echo_request" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "8"
  to_port           = "0"
  protocol          = "icmp"
  type              = "ingress"
  security_group_id = aws_security_group.example-01.id
}

resource "aws_security_group_rule" "egress_tcp_all" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "1"
  to_port           = "65234"
  protocol          = "tcp"
  type              = "egress"
  security_group_id = aws_security_group.example-01.id
}

resource "aws_instance" "example-01" {
  ami             = data.aws_ami.bionic.id
  instance_type   = "t2.nano"
  key_name        = aws_key_pair.example-01.key_name
  security_groups = [aws_security_group.example-01.name]

  tags = {
    Name        = "example-01"
    Description = "Instance example-01"
    Environment = "day-01"
  }

  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }
}

output "public_ip" {
  value = aws_instance.example-01.public_ip
}
