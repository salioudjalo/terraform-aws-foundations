variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
