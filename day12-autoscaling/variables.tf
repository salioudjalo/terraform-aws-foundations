variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/deployer-key"
}

variable "lt_key_name" {
  description = "Key pair name for SSH (generated from the AWS console)"
  type        = string
  default     = "launch-template-key"
}