# Provides an EC2 launch template resource. Can be used to create instances or auto scaling groups.
resource "aws_launch_template" "ec2_template" {

  # Required pieces : *AMI, *Instance type, *Security Group, Key pair, *User data, IAM  
  name                   = "day12-lt"
  image_id               = data.aws_ami.amazon_linux.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.terraform_remote_state.compute.outputs.app_ec2_id] # Your private EC2 SG (NOT bastion, NOT ALB)
  key_name               = aws_key_pair.deployer.key_name
  user_data              = file("./user_data.sh")
  tags = {
    Name    = "day12-lt"
    Env     = "dev"
    Project = "day12-autoscaling"
  }

}

# I need to generate a key_pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file(var.ssh_public_key_path)
}