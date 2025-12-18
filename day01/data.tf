data "aws_vpc" "fetch_vpc" {}

data "aws_security_group" "default_sg" {
  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.fetch_vpc.id]
  }
}

data "aws_subnets" "list_subnet" {
  filter {
    name   = "vpc-id" // keep the tag vpc-id
    values = [data.aws_vpc.fetch_vpc.id]
  }
}

