# Provides an Auto Scaling Group resource.

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  target_group_arns   = [data.terraform_remote_state.alb.outputs.app_tg_arn]

  min_size         = 1
  desired_capacity = 2
  max_size         = 3

  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = var.extra_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

}