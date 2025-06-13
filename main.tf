resource "aws_instance" "web" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
                user_data = <<-EOF
#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 682033504000.dkr.ecr.us-east-1.amazonaws.com
docker pull 682033504000.dkr.ecr.us-east-1.amazonaws.com/projectgitops-test:latest
docker run -d -p 80:80 682033504000.dkr.ecr.us-east-1.amazonaws.com/projectgitops-test:latest
EOF


  tags = {
    Name        = "dev-webserver-${count.index}"
    Environment = "dev"
  }
}
