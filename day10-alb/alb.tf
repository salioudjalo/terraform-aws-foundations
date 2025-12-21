# instance Target Group

resource "aws_lb_target_group" "app_tg" {
  name        = "day10-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance" # The default is instance.

  // Yes, you absolutely need a health check.
  // https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group#health_check
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200" # code : 200 → healthy
    interval            = 30    # Every 30 seconds, the ALB checks again.
    timeout             = 6     # The EC2 must respond within 6 seconds.
    healthy_threshold   = 3     # The EC2 must pass 3 consecutive checks to become healthy.
    unhealthy_threshold = 3     # The EC2 must fail 3 consecutive checks to be removed.

  }

  tags = {
    Name    = "day10-app-tg"
    Env     = "dev"
    Project = "day10-alb"
  }

}

# add ec2 (private app ec2) to target group
resource "aws_lb_target_group_attachment" "app_ec2" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = data.terraform_remote_state.compute.outputs.app_ec2_id
  port             = 80
}

# Provides a Load Balancer Listener resource.
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}