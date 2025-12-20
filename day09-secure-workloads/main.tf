// Bastion Host =
// A single EC2 instance that is allowed to be accessed from the internet, 
// whose only job is to let you safely access private machines.

// SSH from my laptop → Bastion EC2 → Private EC2

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "allow SSH only from my IP and all outbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name    = "bastion-sg"
    Env     = "dev"
    Project = "day09-secure-workloads"
  }
}

resource "aws_security_group" "private_ec2_sg" {
  name   = "private_ec2_sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = {
    Name    = "private_ec2_sg"
    Env     = "dev"
    Project = "day09-secure-workloads"
  }
}

# Otherwise, bastion is unreachable
# Bastion ingress = CIDR (humans)
resource "aws_vpc_security_group_ingress_rule" "ssh_from_admin_ip" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = var.admin_ip
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Any instance with the bastion SG may SSH into private EC2s
# Private EC2 ingress = SG-to-SG (machines)
resource "aws_vpc_security_group_ingress_rule" "ssh_from_bastion" {
  security_group_id            = aws_security_group.private_ec2_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
}

// egress rules, as well
resource "aws_vpc_security_group_egress_rule" "bastion_all_out" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "private_ec2_all_out" {
  security_group_id = aws_security_group.private_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

// Bastion EC2
// Public subnet
resource "aws_instance" "bastion_ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  associate_public_ip_address = true # otherwise, you cannot SSH into it
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = var.bastion_key_name # SSH key login

  tags = {
    Name    = "bastion-ec2-public"
    Env     = "dev"
    Project = "day09-secure-workloads"
  }
}

// App EC2
// Private subnet
resource "aws_instance" "app_ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc.outputs.private_subnet_ids[0]
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.private_ec2_sg.id]
  key_name = var.bastion_key_name

  tags = {
    Name    = "app-ec2-private"
    Env     = "dev"
    Project = "day09-secure-workloads"
  }
}