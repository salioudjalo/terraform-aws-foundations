# fetch remote state from S3 Bucket (day12)
data "terraform_remote_state" "autoscaling" {
  backend = "s3"

  config = {
    bucket = "terraform-state-saliou-12345"
    key    = "day12/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
