resource "aws_security_group" "windows" {
  name        = "windows-external-access"
  description = "Allow access from external"
  vpc_id      = data.aws_vpc.terraform-training-vpc.id

  tags = {
    Name        = "windows"
    Description = "Security Group windows for external access"
    Environment = "day-03"
  }
}

resource "aws_security_group_rule" "ingress_tcp_rdp" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3389
  protocol          = "tcp"
  to_port           = 3389
  type              = "ingress"
  security_group_id = aws_security_group.windows.id
}

resource "aws_security_group_rule" "ingress_tcp_winrm" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 5985
  protocol          = "tcp"
  to_port           = 5986
  type              = "ingress"
  security_group_id = aws_security_group.windows.id
}

resource "aws_security_group_rule" "icmp_echo_request" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 8
  protocol          = "icmp"
  to_port           = 0
  type              = "ingress"
  security_group_id = aws_security_group.windows.id
}

resource "aws_security_group_rule" "egress_tcp_all" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "1"
  to_port           = "65234"
  protocol          = "tcp"
  type              = "egress"
  security_group_id = aws_security_group.windows.id
}

resource "aws_security_group_rule" "egress_udp_all" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "53"
  to_port           = "53"
  protocol          = "udp"
  type              = "egress"
  security_group_id = aws_security_group.windows.id
}

data "template_file" "ansible_inventory" {
  template = file("templates/inventory.tpl")
  vars = {
    ip_address = module.windows-01.public_ip
    admin_pw   = "lee+Ngi_a2iek4vai1"
    admin_user = "admin"
  }
}

resource "local_file" "inventory" {
  content    = data.template_file.ansible_inventory.rendered
  filename   = "${path.root}/ansible/inventory"
  depends_on = ["module.windows-01"]
}

module "windows-01" {
  source = "../../modules/terraform-module-aws-instance/dual"

  admin_pw   = "lee+Ngi_a2iek4vai1"
  admin_user = "admin"
  # ami                         = data.aws_ami.amazon_windows_2019.id
  ami                         = "ami-0378c96af0ed74c0b"
  associate_public_ip_address = true
  domain_name                 = "cloud.local"
  hostname                    = "windows-01"
  instance_type               = "t2.large"
  key_name                    = "thomas"
  os_type                     = "windows"
  private_ip                  = ""
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.windows.id]
}

output "windows-01_public_ip" {
  value = module.windows-01.public_ip
}

resource "null_resource" "run_ansible" {
  triggers = {
    policy_sha1 = sha256(file("${path.root}/ansible/inventory"))
  }
  provisioner "local-exec" {
    working_dir = "${path.root}/ansible"
    command     = "ansible-playbook -i inventory site.yml"
  }
  depends_on = ["module.windows-01"]
}
