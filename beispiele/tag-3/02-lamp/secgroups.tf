resource "aws_security_group" "lamp-web" {
  name        = "lamp-web-access"
  vpc_id      = data.aws_vpc.example-02.id
  description = "Allow access to Web-instances"

  tags = {
    Name        = "lamp-web-access"
    Description = "Allow access to the Web-instances"
    Environment = "day-03"
  }
}

resource "aws_security_group_rule" "ingress_tcp_22" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.lamp-web.id
}

resource "aws_security_group_rule" "ingress_tcp_80" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.lamp-web.id
}

resource "aws_security_group_rule" "ingress_tcp_443" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.lamp-web.id
}

resource "aws_security_group_rule" "ingress_icmp_echo_request" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "8"
  to_port           = "0"
  protocol          = "icmp"
  type              = "ingress"
  security_group_id = aws_security_group.lamp-web.id
}

resource "aws_security_group_rule" "egress_tcp_all" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "1"
  to_port           = "65234"
  protocol          = "tcp"
  type              = "egress"
  security_group_id = aws_security_group.lamp-web.id
}
