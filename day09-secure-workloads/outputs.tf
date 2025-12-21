output "app_ec2_id" {
  value = aws_instance.app_ec2.id
}

output "bastion_ec2_id" {
  value = aws_instance.bastion_ec2.id
}