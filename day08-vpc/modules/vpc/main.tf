# Provides a VPC resource.
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.project_name
    Env  = var.environment
  }

}

# Provides an VPC public subnet resource.
resource "aws_subnet" "public_subnets" {
  count                   = local.nb_of_public_subnets
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = local.derived_subnet_cidrs[count.index]
  availability_zone       = local.az_list[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name   = "${var.project_name}-public-${count.index + 1}"
    Env    = var.environment
    Subnet = "public"
  }
}

# Provides an VPC private subnet resource.
resource "aws_subnet" "private_subnets" {
  count                   = local.nb_of_private_subnets
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = local.derived_subnet_cidrs[count.index + 2]
  availability_zone       = local.az_list[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name   = "${var.project_name}-private-${count.index + 1}"
    Env    = var.environment
    Subnet = "private"
  }
}

