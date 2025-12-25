
// app_ec2 removed because we are now using auto-scaling group
/*
output "app_ec2_id" {
  value = aws_instance.app_ec2.id
}
*/

// we don't need bastion host anymore, we prefer to use SSM Session Manager now
/*
output "bastion_ec2_id" {
  value = aws_instance.bastion_ec2.id
}
*/

output "app_ec2_sg_id" {
  value = aws_security_group.private_ec2_sg.id
}