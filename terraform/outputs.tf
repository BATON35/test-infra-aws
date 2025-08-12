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
output "eks_cluster_role_arn" {
  value = module.iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  value = module.iam.eks_node_role_arn
}
