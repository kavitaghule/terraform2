resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
enable_dns_support = "true"
enable_dns_hostnames =true
  tags = {
    Name = "main"
  }

}
# Public subnet for web

resource "aws_subnet" "public_sub1" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1a"
  cidr_block = "10.0.1.0/24"
map_public_ip_on_launch =true
  tags = {
    Name = "public_sub1"
  }
}

resource "aws_subnet" "public_sub2" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1b"
  cidr_block = "10.0.2.0/24"
map_public_ip_on_launch =true
  tags = {
    Name = "public_sub2"
  }

}
# private subnets for app

resource "aws_subnet" "private_sub3" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1a"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "private_sub3"
  }
}
resource "aws_subnet" "private_sub4" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1b"
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "private_sub4"
  } 
}

# private subnets for database
resource "aws_subnet" "private_sub5" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1a"
  cidr_block = "10.0.5.0/24"
  tags = {
    Name = "private_sub5"
  }
}
resource "aws_subnet" "private_sub6" {
  vpc_id     = aws_vpc.main.id
 availability_zone = "ap-south-1b"
  cidr_block = "10.0.6.0/24"
  tags = {
    Name = "private_sub6"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}
resource "aws_route_table" "public_web-rt" {
  vpc_id = aws_vpc.main.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

   tags = {
    Name = "public_rt1"
  }
 }   
resource "aws_route_table_association" "public-web-sub1"{
    subnet_id = aws_subnet.public_sub1.id
    route_table_id = aws_route_table.public_web-rt.id
}
resource "aws_route_table_association" "public_sub2"{
    subnet_id = aws_subnet.public_sub2.id
    route_table_id = aws_route_table.public_web-rt.id
}

# Private routes
resource "aws_route_table" "private_app_rt" {
    vpc_id = aws_vpc.main.id

    route {        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }
    tags = {
        Name = "private_app_rt"
    }
}
resource "aws_route_table_association" "private_app_sub3"{
    subnet_id = aws_subnet.private_sub3.id
    route_table_id = aws_route_table.private_app_rt.id
}
resource "aws_route_table_association" "private_app_sub4"{
    subnet_id = aws_subnet.private_sub4.id
    route_table_id = aws_route_table.private_app_rt.id
}


# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "nat_gateway" {
    vpc = true
}
resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id     = aws_subnet.public_sub1.id

    tags = {
    Name = "nat-gateway"
    }

    # To ensure proper ordering, add Internet Gateway as dependency
    depends_on = [aws_internet_gateway.igw]
}
# Private routes
resource "aws_route_table" "private_db_rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id 
    }
    tags = {
        Name = "private_db_rt"
    }
}
resource "aws_route_table_association" "private_db_sub5"{
    subnet_id = aws_subnet.private_sub5.id
    route_table_id = aws_route_table.private-app-rt.id
}
resource "aws_route_table_association" "private_db_sub6"{
    subnet_id = aws_subnet.private_sub6.id
    route_table_id = aws_route_table.private-db-rt.id
}
