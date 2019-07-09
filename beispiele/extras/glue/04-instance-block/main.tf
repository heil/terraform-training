module "centos-02" {
  source = "../../modules/terraform-module-aws-instance/block"

  ami                         = data.aws_ami.centos.id
  associate_public_ip_address = true
  domain_name                 = "cloud.local"
  hostname                    = "centos-02"
  instance_type               = "t2.small"
  private_ip                  = ""
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [data.aws_security_group.glue-02.id]

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
