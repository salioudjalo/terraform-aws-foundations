module "security_group" {
  source = "./modules/security_group"

  security_group_name        = "${var.environment}-sg-day2"
  security_group_description = "Security group created with Terraform"
  vpc_id                     = var.vpc_id

  inbound_rules_ipv4 = {
    ssh = {
      cidr_ipv4   = "86.99.90.165/32"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      description = "SSH from my IP address"
    }
    http = {
      cidr_ipv4   = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      description = "HTTP from 0.0.0.0/0"
    }
  }

  outbound_rules_ipv4 = {
    all = {
      cidr_ipv4   = "0.0.0.0/0"
      protocol    = "-1" // means all
      from_port   = -1
      to_port     = -1
      description = "HTTP from 0.0.0.0/0 (outbound)"

    }
  }

  tags = {
    Name = "Day02"
    Env  = var.environment
    Team = "SD"
  }

}


module "ec2" {
  source = "./modules/ec2"

  // INPUT
  instance_name          = "${var.environment}-ec2-day2"
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.security_group.vpc_security_group_id]
  key_name               = var.ssh_key_name
  associate_public_ip    = false
  user_data              = <<-EOF
    #!/bin/bash
    yum update -y
    dnf install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from Terraform Day 3</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Env  = var.environment
    Team = "SD"
  }

}
