resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
enable_dns_hostnames =true
  tags = {
    Name = "main"
  }

}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1a"
  cidr_block = "10.0.1.0/24"
map_public_ip_on_launch =true
  tags = {
    Name = "sub1"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.main.id
   tags = {
    Name = "rt1"
  }
}
