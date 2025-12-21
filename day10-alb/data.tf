# fetch remote state from S3 Bucket (day08)
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "terraform-state-saliou-12345"
    key    = "day08/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

# fetch remote state from S3 Bucket (day09)
data "terraform_remote_state" "compute" {
  backend = "s3"

  config = {
    bucket = "terraform-state-saliou-12345"
    key    = "day09/dev/terraform.tfstate"
    region = "us-east-1"
  }
}