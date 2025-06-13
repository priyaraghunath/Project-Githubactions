variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the dev VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for dev"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}
