module "iam" {
  source = "./modules/iam"
}

# module "eks" {
#   source        = "./modules/eks"
#   cluster_name  = var.cluster_name
#   vpc_id        = module.vpc.vpc_id
#   subnet_ids    = module.vpc.public_subnets
# }
