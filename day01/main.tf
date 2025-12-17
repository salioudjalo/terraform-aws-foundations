module "security_group" {
  source = "../modules/security_group"
  security_group_name = "SG Day 2"
  security_group_description = "Security group created with Terraform"
  vpc_id_value = "vpc-0d358cf72278341dd"
  ingress_rules = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
}