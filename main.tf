provider "aws" {
  region     = "ap-south-1"
  secret_key = "5iV1H/E78KffCpLpb5OSUQyIA3Jo+UdmirtN3SzJ"
  access_key = "AKIAQ77XQSQMWBY23TXU"
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

