data "aws_vpc" "terraform-training-vpc" {
  filter {
    name   = "tag:Name"
    values = ["terraform-training-vpc"]
  }
}
