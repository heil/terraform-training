data "aws_vpc" "example-02" {
  filter {
    name   = "tag:Name"
    values = ["example-02"]
  }
}

data "aws_subnet" "subnet-02" {
  filter {
    name   = "tag:Name"
    values = ["example-02-subnet-02"]
  }
  vpc_id = data.aws_vpc.example-02.id
}

data "aws_subnet" "subnet-03" {
  filter {
    name   = "tag:Name"
    values = ["example-02-subnet-03"]
  }
  vpc_id = data.aws_vpc.example-02.id
}

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
