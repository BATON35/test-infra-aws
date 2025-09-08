variable "eks_cluster_role_name" {
  type = string
}

variable "eks_node_role_name" {
  type = string
}

variable "region" {
  type    = string
}

variable "cluster_name" {
  type    = string
  default = "eks-test"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "create_eks" {
  description = "Whether to create EKS cluster"
  type        = bool
  default     = false
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "cluster_endpoint_public_access" {
  description = "Whether EKS API endpoint should be publicly accessible"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks that can access the public API endpoint"
  type        = list(string)
  # No default - each environment must specify its IP range
}