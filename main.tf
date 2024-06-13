resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0f58b397bc5c1f2e8" # Specify your desired AMI ID
  instance_type          = "t2.micro"              # Specify your desired instance type
  key_name               = aws_key_pair.terra_key.key_name
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo usermod -aG docker $USER",
      "sudo chown root:docker /var/run/docker.sock",
      "sudo chmod 777 /var/run/docker.sock",
      "sudo apt-get install -y fontconfig openjdk-17-jre",
      "sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key",
      "echo \"deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/\" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" # Change to appropriate username for your AMI
      private_key = file("${path.module}/id_rsa")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "Jenkins-Docker-Server"
  }
}
