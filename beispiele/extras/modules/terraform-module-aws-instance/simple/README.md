# Module terraform-modules-aws-instance - provisionerless

A terraform module to provide an instance in AWS without any provisioning

## Module Input Variables

- `ami` - (Required) The AMI to use for the instance.
- `associate_public_ip_address` - (Optional) Wether to associate a public IP address with an instance in a VPC. Defaults to "true".
- `connection_private_key` - (Required) The contents of an SSH key to use for the connection.
- `connection_user` - (Required) The user that should be used for the SSH connection.
- `domain_name` - (Required) The DNS domain name of the instance..
- `hostname` - (Required) The DNS short name of the instance without the domain part.
- `instance_type` - (Required) The type of instance to start.
- `private_ip` - (Required) The private IP address to associate with the instance in a VPC.
- `subnet_id` - (Required) The VPC Subnet ID to launch in.
- `tags` - (Optional) Dictionary of tags that will be added to all resources created by the module. Defaults to an empty map.
- `vpc_security_group_ids` - (Required) A list of security group IDs to associate with.

## Usage

```lang=hcl
provider "aws" {
  profile = "terraform"
  region  = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "instance" {
  source = "../terraform-module-aws-instance//provisionerless"

  ami                                 = data.aws_ami.ubuntu.id
  associate_public_ip_address         = true
  domain_name                         = "remote.cloud"
  hostname                            = "instance2"
  instance_type                       = "t2.small"
  private_ip                          = "10.10.0.101"
  subnet_id                           = "subnet-9d4a7b6c"
  vpc_security_group_ids              = ["sg-903004f8", "sg-1a2b3c4d"]
}
```

## Outputs

- `id` - The ID of the instance.
- `private_ip` - The private_ip of the instance.
