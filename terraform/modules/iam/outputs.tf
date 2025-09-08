output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "eks_cluster_role_name_used" {
  value = var.eks_cluster_role_name
}

output "jenkins_instance_profile_name" {
  description = "Jenkins EC2 instance profile name for SSM access"
  value       = aws_iam_instance_profile.jenkins_ec2_profile.name
}

