resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.class_c_vpc.id

  tags = {
    Name = "allow_tls"
  }

  dynamic "ingress" {
    for_each = toset([20,22, 80, 8080, 443])
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "TLS from VPC"
    }
  }
}

resource "aws_security_group_rule" "allow_all_traffic_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # All traffic
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_tls.id
}
