terraform {
  backend "s3" {
    bucket       = "terraform-state-saliou-12345"
    key          = "day11/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}