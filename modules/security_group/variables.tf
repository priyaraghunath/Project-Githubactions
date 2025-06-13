variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "alb_ingress_cidr" {
  type        = list(string)
  description = "CIDR blocks allowed to access ALB"
}

variable "ec2_ingress_cidr" {
  type        = list(string)
  description = "CIDR blocks allowed to access EC2"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}
