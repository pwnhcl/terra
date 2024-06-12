resource "aws_key_pair" "terra_key" {
  key_name   = "terra_key"
  public_key = file("${path.module}/id_rsa.pub")
}