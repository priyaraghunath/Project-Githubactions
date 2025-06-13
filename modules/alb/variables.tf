variable "subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the ALB"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for the ALB"
}

variable "instance_ids" {
  type        = list(string)
  description = "List of EC2 instance IDs to register with the target group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
}

variable "environment" {
  type        = string
  description = "dev"
}
