resource "aws_instance" "ec2_instance" {
  ami           = "ami-0f58b397bc5c1f2e8" # Specify your desired AMI ID
  instance_type = "t2.micro"              # Specify your desired instance type
  key_name      = aws_key_pair.terra_key.key_name
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [ aws_security_group.allow_tls.id ]

  tags = {
    Name = "server1" # Set a name tag for your instance
  }
}