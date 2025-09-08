module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  cluster_endpoint_public_access        = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs


  enable_irsa     = true

  eks_managed_node_groups = {
    spot = {
      capacity_type  = "SPOT"
      instance_types = ["t3.medium", "t3.large", "t3.small"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      ami_type = "AL2023_x86_64_STANDARD"
    }
  }

  tags = {
    Environment             = var.environment
    Project                 = "eks-demo"
    "terraform-aws-modules" = "eks"
  }
}
