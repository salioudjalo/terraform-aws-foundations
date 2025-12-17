data "aws_ami" "amazon_linux" {
  most_recent = true
  name_regex  = "al2023-ami-"
  owners      = ["amazon"]

  // ami name : al2023-ami-2023.9.20251208.0-kernel-6.1-x86_64
  // ami id : ami-068c0051b15cdb816 

}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip
  user_data                   = var.user_data
  tags = merge(
    { Name = var.instance_name },
    var.tags
  )
}
