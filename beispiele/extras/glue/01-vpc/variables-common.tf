variable "public_subnets" {
  type = map
  default = {
    training = [
      "10.0.0.0/22"
      # "10.0.4.0/22",
      #   "10.0.8.0/22"
    ]
    ops = [
      "10.48.0.0/14"
    ]
  }
}

variable "private_subnets" {
  type = map
  default = {
    training = [
      "10.0.12.0/22"
      # "10.0.16.0/22",
      # "10.0.20.0/22"
    ]
    ops = [
      "10.48.0.0/14"
    ]
  }
}

variable "aws_profile" {

}

variable "aws_region" {
  default = "eu-central-1"
}

variable "availability_zones" {
  description = "List of AZs in which to distribute subnets."
  type        = "list"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "cidr_block" {
  type = map
  default = {
    training = "10.0.0.0/19"
    ops      = "10.0.32.0/19"
  }
}

variable "domain_name" {
  description = "The suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the /etc/resolv.conf file of EC2 instances."
}

variable "domain_name_servers" {
  description = "List of name servers to configure in /etc/resolv.conf file of EC2 instances."
  type        = "list"
}

variable "name" {
  description = "Name to be used on all the resources created by the module."
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "namespace" {
  default = "terraform"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage for the VPC label, e.g. 'prod', 'staging', 'dev'"
}
