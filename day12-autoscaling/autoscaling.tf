# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
# Provides an Auto Scaling Group resource.

resource "aws_autoscaling_group" "asg" {
  availability_zones = ["us-east-1a","us-east-1b"]
  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  target_group_arns = [data.terraform_remote_state.alb.outputs.app_tg_arn]
  
  min_size           = 1
  desired_capacity   = 2
  max_size           = 3
  
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ec2-asg"
    propagate_at_launch = true
  }

}