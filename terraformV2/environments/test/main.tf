# Networking
module "networking" {
  source = "../../modules/networking"
  
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  az_count    = var.az_count
}

# Security - IAM
module "iam" {
  source = "../../modules/security/iam"
  
  environment = var.environment
}

# Applications - Jenkins
module "jenkins" {
  source = "../../modules/applications/jenkins"
  
  environment           = var.environment
  instance_type         = var.jenkins_instance_type
  vpc_id                = module.networking.vpc_id
  subnet_id             = module.networking.public_subnet_ids[0]
  instance_profile_name = module.iam.instance_profile_name
}