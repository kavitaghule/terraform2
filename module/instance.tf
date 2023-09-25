resource "aws_instance" "web" {
  ami           = "ami-0700df939e7249d03"
  instance_type = "t2.micro"
  key_name="demo"
subnet_id = aws_subnet.public_sub1.id
security_groups      = [aws_security_group.sg2.id]
  tags = {
    Name = "web"
  }
}
