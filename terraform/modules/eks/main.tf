# resource "aws_eks_cluster" "this" {
#   name     = var.cluster_name
#   role_arn = var.cluster_role_arn
#
#   vpc_config {
#     subnet_ids         = var.subnet_ids
#     security_group_ids = [aws_security_group.eks.id]
#     endpoint_private_access = true
#     endpoint_public_access  = true
#   }
#
#   version = var.cluster_version
#
#   tags = {
#     Name = var.cluster_name
#   }
# }
#
# resource "aws_eks_node_group" "default" {
#   cluster_name    = aws_eks_cluster.this.name
#   node_group_name = "${var.cluster_name}-default"
#   node_role_arn   = var.node_role_arn
#   subnet_ids      = var.subnet_ids
#   instance_types  = ["t3.medium"]
#
#   scaling_config {
#     desired_size = 2
#     max_size     = 4
#     min_size     = 1
#   }
#
#   tags = {
#     Name = "${var.cluster_name}-ng"
#   }
# }
#
# resource "aws_security_group" "eks" {
#   name        = "${var.cluster_name}-eks-sg"
#   description = "Security group for EKS cluster"
#   vpc_id      = var.vpc_id
#
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name = "${var.cluster_name}-sg"
#   }
# }
#
# data "aws_eks_cluster" "this" {
#   name = aws_eks_cluster.this.name
# }
#
# data "aws_eks_cluster_auth" "this" {
#   name = aws_eks_cluster.this.name
# }
#
# output "cluster_endpoint" {
#   value = data.aws_eks_cluster.this.endpoint
# }
#
# output "oidc_url" {
#   value = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
# }
#
# output "oidc_arn" {
#   value = aws_eks_cluster.this.identity[0].oidc[0].issuer
# }
