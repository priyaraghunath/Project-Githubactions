resource "aws_instance" "web" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "Hello World from $(hostname -f)" > /var/www/html/index.html
              EOF

  tags = {
    Name        = "dev-webserver-${count.index}"
    Environment = var.environment
  }
}
