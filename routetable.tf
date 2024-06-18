resource "aws_route_table" "Class-C-route" {
  vpc_id = aws_vpc.class_c_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Class-C-internetgateway.id
  }


  tags = {
    Name = "Class-C-route"
  }
}


resource "aws_route_table_association" "class-c-table" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.Class-C-route.id
}