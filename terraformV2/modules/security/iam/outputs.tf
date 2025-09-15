output "instance_profile_name" {
  description = "EC2 instance profile name"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "role_arn" {
  description = "IAM role ARN"
  value       = aws_iam_role.ec2_ssm_role.arn
}