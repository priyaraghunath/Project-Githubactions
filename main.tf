provider "aws" {
  region = var.aws_region
}

# Latest Amazon Linux AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  environment         = var.environment
}

module "security_group" {
  source           = "./modules/security_group"
  vpc_id           = module.vpc.vpc_id
  environment      = var.environment
  alb_ingress_cidr = ["0.0.0.0/0"]
  ec2_ingress_cidr = [var.vpc_cidr]
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = data.aws_ami.latest_amazon_linux.id
  instance_type     = var.instance_type
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_id = module.security_group.ec2_sg_id
  environment       = var.environment
}

module "alb" {
  source            = "./modules/alb"
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_id = module.security_group.alb_sg_id
  vpc_id            = module.vpc.vpc_id
  instance_ids      = module.ec2.instance_ids
  environment       = var.environment
}