# fetch remote state from S3 Bucket (day10)

data "terraform_remote_state" "alb" {
  backend = "s3"

  config = {
    bucket = "terraform-state-saliou-12345"
    key    = "day10/dev/terraform.tfstate"
    region = "us-east-1"
  }
}