output "ec2_public_ip" {
  value = [for instance in aws_instance.ec2_public : instance.public_ip]
}

output "ec2_private_ip" {
  value = [for instance in aws_instance.ec2_private : instance.private_ip]
}
