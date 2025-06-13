output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.web[*].id
}

output "public_ips" {
  description = "List of public IP addresses for the EC2 instances"
  value       = aws_instance.web[*].public_ip
}
