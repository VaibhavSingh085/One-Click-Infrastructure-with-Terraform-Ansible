output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.web.public_ip
}

output "ssh_command" {
  description = "SSH command to connect to the web server"
  value       = "ssh -i ${pathexpand(var.ssh_private_key_path)} ubuntu@${aws_instance.web.public_ip}"
}
