locals {
  nb_of_public_subnets  = 2
  nb_of_private_subnets = 2
  az_list               = var.availability_zones
  derived_subnet_cidrs = [
    for i in range(local.nb_of_public_subnets + local.nb_of_private_subnets) :
    cidrsubnet(var.vpc_cidr, 8, i)
  ]

  /*
  What “derived subnet CIDRs” actually means?

  You start with one big network

  From that one block, you must cut smaller, non-overlapping blocks:
  public subnet A, public subnet B, private subnet A, private subnet B
  These smaller blocks are derived from the VPC CIDR.

  You are not inventing new IP ranges.
  You are mathematically splitting the VPC CIDR.

  Terraform forbids guessing CIDRs. Terraform gives you: cidrsubnet()

  Parameter 2 — newbits
  How many bits you add to the mask.
  Example:
  VPC /16
  Want subnets /24
  Math: 24 - 16 = 8

  Parameter 3 — netnum
  Which subnet index you want.
  Think:
  Subnet 0 → cidrsubnet(VPC, 8, 0)
  Subnet 1 → cidrsubnet(VPC, 8, 1)
  Subnet 2 → cidrsubnet(VPC, 8, 2)
  Subnet 3 → cidrsubnet(VPC, 8, 3)
  you can say: first 2 → public, next 2 → private
  Each netnum gives a different subnet, non-overlapping.

  */

}