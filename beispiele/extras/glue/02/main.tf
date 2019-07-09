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

data "aws_ami" "centos" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_vpc" "example-02" {
  filter {
    name   = "tag:Name"
    values = ["example-02"]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["example-02-subnet-01"]
  }
  vpc_id = data.aws_vpc.example-02.id
}

resource "aws_security_group" "glue-02" {
  name        = "glue-02-external-access"
  description = "Allow access from external"
  vpc_id      = data.aws_vpc.example-02.id

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

resource "aws_security_group_rule" "egress_icmp_echo_request" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "8"
  to_port           = "0"
  protocol          = "icmp"
  type              = "egress"
  security_group_id = aws_security_group.glue-02.id
}

module "centos-02" {
  source = "../../modules/terraform-module-aws-instance/block"

  ami                         = data.aws_ami.bionic.id
  associate_public_ip_address = true
  domain_name                 = "cloud.local"
  hostname                    = "centos-01"
  instance_type               = "t2.small"
  private_ip                  = ""
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.glue-02.id]

  volume_label       = "centos_02"
  volume_mount_point = "/srv"
  volume_device      = "/dev/xvdh"
  volume_size        = 50
  volume_type        = "gp2"

}

output "centos-02_public_ip" {
  value = module.centos-02.public_ip
}

output "centos-02_private_ip" {
  value = module.centos-02.private_ip
}
