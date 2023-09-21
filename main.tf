provider "aws" {
  region     = "ap-south-1"
  secret_key = ""
  access_key = ""
}
module "aws_instance" {
  source = "/opt/project/module/"
}
module "vpc" {
  source = "/opt/project/module/"
}
module "sg" {
  source = "/opt/project/module/"
}
module "key_pair" {
  source = "/opt/project/module/"
}

