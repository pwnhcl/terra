resource "aws_internet_gateway" "Class-C-internetgateway" {
  vpc_id = aws_vpc.class_c_vpc.id

  tags = {
    Name = "Class-C-internetgateway"
  }
}