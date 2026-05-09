resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-web-sg"
  description = "Security group for web server"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound"
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }
}

resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = var.instance_profile_name

  user_data = <<-EOF
            #!/bin/bash
            apt-get update -y
            apt-get install -y apache2
            systemctl start apache2
            systemctl enable apache2
            echo "<h1>Deployed by Terraform - Deepika</h1>" > /var/www/html/index.html
            EOF

  tags = {
    Name        = "${var.project_name}-web-server"
    Environment = var.environment
  }
}
