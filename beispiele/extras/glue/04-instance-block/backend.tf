terraform {
  backend "s3" {
    bucket         = "terraform-training-s3-backend"
    encrypt        = true
    key            = "terrafom/instance-block"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock"
    profile        = "terraform-training"
  }
}
