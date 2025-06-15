resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, 0)
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Welcome to Priya's Web Page - ${var.environment} Environment</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.environment}-ec2-instance"
  }
}
