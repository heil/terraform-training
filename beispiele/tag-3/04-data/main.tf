# Siehe https://www.terraform.io/docs/providers/aws/d/ami.html

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

output "architecture" {
  value = data.aws_ami.bionic.architecture
}

output "image_id" {
  value = data.aws_ami.bionic.image_id
}
