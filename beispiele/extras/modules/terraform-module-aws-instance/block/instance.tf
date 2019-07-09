data "template_file" "init_mod" {
  template = "${file("${path.module}/../templates/cloud-init.tpl")}"

  vars = {
    domain_name = var.domain_name
    hostname    = var.hostname
  }
}

data "template_file" "init_mount_mod" {
  template = file("${path.module}/../templates/cloud-init-mount.tpl")

  vars = {
    device       = var.volume_device
    label        = var.volume_label
    mount_point  = var.volume_mount_point
    mount_device = var.volume_mount_device
    filesystem   = var.volume_filesystem
  }
}

data "template_cloudinit_config" "mod" {
  base64_encode = true
  gzip          = true

  # Setup hello world script to be called by the cloud-config
  part {
    content      = data.template_file.init_mod.rendered
    content_type = "text/cloud-config"
  }

  part {
    content      = data.template_file.init_mount_mod.rendered
    content_type = "text/cloud-config"
  }
}

locals {
  tags = {
    Name = format("%s.%s", var.hostname, var.domain_name)
  }
}

resource "aws_instance" "mod" {
  ami                         = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type
  private_ip                  = var.private_ip
  subnet_id                   = var.subnet_id
  tags                        = merge(var.tags, local.tags)
  user_data                   = data.template_cloudinit_config.mod.rendered
  vpc_security_group_ids      = var.vpc_security_group_ids
  ebs_optimized               = var.ebs_optimized
  monitoring                  = var.monitoring
  disable_api_termination     = var.disable_api_termination

  volume_tags = {
    Name = "${var.hostname}.${var.domain_name}:${var.volume_label}-${var.volume_type}"
  }

  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }

  ebs_block_device {
    delete_on_termination = var.volume_delete_on_termination
    device_name           = var.volume_device
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }
}
