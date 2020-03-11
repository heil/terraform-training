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
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
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

data "aws_vpc" "terraform-training-vpc" {
  filter {
    name   = "tag:Name"
    values = ["terraform-training-vpc"]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["terraform-training-subnet-eu-central-1a-public"]
  }
  vpc_id = data.aws_vpc.terraform-training-vpc.id
}

data "aws_security_group" "glue-02" {
  filter {
    name   = "tag:Name"
    values = ["glue-02-external-access"]
  }
  filter {
    name   = "tag:Environment"
    values = ["day-03"]
  }
}
