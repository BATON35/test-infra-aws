variable "subnet_id" {
  description = "Subnet ID for Jenkins EC2"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security group"
  type        = string
}

variable "jenkins_instance_profile_name" {
  description = "IAM instance profile name for SSM access"
  type        = string
}