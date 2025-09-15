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
  name_prefix = "${var.environment}-jenkins-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Jenkins UI"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound"
  }

  tags = {
    Name        = "${var.environment}-jenkins-sg"
    Environment = var.environment
    Application = "jenkins"
  }
}

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  iam_instance_profile   = var.instance_profile_name
  
  associate_public_ip_address = true
  
  # Spot instance configuration
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price                      = "0.01"  # $0.01/hour max
      spot_instance_type             = "persistent"
      instance_interruption_behavior = "stop"
    }
  }
  
  root_block_device {
    volume_type = "gp3"
    volume_size = 10  # 10GB - minimum dla Jenkins+Docker
    encrypted   = true
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    environment = var.environment
  }))

  tags = {
    Name        = "${var.environment}-jenkins"
    Environment = var.environment
    Application = "jenkins"
  }
}