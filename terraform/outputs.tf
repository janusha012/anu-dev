output "ec2_instance_id" {
  description = "Existing EC2 instance ID"
  value       = aws_instance.anu_dev.id
}

output "ec2_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = aws_instance.anu_dev.public_ip
}

output "ec2_private_ip" {
  description = "Private IP address of EC2 instance"
  value       = aws_instance.anu_dev.private_ip
}

output "security_group_id" {
  description = "Existing security group ID"
  value       = aws_security_group.anu_dev_sg.id
}
