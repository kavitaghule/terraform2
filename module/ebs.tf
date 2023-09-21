resource "aws_ebs_volume" "ebs" {
  availability_zone = "ap-south-1a"
  size              = 20

  tags = {
    Name = "ebs"
  }
}
