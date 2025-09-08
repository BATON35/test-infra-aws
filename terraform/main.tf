module "iam" {
  source = "./modules/iam"

  eks_cluster_role_name = var.eks_cluster_role_name
  eks_node_role_name    = var.eks_node_role_name
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "eks" {
  count = var.create_eks ? 1 : 0
  
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  cluster_endpoint_public_access        = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  environment     = var.environment
}

module "jenkins_ec2" {
  source = "./modules/jenkins_ec2"
  subnet_id  = element(module.vpc.subnet_ids, 0)
  vpc_id     = module.vpc.vpc_id
  jenkins_instance_profile_name = module.iam.jenkins_instance_profile_name
}