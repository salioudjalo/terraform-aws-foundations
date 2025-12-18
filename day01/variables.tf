variable "environment" {
  type        = string
  description = "Variable to set the environment : prod, dev"
}

variable "region" {
  type = string
}

variable "instance_type" {
  type        = string
  description = "To set the instance type of the EC2 instance"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0d358cf72278341dd"
}

variable "subnet_id" {
  type = string
}

variable "ssh_key_name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
