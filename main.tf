resource "aws_instance" "ec2_public" {
  count = length(var.public_subnet_cidrs)
  ami                    = var.ami_id        # Specify your desired AMI ID
  instance_type          = var.instance_type # Specify your desired instance type
  key_name               = aws_key_pair.terra_key.key_name
  subnet_id              = aws_subnet.public_subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  
  tags = {
    Name = "Public Server ${count.index + 1}"
  }
}


resource "aws_instance" "ec2_private" {
  count = length(var.private_subnet_cidrs)
  ami                    = var.ami_id        # Specify your desired AMI ID
  instance_type          = var.instance_type # Specify your desired instance type
  key_name               = aws_key_pair.terra_key.key_name
  subnet_id              = aws_subnet.private_subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

tags = {
    Name = "Private Server ${count.index + 1}"
  }
}

