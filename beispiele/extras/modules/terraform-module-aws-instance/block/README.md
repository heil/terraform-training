# Module terraform-modules-aws-instance - block_device

A terraform module to provide an instance with a mounted block device in AWS, provisoned by Chef.

## Module Input Variables

- `ami` - (Required) The AMI to use for the instance.
- `associate_public_ip_address` - (Optional) Wether to associate a public IP address with an instance in a VPC. Defaults to "true".
- `domain_name` - (Required) The DNS domain name of the instance..
- `hostname` - (Required) The DNS short name of the instance without the domain part.
- `instance_type` - (Required) The type of instance to start.
- `private_ip` - (Required) The private IP address to associate with the instance in a VPC.
- `subnet_id` - (Required) The VPC Subnet ID to launch in.
- `tags` - (Optional) Dictionary of tags that will be added to all resources created by the module. Defaults to an empty map.
- `vpc_security_group_ids` - (Required) A list of security group IDs to associate with.
- `volume_delete_on_termination` - (Optional) Whether the volume should be destroyed on instance termination. Defaults to "false".
- `volume_device` - (Required) The name of the device to mount.
- `volume_label` - (Required) A human-readable label assigned to a volume mount point.
- `volume_mount_point` - (Required) The mount point where the volume is mounted in the instance.
- `volume_size` - (Required) The size of the volume in gigabytes.
- `volume_type` - (Optional) The type of the volume, default gp2, standard, io1 is possible

## Usage

```lang=hcl
provider "aws" {
  profile = "comvel"
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
  source = "../terraform-module-aws-instance//block"

  ami                                 = data.aws_ami.ubuntu.id
  associate_public_ip_address         = true
  domain_name                         = "remote.cloud"
  hostname                            = "instance2"
  instance_type                       = "t2.small"
  private_ip                          = "10.10.0.101"
  subnet_id                           = "subnet-9d4a7b6c"
  volume_device                       = "/dev/xvdh"
  volume_label                        = "ftp"
  volume_mount_point                  = "/var/lib/ftp"
  volume_size                         = "20"
  volume_type                         = "gp2"
  vpc_security_group_ids              = ["sg-903004f8", "sg-1a2b3c4d"]
}
```

## Outputs

- `id` - The ID of the instance.
