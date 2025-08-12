variable "aws_region" {
  description = "Region AWS"
  type        = string
}

variable "cluster_name" {
  description = "Nazwa klastra EKS"
  type        = string
}

# variable "vpc_cidr" {
#   description = "CIDR dla VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }
#
# variable "ecr_repositories" {
#   description = "Lista repozytoriów ECR"
#   type        = list(string)
#   default     = ["jenkins", "microservice-a", "microservice-b"]
# }
