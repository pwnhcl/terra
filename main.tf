resource "aws_instance" "ec2_instance" {
  ami           = "ami-0f58b397bc5c1f2e8"  # Specify your desired AMI ID
  instance_type = "t2.micro"               # Specify your desired instance type
  key_name = aws_key_pair.terra_key.public_key
  subnet_id = aws_vpc.class_c_vpc.id

  tags = {
    Name = "server1"  # Set a name tag for your instance
  }
}