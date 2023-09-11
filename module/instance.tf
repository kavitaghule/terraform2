resource "aws_instance" "web" {
  ami           = "ami-0700df939e7249d03"
  instance_type = "t2.micro"
  key_name="demo"
  tags = {
    Name = "web"
  }
}
