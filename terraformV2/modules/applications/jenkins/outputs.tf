output "instance_id" {
  description = "Jenkins EC2 instance ID"
  value       = aws_instance.jenkins.id
}

output "public_ip" {
  description = "Jenkins public IP"
  value       = aws_instance.jenkins.public_ip
}

output "private_ip" {
  description = "Jenkins private IP"
  value       = aws_instance.jenkins.private_ip
}

output "jenkins_url" {
  description = "Jenkins URL"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}

output "ssh_command" {
  description = "SSH command to connect to Jenkins"
  value       = "ssh ec2-user@${aws_instance.jenkins.public_ip}"
}

output "ssm_command" {
  description = "SSM command to connect to Jenkins"
  value       = "aws ssm start-session --target ${aws_instance.jenkins.id}"
}