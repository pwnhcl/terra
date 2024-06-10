resource "aws_vpc" "class_c_vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.class_c_vpc.id
  cidr_block        = "192.168.100.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "class-c-vpc"
  }
}