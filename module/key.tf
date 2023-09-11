resource "aws_key_pair" "demo" {
  key_name   = "demo"
  public_key = file("/root/.ssh/id_rsa.pub")
}
