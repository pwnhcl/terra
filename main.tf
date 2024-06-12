resource "aws_instance" "ec2_instance" {
  ami           = "ami-0f58b397bc5c1f2e8" # Specify your desired AMI ID
  instance_type = "t2.micro"              # Specify your desired instance type
  key_name      = aws_key_pair.terra_key.key_name
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [ aws_security_group.allow_tls.id ]

  user_data = <<-EOF
  #!/bin/bash
  # Update and install prerequisite packages
  sudo apt-get update
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    openjdk-11-jdk

  # Install Docker
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io

  # Add the current user to the docker group
  sudo usermod -aG docker $USER
  sudo chown root:docker /var/run/docker.sock
  sudo chmod 777 /var/run/docker.sock


  # Install Jenkins
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  sudo apt-get update
  sudo apt-get install -y jenkins

  # Start and enable Jenkins service
  sudo systemctl start jenkins
  sudo systemctl enable jenkins
  EOF

  tags = {
    Name = "Jenkins-Docker-Server"
  }
}