output "instance_id" {
  description = "EC2 instance ID for SSM connection"
  value       = module.ec2_jenkins.id
}

output "public_ip" {
  description = "EC2 public IP address"
  value       = module.ec2_jenkins.public_ip
}

output "ssm_connect_command" {
  description = "Command to connect via SSM Session Manager"
  value       = "aws ssm start-session --target ${module.ec2_jenkins.id}"
}

output "jenkins_url" {
  description = "Jenkins URL"
  value       = module.ec2_jenkins.public_ip != null ? "http://${module.ec2_jenkins.public_ip}:8080" : "IP not yet assigned"
}