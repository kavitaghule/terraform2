provider "aws" {
  region     = "ap-south-1"
  secret_key = ""
  access_key = ""
}
module "aws_instance" {
  source = "./module/"
}

