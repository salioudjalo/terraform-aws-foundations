variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0d358cf72278341dd"
}

variable "subnet_id" {
  type = string
  default = null
}

variable "ssh_key_name" {
  type = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
