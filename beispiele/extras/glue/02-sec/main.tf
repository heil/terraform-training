resource "aws_security_group" "glue-02" {
  name        = "glue-02-external-access"
  description = "Allow access from external"
  vpc_id      = data.aws_vpc.terraform-training-vpc.id

  tags = {
    Name        = "glue-02-external-access"
    Description = "Security Group glue-02 for external access"
    Environment = "day-03"
  }
}

resource "aws_security_group_rule" "ingress_tcp_22" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  type              = "ingress"
  security_group_id = aws_security_group.glue-02.id
}

resource "aws_security_group_rule" "ingress_udp_openvpn" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "1194"
  to_port           = "1194"
  protocol          = "udp"
  type              = "ingress"
  security_group_id = aws_security_group.glue-02.id
}

resource "aws_security_group_rule" "ingress_icmp_echo_request" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "8"
  to_port           = "0"
  protocol          = "icmp"
  type              = "ingress"
  security_group_id = aws_security_group.glue-02.id
}

resource "aws_security_group_rule" "egress_tcp_all" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "1"
  to_port           = "65234"
  protocol          = "tcp"
  type              = "egress"
  security_group_id = aws_security_group.glue-02.id
}

resource "aws_security_group_rule" "egress_udp_all" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "53"
  to_port           = "53"
  protocol          = "udp"
  type              = "egress"
  security_group_id = aws_security_group.glue-02.id
}

resource "aws_security_group_rule" "egress_icmp_echo_request" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "8"
  to_port           = "0"
  protocol          = "icmp"
  type              = "egress"
  security_group_id = aws_security_group.glue-02.id
}
