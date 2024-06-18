resource "aws_vpc" "class_c_vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "Class-c-vpc"
  }
}

resource "aws_subnet" "public_subnets" {

  count = length(var.public_subnet_cidrs)

  vpc_id = aws_vpc.class_c_vpc.id

  cidr_block = element(var.public_subnet_cidrs, count.index)

  availability_zone = element(var.availabilityzone, count.index)

  map_public_ip_on_launch = true


  tags = {

    Name = "Public Subnet ${count.index + 1}"

  }

}



resource "aws_subnet" "private_subnets" {

  count = length(var.private_subnet_cidrs)

  vpc_id = aws_vpc.class_c_vpc.id

  cidr_block = element(var.private_subnet_cidrs, count.index)

  availability_zone = element(var.availabilityzone, count.index)

  tags = {

    Name = "Private Subnet ${count.index + 1}"

  }

}



# resource "aws_subnet" "my_subnet" {
#   vpc_id                  = aws_vpc.class_c_vpc.id
#   cidr_block              = "192.168.100.0/24"
#   availability_zone       = "ap-south-1a"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "class-c-vpc"
#   }
# }