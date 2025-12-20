terraform {
  backend "s3" {
    bucket       = "terraform-state-saliou-12345"
    key          = "day08/vpc/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}