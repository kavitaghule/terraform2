# no need to make key if already exist 
# in instace specify keyname which in present on aws console
#vi demo.pem = copy key in that
#chmod 400 demo.pem
#ssh -i ....



resource "aws_key_pair" "demo" {
  key_name   = "demo"
  public_key = file("/root/.ssh/id_rsa.pub")
}
