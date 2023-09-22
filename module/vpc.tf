resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
enable_dns_support = "true"
enable_dns_hostnames =true
  tags = {
    Name = "main"
  }

}
resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1a"
  cidr_block = "10.0.1.0/24"
map_public_ip_on_launch =true
  tags = {
    Name = "sub1"
  }
}
resource "aws_subnet" "pub_sub2" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1b"
  cidr_block = "10.0.2.0/24"
map_public_ip_on_launch =true
  tags = {
    Name = "sub2"
  }
}
resource "aws_subnet" "prv_sub3" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1a"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "sub3"
  }
}
resource "aws_subnet" "prv_sub4" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1b"
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "sub4"
  }
}resource "aws_subnet" "prv_sub5" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1a"
  cidr_block = "10.0.5.0/24"
  tags = {
    Name = "sub5"
  }
}
resource "aws_subnet" "prv_sub6" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1b"
  cidr_block = "10.0.6.0/24"
  tags = {
    Name = "sub6"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}
resource "aws_route_table" "pub_web-rt" {
  vpc_id = aws_vpc.main.id
  route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.igw.id 
    }

   tags = {
    Name = "pub_rt1"
  }
}
resource "aws_route_table_association" "pub-web-sub1"{
    subnet_id = aws_subnet.pub-sub1.id
    route_table_id = aws_route_table.pub_web-rt.id
}
resource "aws_route_table_association" "pub-sub1"{
    subnet_id = aws_subnet.pub-sub2.id
    route_table_id = aws_route_table.pub_web-rt.id}
}


# Private routes
resource "aws_route_table" "prv-app-rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id}" 
    }

    tags = {
        Name = "prv-app-rt"
    }
}
resource "aws_route_table_association" "prv-app-sub3"{
    subnet_id = aws_subnet.prv_sub3.id
    route_table_id = aws_route_table.prv-app-rt.id
}
resource "aws_route_table_association" "prv-app-sub4"{
    subnet_id = aws_subnet.prv_sub4.id
    route_table_id = aws_route_table.prv-app-rt.id
}
# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "nat_gateway" {
    vpc = true
}
resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id     = aws_subnet.pub_sub1.id.

    tags = {
    Name = "nat-gateway"
    }

    # To ensure proper ordering, add Internet Gateway as dependency
    depends_on = [aws_internet_gateway.igw]
}
# Private routes
resource "aws_route_table" "prv-db-rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id}" 
    }
    tags = {
        Name = "prv-app-rt"
    }
}
resource "aws_route_table_association" "prv-app-sub5"{
    subnet_id = aws_subnet.prv_sub5.id
    route_table_id = aws_route_table.prv-app-rt.id
}
resource "aws_route_table_association" "prv-app-sub6"{
    subnet_id = aws_subnet.prv_sub6.id
    route_table_id = aws_route_table.prv-app-rt.id
}
