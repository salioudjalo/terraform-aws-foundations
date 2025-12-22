# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate

# ACM Certificate for HTTPS (ALB)
resource "aws_acm_certificate" "cert" {
  domain_name               = "leadrisehq.com"
  subject_alternative_names = ["*.leadrisehq.com"] // to handle sub-domains as well
  validation_method         = "DNS"

  tags = {
    Name    = "day11-https"
    Env     = "dev"
    Project = "day11-https"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# HTTPS Listener (port 443)
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = data.terraform_remote_state.alb.outputs.alb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-PQ-2025-09" # Recommended
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = data.terraform_remote_state.alb.outputs.app_tg_arn
  }
}
