output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "jenkins_instance_id" {
  description = "Jenkins EC2 instance ID"
  value       = module.jenkins.instance_id
}

output "jenkins_public_ip" {
  description = "Jenkins public IP"
  value       = module.jenkins.public_ip
}

output "jenkins_url" {
  description = "Jenkins URL"
  value       = module.jenkins.jenkins_url
}

output "ssh_command" {
  description = "SSH command to connect to Jenkins"
  value       = module.jenkins.ssh_command
}

output "ssm_command" {
  description = "SSM command to connect to Jenkins"
  value       = module.jenkins.ssm_command
}