# output "eks_cluster_name" {
#   value = module.eks.cluster_name
# }
#
# output "ecr_repo_urls" {
#   value = module.ecr.repository_urls
# }
#
# output "bastion_public_ip" {
#   value = module.ec2_bastion.public_ip
# }

output "vpc_subnet_ids" {
  description = "List of subnet IDs created in VPC"
  value       = module.vpc.subnet_ids
}


output "eks_cluster_role_arn" {
  value = module.iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  value = module.iam.eks_node_role_arn
}

output "jenkins_instance_id" {
  description = "Jenkins EC2 instance ID for SSM connection"
  value       = module.jenkins_ec2.instance_id
}

output "jenkins_public_ip" {
  description = "Jenkins EC2 public IP"
  value       = module.jenkins_ec2.public_ip
}
