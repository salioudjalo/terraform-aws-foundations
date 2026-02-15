variable "environment" {
  type        = string
  description = "Variable to set the environment : prod, dev"
  default = "dev"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "To set the instance type of the EC2 instance"
  default = "t3.micro"
}

variable "ssh_key_name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
