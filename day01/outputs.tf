output "environment" {
  value = var.environment
}
output "ec2_private_ip" {
  value = module.ec2.private_ip
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}