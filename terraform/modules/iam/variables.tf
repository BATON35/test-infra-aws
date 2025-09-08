variable "eks_cluster_role_name" {
  type        = string
  default     = "eks-cluster-role"
  description = "Name of the IAM role for EKS control plane"
}

variable "eks_node_role_name" {
  type        = string
  default     = "eks-node-role"
  description = "Name of the IAM role for EKS worker nodes"
}
