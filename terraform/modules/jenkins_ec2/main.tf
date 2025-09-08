data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_security_group" "jenkins" {
  name_prefix = "jenkins-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["5.173.0.0/16"]
    description = "Jenkins UI access"
  }

  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["5.173.26.0/24"]
  #   description = "SSH/EC2 Instance Connect access - TEST"
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name    = "jenkins-security-group"
    Project = "jenkins"
  }
}

module "ec2_jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name               = "jenkins-ec2"
  ami                = data.aws_ami.amazon_linux.id
  instance_type      = "t3.micro"
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  associate_public_ip_address = true
  
  # SSM Session Manager for secure access (no SSH key needed)
  iam_instance_profile = var.jenkins_instance_profile_name
  
  # Spot instance for cost savings
  create_spot_instance = true
  spot_price          = "0.0050"  # Max $0.005/hour
  spot_type           = "persistent"
  
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    # Install Java 17 - Amazon Linux 2023
    dnf install java-17-amazon-corretto -y
    
    # Install wget first
    dnf install -y wget
    
    # Install Jenkins
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    dnf install -y jenkins
    
    # Start Jenkins
    systemctl start jenkins
    systemctl enable jenkins
    
    # Install Git and Docker
    dnf install -y git docker
    systemctl start docker
    systemctl enable docker
    usermod -a -G docker jenkins
  EOF
  )

  tags = {
    Project = "jenkins"
  }
  

}
