locals {
  first_subnet_id = data.aws_subnets.list_subnet.ids[0]
}