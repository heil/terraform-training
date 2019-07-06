data "template_file" "web-02" {
  template = file("templates/cloud-init.tpl")

  vars = {
    domain_name = "acme.local"
    hostname    = "web-02"
  }
}

data "template_cloudinit_config" "web-02" {
  base64_encode = true
  gzip          = true

  part {
    content      = data.template_file.web-02.rendered
    content_type = "text/cloud-config"
  }
}

resource "aws_instance" "web-02" {
  ami                         = data.aws_ami.bionic.id
  associate_public_ip_address = false
  instance_type               = "t2.nano"
  key_name                    = "example-03"
  private_ip                  = "10.10.2.32"
  subnet_id                   = data.aws_subnet.subnet-02.id
  user_data                   = data.template_cloudinit_config.web-02.rendered
  vpc_security_group_ids      = [aws_security_group.lamp-web.id]

  tags = {
    Name        = "web-02"
    Description = "Instance example-web-02"
    Environment = "day-03"
  }

  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sleep 20",
      "sudo apt-get -y update",
      "sudo sleep 20",
      "sudo apt-get -y install ansible",
    ]

    connection {
      host        = aws_instance.web-02.private_ip
      type        = "ssh"
      agent       = "false"
      private_key = file("~/.ssh/id_rsa.aws")
      user        = "ubuntu"
    }
  }
}
